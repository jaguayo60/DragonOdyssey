//
//  ViewController.swift
//  DragonOdyssey
//
//  Created by Jared on 10/6/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var feedbackTextV: UITextView!
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
        bannerV.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerV.rootViewController = self
        bannerV.load(GADRequest())
    }
    
    // MARK: - UI
    
    func drawVC() {
        
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

    @IBAction func submit(_ sender: Any) {
        guard let formText = feedbackTextV.text else {
            FuncService.showBasicAlert(title: "Whoops", message: "You need to input and idea before you can submit it.", btnTitle: "Okay", action: nil, controller: self)
            return
        }
        FuncService.open(urlString: "mailto:info@wiredbetterment.com?subject=DRINK%20Feedback&body=dang")
    }
}

extension ViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}
