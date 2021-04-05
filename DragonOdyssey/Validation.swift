//
//  Validation.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/1/21.
//

import UIKit

struct Validation {
    static func passwordStrengthValidation(password: String, viewController: UIViewController) -> Bool {
        let isValidPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        if !isValidPassword.evaluate(with: password) {
            AlertService.passwordStrength(viewController)
            return false
        }
        return true
    }
    
    static func emailValidation(email: String, viewController: UIViewController) -> Bool {
        let isValidEmail =  NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        if !isValidEmail.evaluate(with: email) {
            AlertService.invalidEmail(viewController)
            return false
        }
        return true
    }
    
    static func usernameValidation(username: String, viewController: UIViewController) -> Bool {
        let isValidUsername = NSPredicate(format:"SELF MATCHES %@", "\\w{5,14}")
        
        if !isValidUsername.evaluate(with: username) {
            AlertService.invalidUsername(viewController)
            return false
        }
        
        
        return true
    }
}
