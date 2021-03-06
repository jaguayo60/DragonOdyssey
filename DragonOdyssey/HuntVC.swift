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
    
    var isVisible: Bool {
        // validate if vc is visible here...
        return true
    }
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.coreDataManagerControllerDidChangeContent), name: NSNotification.Name(rawValue: "CoreDataManager_controllerDidChangeContent"), object: nil)
        
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
    
    // MARK: - Maps
    
    private func mapIsInProgress(map: [String:Any]) -> Bool {
        guard let creatureCurrentMission = creature.currentMission,
              let missionMap = creatureCurrentMission["map"] as? [String:Any],
              let missionMapID = missionMap["id"] as? String,
              let mapID = map["id"] as? String
              else { return false }
        
        return missionMapID == mapID
    }
    
    // MARK: - Missions
    
    func completeMission() {
        guard let currentMission = creature.currentMission else { return }
        
        if missionIsComplete(mission: currentMission),
           let map = currentMission["map"] as? [String:Any],
           let experience = map["rewardExperience"] as? Double {

            // give creature xp for mission
            CreatureService.creature.totalSteps += experience
            if DebugService.logCreatureStats == true { print("🐲 Added \(2500) steps to total. Total steps: \(CreatureService.creature.totalSteps)") }
            CreatureService.creature.updateLevel()
            
            // give user inventory items
            MapService.giveUserItemsFor(map: map)
            
            FuncService.showBasicAlert(title: "Mission Complete", message: "Your dragon has successfully completed a mission.\n\n\(Int(experience)) Experience\n\(MapService.itemsStringFor(map: map))", btnTitle: "Okay", action: nil, controller: self)
            creature.currentMission = nil
            CoreDataService.saveContext()
        }
    }
    
    private func missionIsComplete(mission:[String:Any]) -> Bool {
        guard let startDate = mission["startDate"] as? Date,
              let map = mission["map"] as? [String:Any],
              let timeLengthInSeconds = map["timeLengthInSeconds"] as? Double
        else { return true }
        
        let secondsSinceStartDate = Date().timeIntervalSince(startDate)
        
        return secondsSinceStartDate >= timeLengthInSeconds
    }
    
    // MARK: - Data Responding
    
    @objc func coreDataManagerControllerDidChangeContent(notification: NSNotification) {
        drawStaticUI()
        mapsTV.reloadData()
        
        if self.isVisible { drawAnimatedUI() }
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
        
        cell.huntVC = self
        cell.levelL.text = String(Int(mapDict["level"] as? Double ?? 0))
        cell.nameL.text = mapDict["name"] as? String
        cell.energyCostL.text = String(Int(mapDict["energyCost"] as? Double ?? 0))
        
        if let bgImageName = mapDict["bgImageName"] as? String, let bgImage = UIImage(named: bgImageName) {
            cell.mapBGImgV.image = bgImage
        }
        
        if mapIsInProgress(map: mapDict) == true,
           let startDate = creature.currentMission?["startDate"] as? Date,
           let timeLengthInSeconds = mapDict["timeLengthInSeconds"] as? Double {
            cell.detailsOverlaySV.isHidden = true
            cell.missionActiveOverlayV.isHidden = false
            cell.startTimeLeftTimerWith(startDate: startDate, durationInSeconds: timeLengthInSeconds)
        }
        
        return cell
    }
}

extension HuntVC: UITableViewDelegate
{
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let map = maps[indexPath.row]

        guard mapIsInProgress(map: map) == false else { return }
        
        guard creature.currentMission == nil else {
            FuncService.showBasicAlert(title: "Whoops", message: "It looks like your dragon is already out on a mission. You can send him on another one once he returns.", btnTitle: "Okay", action: nil, controller: self)
            return
        }
        
        let vc = MapVC(map: map)
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true, completion: nil)
        
//        FuncService.showBasicAlert(title: map["name"] as? String ?? "", message: "Level: \(Int(map["level"] as? Double ?? 0))\nTime to complete: \(Int(map["timeLengthInSeconds"] as? Double ?? 0)) seconds\nEnergy Cost: \(Int(map["energyCost"] as? Double ?? 0))\nExperience: \(Int(map["rewardExperience"] as? Double ?? 0))", btnTitle: "Okay", action: nil, controller: self)

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
