//
//  SettingsVC.swift
//  DragonOdyssey
//
//  Created by Jared on 11/6/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class SettingsVC: GLVC {

    // MARK: - IBOutlets
    
    
    // MARK: - Instance variables
    
    
    
    // MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawVC()
    }
    
    // MARK: - UI
    
    func drawVC() {
        
    }
    
    // MARK: - IBActions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func feedback(_ sender: Any) {
        let vc = FeedbackVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func debug(_ sender: Any) {
        let vc = DebugVC()
        present(vc, animated: true, completion: nil)
    }
}

class SettingsCntV: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
}

class SettingsMenuBGV: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
    }
}
