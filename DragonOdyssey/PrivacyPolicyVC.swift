//
//  PrivacyPolicyVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/16/21.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController, WKNavigationDelegate {
    
    // MARK: - Variables
    
    var webView: WKWebView!
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: K.URLs.privacyPolicy))
        webView.allowsBackForwardNavigationGestures = true
    }
}
