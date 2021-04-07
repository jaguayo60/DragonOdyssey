//
//  logoVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/3/21.
//

import UIKit
import AVKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import GoogleSignIn

@available(iOS 13.0, *)
class MainVC: UIViewController {
    
    // MARK: - Variables
    
//    var videoPlayer:AVPlayer?
//    var videoPlayerLayer:AVPlayerLayer?
//    var player: AVQueuePlayer?
//    var playerItem: AVPlayerItem?
//    var playerLooper: AVPlayerLooper?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet var googleButton: UIView!
    @IBOutlet weak var facebookButton: FBLoginButton!
    @IBOutlet var googleLogo: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    // MARK: - IBActions
    
    @IBAction func fbloginTapped(_ sender: FBLoginButton) {
//        print("FB button tapped")
    }
    
    @objc func googleButtonTapped() {
//        print("Google button tapped")
        GIDSignIn.sharedInstance()?.signIn()
        tapAnimation(googleButton)
    }
    
    func tapAnimation(_ view: UIView) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1.0
        flash.toValue = 0.3
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        view.layer.add(flash, forKey: nil)
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Styling.styleFilledButton(signupButton)
        setupFBbutton()
        setupGoogleButton()
        setupNotificationObserver()
        setupNavBar()
        ServerManager.getItemImages()
    }
    
    func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidSignInGoogle(_:)),
                                               name: .signInGoogleCompleted,
                                               object: nil)
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: K.Fonts.title]
        self.navigationController?.navigationBar.barTintColor = K.Colors.backgroundColor
    }
    
    @objc func userDidSignInGoogle(_ notification: Notification) {
        K.Enums.loggedInUsing = .Google
        self.performSegue(withIdentifier: K.Strings.loginIdentifier, sender: nil)
//        print("Successfully signed into Google")
    }
    
    func setupGoogleButton() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        googleButton.layer.cornerRadius = K.Numbers.buttonCornerRadius
        googleButton.layer.masksToBounds = false
        googleLogo.isOpaque = false
        googleLogo.image = K.Images.logoGoogle
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(googleButtonTapped))
        googleButton.addGestureRecognizer(tapGesture)
    }
    
    func setupFBbutton() {
        facebookButton.layer.cornerRadius = K.Numbers.buttonCornerRadius
        facebookButton.layer.masksToBounds = true
        facebookButton.delegate = self
        facebookButton.permissions = ["email"]
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        
        // Set up video in the background
//        setUpVideo()
    }
    
//    func setUpVideo() {
//        let item = AVPlayerItem(url: K.URLs.video)
//
//        player = AVQueuePlayer()
//
//        guard let player = player else { return }
//
//        videoPlayerLayer = AVPlayerLayer(player: player)
//
//        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
//
//        let duration = Int64( ( (Float64(CMTimeGetSeconds(AVAsset(url: K.URLs.video).duration)) *  10.0) - 1) / 10.0 )
//        playerLooper = AVPlayerLooper(player: player,
//                                      templateItem: item,
//                                      timeRange: CMTimeRange(start: CMTime.zero,
//                                                             end: CMTimeMake(value: duration, timescale: 1)) )
//
//        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
//
//        player.playImmediately(atRate: 0.3)
//    }

    // MARK: - Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Facebook Delegate

@available(iOS 13.0, *)
extension MainVC: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else { return }
        let fbRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                   parameters: ["fields": "email"],
                                                   tokenString: token,
                                                   version: nil,
                                                   httpMethod: .get)
        fbRequest.start(completionHandler: {
            _, result, error in
            
//            guard let result = result as? [String:Any],
//                  let email = result["email"] as? String else { return }
            
            //TODO: use this email address
//            print("Email: \(email)")
            
            //FB LOGIN
            if let token = AccessToken.current,
                !token.isExpired {
//                print("Successfully logged in user with FB")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                
                //FIREBASE AUTHENTICATION
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error {
                        let authError = error as NSError
//                        print("Error: \(authError)")
                        AlertService.showPopup(title: "Error Signing in!", message: "\(authError)", viewController: self)
                        return
                    }
//                    print("Successfully authenticated using Firebase & Facebook.")
                  // User is signed in
                    K.Enums.loggedInUsing = .Facebook
                    self.performSegue(withIdentifier: K.Strings.loginIdentifier, sender: nil)
                }
            }
        })
    }

}
