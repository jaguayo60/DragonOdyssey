//
//  K.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/16/21.
//

import UIKit

enum loginType {
    case Facebook
    case Google
    case Email
}

struct K {
    struct URLs {
        static let privacyPolicy = URL(string:"https://dragon-odyssey.flycricket.io/privacy.html")!
        static let termsOfService = URL(string:"https://dragon-odyssey.flycricket.io/terms.html")!
//        static let video = URL(fileURLWithPath: Bundle.main.path(forResource: "snowflakes", ofType: "mp4")!)
    }
    
    struct Strings {
        static let logoutIdentifier = "LogoutSegue"
        static let loginIdentifier = "LoginSegue"
        static let termsIdentifier = "SegueToTerms"
        static let supportEmail = "support@gmail.com"
    }
    
    struct Numbers {
        static let buttonCornerRadius: CGFloat = 25
        static let buttonDisabledAlpha: CGFloat = 0.5
    }
    
    @available(iOS 13.0, *)
    struct Images {
        static let square = UIImage.init(systemName: "square")
        static let checkmarkSquare = UIImage.init(systemName: "checkmark.square")
        static let eye = UIImage.init(systemName: "eye")
        static let eyeSlash = UIImage.init(systemName: "eye.slash")
        static let logoGoogle = UIImage(named: "GoogleLogo")
        static let faceid = UIImage(systemName: "faceid")
        static let touchid = UIImage(systemName: "touchid")
        
        static var buttons: [(name: String, image: UIImage)] = []
        static var icons: [(name: String, image: UIImage)] = []
        static var items: [(name: String, image: UIImage)] = []
        
        static func getItemImage(for name: String) -> UIImage {
            for item in K.Images.items {
                if item.name == name {
                    return item.image
                }
            }
            return UIImage() //TODO: placeholder image goes here
        }
    }
    
    struct Colors {
        static let buttonBackground = UIColor.systemBlue
        static let buttonTint = UIColor.white
        static let textFieldLine = UIColor.systemBlue.cgColor
        static let backgroundColor = UIColor(named: "backgroundColor")
    }
    
    struct Fonts {
        static let title = UIFont(name: "Marker Felt Thin", size: 25)!
    }
    
    struct Enums {
        static var loggedInUsing: loginType = .Email
    }
    
    struct Items {
        static var list: [Item] = []
    }
}
