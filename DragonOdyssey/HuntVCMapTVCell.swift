//
//  HuntVCMapTVCell.swift
//  DragonOdyssey
//
//  Created by Jared on 11/18/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class HuntVCMapTVCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mapCtnV: UIView!
    @IBOutlet weak var nameL: UILabel!
    
    
    // MARK: - Class functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
