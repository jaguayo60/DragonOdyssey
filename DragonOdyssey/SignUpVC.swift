//
//  SignUpVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 2/6/21.
//

import UIKit
import FirebaseAuth

@available(iOS 13.0, *)
class SignUpVC: UIViewController {
    
    // MARK: - Variables
    
    var termsAndConditionsRead = false

    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var passwordEyeButton: UIButton!
    @IBOutlet weak var confirmEyeButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        if !termsAndConditionsRead { AlertService.didntReadTerms(self); return }
        
        guard let passwordText = passwordTF.text else { return }
        guard let confirmPasswordText = confirmTF.text else { return }
        guard let emailText = emailTF.text else { return }
        guard let usernameText = usernameTF.text else { return }
        
        let password = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordText.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailText.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = usernameText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if password.count == 0 ||
            confirmPassword.count == 0 ||
            email.count == 0 ||
            username.count == 0 {
            AlertService.emptyFields(self)
        }
        
        if !Validation.usernameValidation(username: username, viewController: self) { return }
        if !Validation.emailValidation(email: email, viewController: self) { return }
        if !Validation.passwordStrengthValidation(password: password, viewController: self) { return }
        
        if password != confirmPassword { AlertService.mismatchPasswords(self); return }
        
        //TODO: Unique username validation (server)
        
        //TODO: Check for unique username & email address
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                AlertService.showPopup(title: "Error Creating User!", message: "There was an error connecting to our server.\nPlease try again.", viewController: self)
            } else {
                let firebaseUID = Auth.auth().currentUser!.uid
                ServerManager.createUser(email: email, firebaseUID: firebaseUID, username: username)
                self.performSegue(withIdentifier: K.Strings.loginIdentifier, sender: nil)
            }
        }
    }
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        termsAndConditionsRead.toggle()
        checkBoxButton.isSelected.toggle()
    }
    
    @IBAction func passwordEyeTapped(_ sender: UIButton) {
        passwordEyeButton.isSelected.toggle()
        passwordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func confirmEyeTapped(_ sender: UIButton) {
        confirmEyeButton.isSelected.toggle()
        confirmTF.isSecureTextEntry.toggle()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Styling.styleTextField(usernameTF)
        Styling.styleTextField(emailTF)
        Styling.styleTextField(passwordTF)
        Styling.styleTextField(confirmTF)
        Styling.styleFilledButton(createAccountButton)
        setupButtons()
        gestureHandler()
    }
    
    func setupButtons() {
        checkBoxButton.setBackgroundImage(K.Images.square, for: .normal)
        checkBoxButton.setBackgroundImage(K.Images.checkmarkSquare, for: .selected)
        checkBoxButton.isEnabled = true
        passwordEyeButton.setImage(K.Images.eye, for: .selected)
        passwordEyeButton.setImage(K.Images.eyeSlash, for: .normal)
        confirmEyeButton.setImage(K.Images.eye, for: .selected)
        confirmEyeButton.setImage(K.Images.eyeSlash, for: .normal)
    }
    
    //MARK: - Gesture Handler
    
    func gestureHandler() {
        //single tap gesture, for canceling the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Prepare For Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Strings.termsIdentifier {
            if let vc = segue.destination as? TermsAgreementVC {
                vc.delegate = self
            }
        }
    }
}

// MARK: - Terms Delegate

@available(iOS 13.0, *)
extension SignUpVC: TermsAgreementDelegate {
    func agreeToTerms() {
        checkBoxButton.isSelected = true
        termsAndConditionsRead = true
    }
}
