//
//  CustomUIButtons.swift
//  HarmLess
//
//  Created by Jared on 9/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class RoundedCornersB: UIButton {
    
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
    }
}

class RoundedCorners10B: UIButton {
    
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
    }
}

class StandardButton: UIButton {
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
        clipsToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        setBackgroundColor(color: UIColor.white.withAlphaComponent(0.2), forState: .highlighted)
        setTitleColor(.white, for: .highlighted)
    }
}

class ReviewYesNoButton: UIButton {
    
    // MARK: - Instance variables
    
    var isActivated = false {
        didSet {
            if isActivated == true {
                backgroundColor = .white
                setTitleColor(#colorLiteral(red: 0.1526953917, green: 0.06453139454, blue: 0.2534542456, alpha: 1), for: .normal)
            } else {
                backgroundColor = .clear
                setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
            }
        }
    }
    
    // MARK: - Class functions
    
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
        clipsToBounds = true
        backgroundColor = .clear
        titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 30)
        setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }
}

class ReviewAddSubtractButton: UIButton {
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
        clipsToBounds = true
        backgroundColor = UIColor.white.withAlphaComponent(0.10)
        setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        setBackgroundColor(color: UIColor.white.withAlphaComponent(0.2), forState: .highlighted)
    }
}
