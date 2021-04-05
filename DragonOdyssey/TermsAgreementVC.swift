//
//  TermsVC.swift
//  LoginTest
//
//  Created by James Sedlacek on 2/28/21.
//

import UIKit

protocol TermsAgreementDelegate {
    func agreeToTerms()
}

class TermsAgreementVC: UIViewController {
    
    var delegate: TermsAgreementDelegate?
    
    @IBOutlet weak var agreeButton: UIButton!
    
    @IBAction func agreeButtonTapped(_ sender: UIButton) {
        delegate?.agreeToTerms()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        Styling.styleFilledButton(agreeButton)
    }

}
