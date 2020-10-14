//
//  GLProgressV.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class GLProgressV: UIView
{
    // MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundV: UIView!
    @IBOutlet weak var progressBarV: UIView!
    @IBOutlet weak var progressBarVWidthCst: NSLayoutConstraint!
    
    // MARK: - Instance variables
    
    var backgroundVColor: UIColor? { didSet {
        backgroundV.backgroundColor = backgroundVColor
        }}
    
    var progressBarVColor: UIColor? { didSet {
        progressBarV.backgroundColor = progressBarVColor
        }}
    
    // MARK: - Class functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("GLProgressV", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Set progress to 0
        progressBarVWidthCst.constant = 0
        
        backgroundV.layer.cornerRadius = bounds.height / 2
        progressBarV.layer.cornerRadius = bounds.height / 2
    }
    
    // MARK: - UI
    
    func setProgressTo(percent: CGFloat, animated: Bool = true) {
        let width = percent * bounds.width
        
        if animated == true {
            UIView.animate(withDuration: 0.5) {
                self.progressBarVWidthCst.constant = width
                self.layoutIfNeeded()
            }
        }
        else {
            progressBarVWidthCst.constant = width
        }
    }
}
