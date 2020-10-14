//
//  FeedbackVC.swift
//  DragonOdyssey
//
//  Created by Jared on 10/14/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import GoogleMobileAds
import MessageUI

class FeedbackVC: GLVC {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var ideaTextV: UITextView!
    @IBOutlet weak var mainCtnVBottomCst: NSLayoutConstraint!
    
    // MARK: - Instance variables
    
    @IBOutlet weak var bannerV: GADBannerView!
    
    
    // MARK: - Class functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupAds()
    }
    
    // MARK: - Ads
    
    private func setupAds() {
        bannerV.adUnitID = "ca-app-pub-3940256099942544/2934735716" // currently test adUnitID
        bannerV.rootViewController = self
        bannerV.load(GADRequest())
    }
    
    // MARK: - UI
    
    func drawVC() {
        
    }
    
    // MARK: - Mail
    
    private func showMailComposerWith(subject: String, body: String?) {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["4JacksTechnologies@gmail.com"])
        composer.setSubject(subject)
        if let body = body { composer.setMessageBody(body, isHTML: false) }
        
        present(composer, animated: true, completion: nil)
    }
    
    // MARK: - Keyboard responders
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            mainCtnVBottomCst.constant = keyboardSize.height - 50
            UIView.animate(withDuration: 0.5) { // animates constraint change
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        mainCtnVBottomCst.constant = 0
        UIView.animate(withDuration: 0.5) { // animates constraint change
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        guard let formText = ideaTextV.text else {
            FuncService.showBasicAlert(title: "Whoops", message: "You need to input and idea before you can submit it.", btnTitle: "Okay", action: nil, controller: self)
            return
        }
        showMailComposerWith(subject: "I have an idea", body: formText)
    }
}

extension FeedbackVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error { print(error) }
        
        switch result {
        case .cancelled:break
        case .failed:break
        case .saved:break
        case .sent:
        ideaTextV.text = nil
        default:break
        }
        
        controller.dismiss(animated: true, completion: {
            self.view.endEditing(true)
        })
    }
}

extension FeedbackVC: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}
