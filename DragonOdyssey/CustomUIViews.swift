//
//  CustomUIViews.swift
//  HarmLess
//
//  Created by Jared on 9/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class CustomUIViews: NSObject {

}

class GradientBGView: UIView {
    // MARK: - IBOutlets
    
    
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
        setGradientBackground(colorTop:#colorLiteral(red: 0.2697530731, green: 0.1765226892, blue: 0.3763020833, alpha: 1), colorBottom:#colorLiteral(red: 0.2713907699, green: 0.2063752627, blue: 0.3456942066, alpha: 1))
    }
    
    private func commonInit() {
    }
}

class RoundedCornersV: UIView
{
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

class RoundedCorners10V: UIView
{
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
