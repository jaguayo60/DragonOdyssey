//
//  InventoryViewController.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 3/21/21.
//  Copyright © 2021 Wired Betterment. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy private var inventoryItems = InventoryItemsLibrary.inventoryItemsArray
    let itemCellIdentifier = "ItemCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userTokensLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    func setup() {
        //TODO: set the user tokens
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - TableView Data Source

extension InventoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? InventoryItemTVCell
            else {
                return tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath)
        }

        let item = inventoryItems[indexPath.row]
        
        cell.inventoryItemDict = item
        cell.parentVC = self
        
//        if let id = item["id"] as? String { cell.amountOfItemsInInventoryL.text = String(InventoryItemService.numberOfItemsInInventoryWith(id: id)) }
        cell.amountOfItemsInInventoryL.text = "0"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryItems.count
    }
    
    
}

// MARK: - Table View Delegate

extension InventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let inventoryItemDict = inventoryItems[indexPath.row]
        
        //TODO: Server calls for when the user buys an item
    }
}
