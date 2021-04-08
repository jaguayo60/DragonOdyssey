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
        userTokensLabel.text = String(User.shared.tokens)
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

        let item = K.Items.list[indexPath.row]
        cell.parentVC = self
        
        cell.amountOfItemsInInventoryL.text = String(User.shared.getItemAmount(for: item.name))
        cell.titleL.text = item.name + " gives " + String(item.energyAmount) + " energy"
        cell.tokenAmountL.text = String(item.tokenCost)
        
        if item.isAdOnly {
            cell.tokenL.text = "REWARD FROM AD"
            cell.drawOnlyFromAdsView()
            cell.tokenL.alpha = 0.5
        }
        
        
        if #available(iOS 13.0, *) {
            cell.imageV.image = K.Images.getItemImage(for: item.name)
        } else {
            // Fallback on earlier versions
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.Items.list.count
    }
    
    
}

// MARK: - Table View Delegate

extension InventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = K.Items.list[indexPath.row]
        User.shared.buyItem(name: item.name)
    }
}
