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
    
    @IBOutlet weak var itemsTV: UITableView!
    
    // MARK: - Instance variables
    
    lazy private var inventoryItems = InventoryItemsLibrary.inventoryItemsDict
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "InventoryItemTVCell", bundle: nil)
        itemsTV.register(nib, forCellReuseIdentifier: "ItemCell")
        
        drawVC()
    }
    
    // MARK: - UI
    
    func drawVC() {
        
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension InventoryVC: UITableViewDataSource
{
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

extension InventoryVC: UITableViewDelegate
{
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
