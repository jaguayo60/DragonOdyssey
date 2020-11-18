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
        
        drawVC()
    }
    
    // MARK: - UI
    
    func drawVC() {
        levelL.text = "Level \(Int(creature.level))"
        energyAmountL.text = String(Int(creature.energy))
        strengthAmountL.text = String(Int(creature.strength))
        agilityAmountL.text = String(Int(creature.agility))
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
        
        cell.nameL.text = mapDict["name"] as? String
        
        return cell
    }
}

extension HuntVC: UITableViewDelegate
{
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
