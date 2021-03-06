//
//  MapVC.swift
//  DragonOdyssey
//
//  Created by Jared on 11/25/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class MapVC: GLVC {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var levelL: UILabel!
    @IBOutlet weak var energyCostL: UILabel!
    @IBOutlet weak var timeLengthL: UILabel!
    @IBOutlet weak var experienceL: UILabel!
    @IBOutlet weak var itemsL: UILabel!
    
    // MARK: - Instance variables
    
    var map: [String:Any]!
    let creature = CreatureService.creature
    
    // MARK: - Class functions
    
    @objc init(map: [String:Any]) {
        self.map = map
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // must be included to write a custom init for UIViewController
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawVC()
    }
    
    // MARK: - UI
    
    private func drawVC() {
        levelL.text = String(Int(map["level"] as? Double ?? 0))
        nameL.text = map["name"] as? String
        energyCostL.text = "\((Int(map["energyCost"] as? Double ?? 0))) Energy"
        timeLengthL.text = timeLengthStringFor(map: map)
        experienceL.text = "\((Int(map["rewardExperience"] as? Double ?? 0))) Experience"
        itemsL.text = MapService.itemsStringFor(map: map)
    }
    
    private func timeLengthStringFor(map: [String:Any]) -> String {
        guard let timeLengthInSecondsDouble = map["timeLengthInSeconds"] as? Double else { return "" }
        let timeLengthInSeconds = Int(timeLengthInSecondsDouble)
        
//        dayL.text = String(format: "%02d", timeInterval / 86400)
        let hours = String((timeLengthInSeconds % 86400) / 60 / 60)
        let minutes = String((timeLengthInSeconds % 3600) / 60)
        let seconds = String((timeLengthInSeconds % 3600) % 60)
        
//        return "\(hours):\(minutes):\(seconds)"
        
        var timeLengthString = ""
        if hours != "0" { timeLengthString.append("\(hours) \((hours == "1") ? "Hour" : "Hours")") }
        if minutes != "0" {
            if timeLengthString != "" { timeLengthString.append(", ") }
            timeLengthString.append("\(minutes) \((minutes == "1") ? "Minute" : "Minutes")")
        }
        if seconds != "0" {
            if timeLengthString != "" { timeLengthString.append(", ") }
            timeLengthString.append("\(seconds) \((seconds == "1") ? "Second" : "Seconds")")
        }
        
        return timeLengthString
    }
    
    // MARK: - Mission Generation
    
    private func startMissionForMap() {
        guard let map = map, let energyCost = map["energyCost"] as? Double else { return }
        
        let mission: [String:Any] = [
            "startDate":Date(),
            "map":map
        ]
        
        creature.energy -= energyCost
        creature.currentMission = mission
        CoreDataService.saveContext()
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendDragon(_ sender: Any) {
        guard let mapEnergyCost = map["energyCost"] as? Double else { return }
        guard mapEnergyCost <= creature.energy else {
            FuncService.showBasicAlert(title: "Whoops", message: "It looks like your dragon only has \(Int(creature.energy)) energy. \(Int(mapEnergyCost)) energy is required for this mission.", btnTitle: "Okay", action: nil, controller: self)
            return
        }
        
        startMissionForMap()
        dismiss(animated: true, completion: nil)
    }
}

class MapPopUpView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 10
//        layer.borderWidth = 3
//        layer.borderColor = UIColor.from(hexValue: "4770B7").cgColor
    }
}
