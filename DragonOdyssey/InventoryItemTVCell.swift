//
//  InventoryItemTVCell.swift
//  DragonOdyssey
//
//  Created by Jared on 10/30/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class InventoryItemTVCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var amountOfItemsInInventoryL: UILabel!
    
    @IBOutlet weak var tokenL: UILabel!
    @IBOutlet weak var tokenAmountL: UILabel!
    @IBOutlet weak var tokenCtnV: UIView!
    
    
    // MARK: - Instance variables
    
    let user = UserService.user
    var inventoryItemDict: [String:Any]?
    
    var parentVC: UIViewController?
    
    // MARK: - Class functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        tokenL.numberOfLines = 1
        tokenCtnV.isHidden = false
    }
    
    // MARK: - UI
    
    func drawOnlyFromAdsView() {
        tokenL.numberOfLines = 3
        tokenCtnV.isHidden = true
    }
    
    // MARK: - IBActions
    
    @IBAction func buy(_ sender: Any) {
        guard let inventoryItemDict = self.inventoryItemDict,
              let itemID = inventoryItemDict["id"] as? String,
              let itemCost = inventoryItemDict["tokenCost"] as? Double,
              let parentVC = parentVC
              else { return }
        
        guard itemCost <= user.tokens else {
            FuncService.showBasicAlert(title: "Whoops", message: "Looks like you don't have enough tokens to buy this item.", btnTitle: "Okay", action: nil, controller: parentVC)
            return
        }
        
        InventoryItemService.giveUserInventoryItemWith(id: itemID, purchase: true)
    }
}
