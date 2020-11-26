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
    @IBOutlet weak var levelL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var energyCostL: UILabel!
    @IBOutlet weak var mapBGImgV: UIImageView!
    
    
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

class LevelBGV: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func commonInit() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }
}
