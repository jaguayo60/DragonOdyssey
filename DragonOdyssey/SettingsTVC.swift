//
//  SettingsTVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/11/21.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class SettingsTVC: UITableViewController {
    
    // MARK: - Variables
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        AlertService.logout(viewController: self, completed: {
            do {
                if K.Enums.loggedInUsing == .Facebook {
                    LoginManager().logOut()
//                    print("Logged out of Facebook")
                } else if K.Enums.loggedInUsing == .Google {
                    GIDSignIn.sharedInstance()?.signOut()
//                    print("Signed out of Google")
                }

                try Auth.auth().signOut()
//                print("Signed out of Firebase")

                self.performSegue(withIdentifier: K.Strings.logoutIdentifier, sender: nil)
            } catch {
//                print("Error: \(error)")
                AlertService.showPopup(title: "Error logging out!", message: "Try again.", viewController: self)
            }
        })
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        AlertService.deleteAccount(viewController: self, completed: {
            Auth.auth().currentUser?.delete(completion: {_ in
                self.performSegue(withIdentifier: K.Strings.logoutIdentifier, sender: nil)
            })
        })
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupNavBar()
        tableView.tableFooterView = UIView()
    }
    
    func setupButtons() {
        Styling.styleFilledButton(passwordButton)
        Styling.styleFilledButton(helpButton)
        Styling.styleFilledButton(logoutButton)
        deleteButton.layer.cornerRadius = K.Numbers.buttonCornerRadius
        
        if K.Enums.loggedInUsing != .Email {
            passwordButton.isUserInteractionEnabled = false
            passwordButton.alpha = K.Numbers.buttonDisabledAlpha
        }
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: K.Fonts.title]
        self.navigationController?.navigationBar.barTintColor = K.Colors.backgroundColor
    }

}
