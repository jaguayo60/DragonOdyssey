//
//  AlertService.swift
//  Crypto
//
//  Created by James Sedlacek on 2/24/21.
//

import UIKit

struct AlertService {
    static func showPopup(title: String, message: String, viewController: UIViewController) {
        if viewController.presentedViewController != nil { return }
        let popup: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        popup.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(popup, animated: true, completion: nil)
    }
    
    static func passwordStrength(_ viewController: UIViewController) {
        let alertMessage = "Password must include: \n\nAt least 6 characters\nAt least one capital letter\nAt least one lower case letter\nAt least one special character"
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
            
            let attributedMessageText = NSMutableAttributedString(
                string: alertMessage,
                attributes: [
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
                ]
            )
        
        if viewController.presentedViewController != nil { return }
        let popup: UIAlertController = UIAlertController(title: "Password too weak!", message: nil, preferredStyle: .alert)
        
        popup.setValue(attributedMessageText, forKey: "attributedMessage")
        
        popup.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(popup, animated: true, completion: nil)
    }
    
    static func invalidEmail(_ viewController: UIViewController) {
        showPopup(title: "Invalid Email", message: "Please enter a valid email address.", viewController: viewController)
    }
    
    static func invalidUsername(_ viewController: UIViewController) {
        showPopup(title: "Invalid Username", message: "Usernames must not include special characters or spaces.\n\nUsernames must be between 5 and 14 characters long.", viewController: viewController)
    }
    
    static func uniqueUsername(_ viewController: UIViewController) {
        showPopup(title: "Invalid Username", message: "Please enter a valid & unique username.", viewController: viewController)
    }
    
    static func didntReadTerms(_ viewController: UIViewController) {
        showPopup(title: "Terms & Conditions", message: "You must read and agree to our Terms & Conditions to create an account.", viewController: viewController)
    }
    
    static func mismatchPasswords(_ viewController: UIViewController) {
        showPopup(title: "Password Error", message: "The passwords you entered do not match.", viewController: viewController)
    }
    
    static func logout(viewController: UIViewController, completed: @escaping () -> Void) {
        let popup: UIAlertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        popup.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: {_ in completed() }))
        popup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(popup, animated: true, completion: nil)
    }
    
    static func deleteAccount(viewController: UIViewController, completed: @escaping () -> Void) {
        let popup: UIAlertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?\nThis cannot be undone.", preferredStyle: .actionSheet)
        popup.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: {_ in completed() }))
        popup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(popup, animated: true, completion: nil)
    }
    
    static func incorrectPassword(_ viewController: UIViewController) {
        showPopup(title: "Incorrect Password", message: "The password entered is not correct.\nPlease try again.", viewController: viewController)
    }
    
    static func failedToUpdatePassword(_ viewController: UIViewController) {
        showPopup(title: "Failed Update!", message: "Sorry, something went wrong.\nPlease try again.", viewController: viewController)
    }
    
    static func successfulUpdatedPassword(_ viewController: UIViewController) {
        showPopup(title: "Successful Update!", message: "Your password has been updated!", viewController: viewController)
    }
    
    static func resetPasswordLinkSent(_ viewController: UIViewController) {
        showPopup(title: "Reset Link Sent!", message: "Check your email for the link to reset your password.", viewController: viewController)
    }
    
    static func emptyFields(_ viewController: UIViewController) {
        showPopup(title: "Empty Fields", message: "You must fill in every field!", viewController: viewController)
    }
}
