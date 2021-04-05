//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Styling {
    
    static func styleTextField(_ textfield:UITextField) {
        let bottomLine = CALayer()
        let stackViewSpacing: CGFloat = 10
        let margin: CGFloat = 45
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let textFieldWidth = screenWidth - (margin * 2)
        
        bottomLine.frame = CGRect(x: (-1 * margin) + stackViewSpacing, y: textfield.frame.height + 4, width: textFieldWidth/*textfield.frame.width*/, height: 2)
        
        bottomLine.backgroundColor = K.Colors.textFieldLine
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button:UIButton) {
        button.backgroundColor = K.Colors.buttonBackground
        button.layer.cornerRadius = K.Numbers.buttonCornerRadius
        button.tintColor = K.Colors.buttonTint
    }
    
}
