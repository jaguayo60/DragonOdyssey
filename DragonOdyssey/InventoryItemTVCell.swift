//
//  InventoryItemTVCell.swift
//  DragonOdyssey
//
//  Created by Jared on 10/30/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InventoryItemTVCell: UITableViewCell {
    
    //MARK: - Constant Strings
    let rewardAdTestId = "ca-app-pub-3940256099942544/1712485313"
    let rewardAdId = "ca-app-pub-8609620657499671/3987247240"

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
    
    var rewardedAd: GADRewardedAd?
    
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
        rewardedAd = createAndLoadRewardedAd()
    }
    
    // MARK: - IBActions
    
    @IBAction func buy(_ sender: Any) {
        guard let inventoryItemDict = self.inventoryItemDict else { return }
        
        //item is purchased with ads
        if let _ = inventoryItemDict["isAdOnly"],
           let itemID = inventoryItemDict["id"] as? String,
           let parentVC = parentVC,
           let ad = rewardedAd {
            
            //if the ad is shown, "purchase" the item
            if showAd(ad: ad, rootViewController: parentVC) {
                InventoryItemService.giveUserInventoryItemWith(id: itemID, purchase: true)
            }
        } else { // item is not purchased with ads
            
            guard let itemID = inventoryItemDict["id"] as? String,
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
}

//MARK: - Ads
extension InventoryItemTVCell: GADRewardedAdDelegate {
    
    // Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
      print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        
    }
    
    // Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        self.rewardedAd = createAndLoadRewardedAd()
    }
    
    func createAndLoadRewardedAd() -> GADRewardedAd {
        let rewardedAd = GADRewardedAd(adUnitID: rewardAdTestId)
        rewardedAd.load(GADRequest()) { error in
            if let error = error {
                print("AD Loading failed: \(error)")
            } else {
                print("AD Loading Succeeded")
                self.tokenL.alpha = 1.0
            }
        }
        return rewardedAd
    }
    
    //if the ad is ready, present the ad
    //return whether or not the ad was shown
    func showAd(ad: GADRewardedAd, rootViewController: UIViewController) -> Bool {
        if ad.isReady {
            ad.present(fromRootViewController: rootViewController, delegate: self)
            return true
        }
        
        print("Ad is NOT ready!")
        return false
    }
}
