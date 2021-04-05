//
//  LoginVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 2/28/21.
//

import UIKit
import FirebaseAuth

@available(iOS 13.0, *)
class LoginVC: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var biometricButton: UIButton!
    @IBOutlet weak var setupBioButton: UIButton!
    @IBOutlet weak var passwordEyeButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        signin(successful: {
            self.performSegue(withIdentifier: K.Strings.loginIdentifier, sender: nil)
        })
    }
    
    @IBAction func biometricLoginButtonTapped(_ sender: UIButton) {
        Biometrics.signin(self, successful: {
            guard let password = Biometrics.getKeyChainPassword() else { return }
            self.passwordTF.text = password
            self.signin(successful: {
                self.performSegue(withIdentifier: K.Strings.loginIdentifier, sender: nil)
            })
        })
    }
    
    @IBAction func setupButtonTapped(_ sender: UIButton) {
        guard let password = getPassword() else { return }
        guard let email = getEmail() else { return }
        signin(successful: {
            Biometrics.signin(self, successful: {
                Biometrics.saveKeyChainPassword(email: email, password: password)
                UserDefaultsManager.shared.saveEmail(email)
                UserDefaultsManager.shared.setupBiometrics()
                self.performSegue(withIdentifier: K.Strings.loginIdentifier, sender: nil)
            })
        })
    }
    
    func getEmail() -> String? {
        guard let emailText = emailTF.text else { return nil }
        let email = emailText.trimmingCharacters(in: .whitespacesAndNewlines)
        if email.count == 0 {
            AlertService.showPopup(title: "Empty Fields", message: "You must enter a valid email and password!", viewController: self)
            return nil
        }
        if !Validation.emailValidation(email: email, viewController: self) { return nil }
        return email
    }
    
    func getPassword() -> String? {
        guard let passwordText = passwordTF.text else { return nil }
        let password = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        if password.count == 0 {
            AlertService.showPopup(title: "Empty Fields", message: "You must enter a valid email and password!", viewController: self)
            return nil
        }
        return password
    }
    
    func signin(successful: @escaping () -> Void) {
        guard let email = getEmail(),
              let password = getPassword() else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                AlertService.showPopup(title: "Login Error!", message: "Incorrect Email or Password.", viewController: self)
            } else {
                successful()
            }
        }
    }
    
    @IBAction func passwordEyeTapped(_ sender: UIButton) {
        passwordEyeButton.isSelected.toggle()
        passwordTF.isSecureTextEntry.toggle()
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureHandler()
        Styling.styleTextField(emailTF)
        Styling.styleTextField(passwordTF)
        initBioButton()
        rememberEmail()
        setupEyeButton()
        K.Enums.loggedInUsing = .Email
    }
    
    func setupEyeButton() {
        passwordEyeButton.setImage(K.Images.eye, for: .selected)
        passwordEyeButton.setImage(K.Images.eyeSlash, for: .normal)
    }
    
    func rememberEmail() {
        if let email = UserDefaultsManager.shared.getEmail() {
            emailTF.text = email
        }
    }
    
    func initBioButton() {
        if UserDefaultsManager.shared.isBiometricsSetup() {
            if let bioImage = Biometrics.getBioImage() {
                biometricButton.setBackgroundImage(bioImage, for: .normal)
                biometricButton.isUserInteractionEnabled = true
                biometricButton.alpha = 1
                setupBioButton.isHidden = true
                setupBioButton.isUserInteractionEnabled = false
            }
        } else {
            biometricButton.isHidden = true
            biometricButton.isUserInteractionEnabled = false
            switch Biometrics.biometricType() {
            case .faceID:
                setupBioButton.setTitle("Setup FaceID", for: .normal)
            case .touchID:
                setupBioButton.setTitle("Setup TouchID", for: .normal)
            case .none:
                setupBioButton.isHidden = true
                setupBioButton.isUserInteractionEnabled = false
            }
        }
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

}
