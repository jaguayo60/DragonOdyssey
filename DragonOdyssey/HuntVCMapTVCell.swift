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
    @IBOutlet weak var mapBGImgV: UIImageView!
    
    @IBOutlet weak var detailsOverlaySV: UIStackView!
    @IBOutlet weak var levelL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var energyCostL: UILabel!
    
    @IBOutlet weak var missionActiveOverlayV: UIView!
    @IBOutlet weak var timeLeftL: UILabel!
    
    
    // MARK: - Instance Variables
    
    var huntVC: HuntVC?
    
    
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
        detailsOverlaySV.isHidden = false
        missionActiveOverlayV.isHidden = true
    }
    
    // MARK: - Timer
    
    var timeLeftTimer = Timer()

    var timeIntervalLeft: Int = 0
    
    func startTimeLeftTimerWith(startDate: Date, durationInSeconds: Double) {
        timeLeftTimer.invalidate()
        let endDate = startDate.addingTimeInterval(durationInSeconds)
        timeIntervalLeft = Int(endDate.timeIntervalSince(Date()))
        drawCounterWith(timeInterval: timeIntervalLeft)
        
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
    }
    
    @objc func counter() {
        guard timeIntervalLeft >= 0,
              UIService.topMostViewController() is HuntVC // stop timer when view is dismissed
        else {
            timeLeftTimer.invalidate()
            huntVC?.completeMission()
            return
        }
        
        print(timeIntervalLeft)
        
        timeIntervalLeft -= 1
        drawCounterWith(timeInterval: timeIntervalLeft)
    }
    
    private func drawCounterWith(timeInterval: Int) {
        guard timeInterval > 0 else {
            timeLeftL.text = "00:00:00"
            return
        }
        
//        dayL.text = String(format: "%02d", timeInterval / 86400)
        let hourString = String(format: "%02d", (timeInterval % 86400) / 60 / 60)
        let minuteString = String(format: "%02d", (timeInterval % 3600) / 60)
        let secondString = String(format: "%02d", (timeInterval % 3600) % 60)
        
        timeLeftL.text = "\(hourString):\(minuteString):\(secondString)"
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
