//
//  HuntVC.swift
//  DragonOdyssey
//
//  Created by Jared on 11/17/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class HuntVC: GLVC {

    // MARK: - IBOutlets
    
    @IBOutlet weak var levelL: UILabel!
    @IBOutlet weak var levelProgressV: GLProgressV!
    @IBOutlet weak var energyAmountL: UILabel!
    @IBOutlet weak var strengthAmountL: UILabel!
    @IBOutlet weak var agilityAmountL: UILabel!
    
    @IBOutlet weak var mapsTV: UITableView!
    
    // MARK: - Instance variables
    
    let creature = CreatureService.creature
    let maps = MapsLibrary.maps
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HuntVCMapTVCell", bundle: nil)
        mapsTV.register(nib, forCellReuseIdentifier: "MapCell")
        
        drawInitialUI()
        drawStaticUI()
    }
    
    var viewDidAppearLastCalled: Date?
    
    override func viewDidAppear(_ animated: Bool) {
        // Prevent viewDidAppear from being called twice
        if let viewDidAppearLastCalled = viewDidAppearLastCalled {
            let secondsSinceLastCalled = -viewDidAppearLastCalled.timeIntervalSinceNow
            if secondsSinceLastCalled < 0.5 { return }
        }
        
        super.viewDidAppear(animated)
        viewDidAppearLastCalled = Date()
        
        drawAnimatedUI()
    }
    
    // MARK: - UI
    
    func drawInitialUI() {
        levelProgressV.progressBarVColor = #colorLiteral(red: 0.4284983277, green: 0.9816996455, blue: 0.5134830475, alpha: 1)
    }
    
    func drawStaticUI() {
        levelL.text = "Level \(Int(creature.level))"
        energyAmountL.text = String(Int(creature.energy))
        strengthAmountL.text = String(Int(creature.strength))
        agilityAmountL.text = String(Int(creature.agility))
    }
    
    func drawAnimatedUI(animated: Bool = true) {
        levelProgressV.setProgressTo(percent: creature.percentageOfLevelComplete, animated: true)
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension HuntVC: UITableViewDataSource
{
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as? HuntVCMapTVCell else {
            return tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath)
        }
        
        let mapDict = maps[indexPath.row]
        
        cell.levelL.text = String(Int(mapDict["level"] as? Double ?? 0))
        cell.nameL.text = mapDict["name"] as? String
        
        if let bgImageName = mapDict["bgImageName"] as? String, let bgImage = UIImage(named: bgImageName) {
            cell.mapBGImgV.image = bgImage
        }
        
        return cell
    }
}

extension HuntVC: UITableViewDelegate
{
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let map = maps[indexPath.row]
        FuncService.showBasicAlert(title: map["name"] as? String ?? "", message: "Level: \(Int(map["level"] as? Double ?? 0))\nTime to complete: \(Int(map["timeLengthInSeconds"] as? Double ?? 0)) seconds\nEnergy Cost: \(Int(map["energyCost"] as? Double ?? 0))\nExperience: \(Int(map["rewardExperience"] as? Double ?? 0))", btnTitle: "Okay", action: nil, controller: self)
        
        
//        "name":"Grasslands",
//        "bgImageName":"mapGrasslands",
//        "timeLengthInSeconds":Double(3*60),
//        "level":Double(1),
//        "energyCost":Double(1),
//        "rewardExperience":Double(300),
//        "rewardFoodItems":["strawberry"]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.bounds.width * (765/1100)) + 20
    }
}

class HuntVCEnergyBGView: UIView {
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
        layer.borderColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    }
}
