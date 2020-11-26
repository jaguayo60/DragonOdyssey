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
    
    // MARK: - Instance variables
    
    var map: [String:Any]!
    
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
    
    func drawVC() {
        levelL.text = String(Int(map["level"] as? Double ?? 0))
        nameL.text = map["name"] as? String
        energyCostL.text = String(Int(map["energyCost"] as? Double ?? 0))
    }
    
    // MARK: - IBActions

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
        layer.borderWidth = 3
        layer.borderColor = UIColor.from(hexValue: "4770B7").cgColor
    }
}
