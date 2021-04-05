//
//  ChangePasswordVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/11/21.
//

import UIKit
import FirebaseAuth

@available(iOS 13.0, *)
class ChangePasswordVC: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var currentEyeButton: UIButton!
    @IBOutlet weak var newEyeButton: UIButton!
    @IBOutlet weak var confirmEyeButton: UIButton!
    @IBOutlet weak var updatePasswordButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func currentEyeTapped(_ sender: UIButton) {
        currentEyeButton.isSelected.toggle()
        currentPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func newEyeTapped(_ sender: UIButton) {
        newEyeButton.isSelected.toggle()
        newPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func confirmEyeTapped(_ sender: UIButton) {
        confirmEyeButton.isSelected.toggle()
        confirmPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func updatePasswordTapped(_ sender: UIButton) {
        guard let currentPasswordText = currentPasswordTF.text else { return }
        guard let newPasswordText = newPasswordTF.text else { return }
        guard let confirmPasswordText = confirmPasswordTF.text else { return }
        let currentPassword = currentPasswordText.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPassword = newPasswordText.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //make sure no fields are empty
        if currentPassword.count == 0 || newPassword.count == 0 || confirmPassword.count == 0 {
            AlertService.showPopup(title: "Empty Fields", message: "You must fill in every field!", viewController: self)
        }
        
        //validate new password
        if !Validation.passwordStrengthValidation(password: newPassword, viewController: self) { return }
        
        //make sure the passwords match
        if newPassword != confirmPassword { AlertService.mismatchPasswords(self); return }
        
        //authenticate, current password is the actual current password
        //else, alert service, password is incorrect
        guard let email = Auth.auth().currentUser?.email else { return }
        
        let credential = FirebaseAuth.EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        //Reauthenticate to make sure the password entered is correct
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: {
            (result, error)  in
            if error != nil {
                AlertService.incorrectPassword(self)
                return
            }
            
            //update password
            Auth.auth().currentUser?.updatePassword(to: newPassword, completion: {
                error  in
                if error != nil {
                    AlertService.failedToUpdatePassword(self)
                    return
                }
                AlertService.successfulUpdatedPassword(self)
                if UserDefaultsManager.shared.isBiometricsSetup() {
                    Biometrics.saveKeyChainPassword(email: email, password: newPassword)
                }
            })
        })
    }
    
    @IBAction func resetPasswordTapped(_ sender: UIButton) {
        guard let email = Auth.auth().currentUser?.email else { return }
        Auth.auth().sendPasswordReset(withEmail: email, completion: {
            error in
            if error != nil {
                AlertService.showPopup(title: "Error!", message: "Unable to send reset link.\nTry Again", viewController: self)
                return
            }
            AlertService.resetPasswordLinkSent(self)
        })
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons() {
        Styling.styleFilledButton(updatePasswordButton)
        Styling.styleTextField(currentPasswordTF)
        Styling.styleTextField(newPasswordTF)
        Styling.styleTextField(confirmPasswordTF)
    }

}
