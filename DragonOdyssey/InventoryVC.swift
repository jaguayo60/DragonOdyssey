//
//  InventoryVC.swift
//  DragonOdyssey
//
//  Created by Jared on 10/30/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class InventoryVC: GLVC {

    // MARK: - IBOutlets
    
    @IBOutlet weak var userTokensL: UILabel!
    @IBOutlet weak var itemsTV: UITableView!
    
    // MARK: - Instance variables
    
    let user = UserService.user
    lazy private var inventoryItems = InventoryItemsLibrary.inventoryItemsDict
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.coreDataManagerControllerDidChangeContent), name: NSNotification.Name(rawValue: "CoreDataManager_controllerDidChangeContent"), object: nil)
        
        let nib = UINib(nibName: "InventoryItemTVCell", bundle: nil)
        itemsTV.register(nib, forCellReuseIdentifier: "ItemCell")
        
        drawVC()
    }
    
    // MARK: - UI
    
    func drawVC() {
        userTokensL.text = "\(Int(user.tokens))"
    }
    
    // MARK: - Purchasing
    
    private func purchase(item:[String:Any]) {
        let storedItem = InventoryItem(context: CoreDataService.context)
        
        storedItem.user = user
        if let id = item["id"] as? String { storedItem.id = id }
        if let imageName = item["imageName"] as? String { storedItem.imageName = imageName }
        if let name = item["name"] as? String { storedItem.name = name }
        if let energyAmount = item["energyAmount"] as? Double { storedItem.energyAmount = energyAmount }
        if let isAdOnly = item["isAdOnly"] as? Bool { storedItem.isAdOnly = isAdOnly }
        if let tokenCost = item["tokenCost"] as? Double { storedItem.tokenCost = tokenCost }
        if let sortPriority = item["sortPriority"] as? Double { storedItem.sortPriority = sortPriority }
        
        user.tokens = ((user.tokens - storedItem.tokenCost) >= 0) ? user.tokens - storedItem.tokenCost : 0
        CoreDataService.saveContext()
    }
    
    // MARK: - Data Responding
    
    @objc func coreDataManagerControllerDidChangeContent(notification: NSNotification) {
        drawVC()
        itemsTV.reloadData()
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension InventoryVC: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? InventoryItemTVCell
            else {
                return tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        }
        
        let item = inventoryItems[indexPath.row]
        
        if let id = item["id"] as? String { cell.amountOfItemsInInventoryL.text = String(InventoryItemService.numberOfItemsInInventoryWith(id: id)) }
        cell.titleL.text = "\(item["name"] as? String ?? "") gives \(Int(item["energyAmount"] as? Double ?? 0)) energy"
        cell.tokenAmountL.text = "\(Int(item["tokenCost"] as? Double ?? 0))"
        if let isAdOnly = item["isAdOnly"] as? Bool, isAdOnly == true {
            cell.tokenL.text = "ONLY FROM ADS" ; cell.drawOnlyFromAdsView()
        }
        
        if let imageName = item["imageName"] as? String, let image = UIImage(named: imageName) {
            cell.imageV.image = image
        }
        
        return cell
    }
}

extension InventoryVC: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let inventoryItemDict = inventoryItems[indexPath.row]
        guard let itemCost = inventoryItemDict["tokenCost"] as? Double else { return }
        if itemCost >= user.tokens {
            FuncService.showBasicAlert(title: "Whoops", message: "Looks like you don't have enough tokens to buy this item.", btnTitle: "Okay", action: nil, controller: self)
        } else {
            purchase(item: inventoryItemDict)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
