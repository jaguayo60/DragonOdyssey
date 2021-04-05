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
    
//    let user = UserService.user
//    let creature = CreatureService.creature
    lazy private var inventoryItems = InventoryItemsLibrary.inventoryItemsArray
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: DELETE core data
//        NotificationCenter.default.addObserver(self, selector: #selector(self.coreDataManagerControllerDidChangeContent), name: NSNotification.Name(rawValue: "CoreDataManager_controllerDidChangeContent"), object: nil)
        
        let nib = UINib(nibName: "InventoryItemTVCell", bundle: nil)
        itemsTV.register(nib, forCellReuseIdentifier: "ItemCell")
        
        drawVC()
    }
    
    // MARK: - UI
    
    func drawVC() {
//        userTokensL.text = "\(Int(user.tokens))"
    }
    
    // MARK: - Data Responding
    
    //TODO: Replace with Server Function calls
//    @objc func coreDataManagerControllerDidChangeContent(notification: NSNotification) {
//        drawVC()
//        itemsTV.reloadData()
//    }
    
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
        
        cell.inventoryItemDict = item
        cell.parentVC = self
        
//        if let id = item["id"] as? String { cell.amountOfItemsInInventoryL.text = String(InventoryItemService.numberOfItemsInInventoryWith(id: id)) }
        cell.titleL.text = "\(item["name"] as? String ?? "") gives \(Int(item["energyAmount"] as? Double ?? 0)) energy"
        cell.tokenAmountL.text = "\(Int(item["tokenCost"] as? Double ?? 0))"
        if let isAdOnly = item["isAdOnly"] as? Bool, isAdOnly == true {
            cell.tokenL.text = "ONLY FROM ADS" ; cell.drawOnlyFromAdsView()
            cell.tokenL.alpha = 0.5
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
        
//        guard let itemID = inventoryItemDict["id"] as? String, let item = InventoryItemService.fetchInventoryItemsWith(id: itemID)?[0] else { return }
        
//        guard creature.energyLeftBeforeMax > 0 else {
//            FuncService.showBasicAlert(title: "Whoops", message: "It looks like your energy is full, try using this item when you need energy.", btnTitle: "Okay", action: nil, controller: self)
//            return
//        }
        
//        creature.energy = (creature.energy + item.energyAmount) <= creature.totalEnergy ? creature.energy + item.energyAmount : creature.totalEnergy
        
        //TODO: Delete these lines of code, replace with server function calls
//        CoreDataService.context.delete(item)
//        CoreDataService.saveContext()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
