//
//  ContactVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/13/21.
//

import UIKit
import MessageUI

@available(iOS 13.0, *)
class ContactVC: UIViewController {
    
    // MARK: - Variables
    
    let placeholderText = "Write your message here"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func sendTapped(_ sender: UIButton) {
        guard let nameText = nameTF.text else { return }
        guard let emailText = emailTF.text else { return }
        let email = emailText.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = nameText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email.count == 0 || name.count == 0 {
            AlertService.emptyFields(self)
        }
        
        if !Validation.emailValidation(email: email, viewController: self) { return }
        
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            AlertService.showPopup(title: "Cannot Send Mail.", message: "Couldn't send email due to unexpected error!", viewController: self)
        }
    }
    
    func configureMailComposer() -> MFMailComposeViewController {
        let message = messageTV.text ?? ""
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients([K.Strings.supportEmail])
        mailComposeVC.setSubject("Contact Support")
        mailComposeVC.setMessageBody(message, isHTML: false)
        return mailComposeVC
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ViewDidLoad


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupStyling()
        gestureHandler()
    }
    

    func setupTextView() {
        messageTV.delegate = self
        messageTV.layer.borderWidth = 2
        messageTV.layer.borderColor = UIColor.systemBlue.cgColor
        messageTV.layer.cornerRadius = 8
        messageTV.text = placeholderText
        messageTV.textColor = UIColor.systemGray3
        messageTV.isEditable = true
    }
    
    func setupStyling() {
        Styling.styleTextField(nameTF)
        Styling.styleTextField(emailTF)
        Styling.styleFilledButton(sendButton)
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

// MARK: - TextView Delegate

@available(iOS 13.0, *)
extension ContactVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let text = messageTV.text {
            if text == placeholderText {
                messageTV.text = ""
                messageTV.textColor = .black
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            sendTapped(sendButton)
            return false
        }
        return true
    }
    
}

// MARK: - Mail Delegate

@available(iOS 13.0, *)
extension ContactVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if error != nil {
            AlertService.showPopup(title: "Error Sending Mail.", message: "There was an unexpected error trying to send mail.", viewController: self)
            return
        }
        AlertService.showPopup(title: "Mail Sent.", message: "Successfully sent the email.", viewController: self)
    }
}
