//
//  ForgotVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 2/28/21.
//

import UIKit
import FirebaseAuth
import Firebase

class ForgotVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let email = emailTF.text else { return }
        if !Validation.emailValidation(email: email, viewController: self) { return }
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: {
            error in
            if error != nil {
                AlertService.showPopup(title: "Error!", message: "Unable to send reset link.\nTry Again", viewController: self)
                return
            }
            AlertService.resetPasswordLinkSent(self)
        })
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Styling.styleFilledButton(sendButton)
        Styling.styleTextField(emailTF)
    }

}
