//
//  UserDefaults.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/1/21.
//

import UIKit

enum keys: String {
    case Biometrics = "Biometrics"
    case Email = "Email"
}

struct UserDefaultsManager {
    static var shared = UserDefaultsManager()
    let defaults = UserDefaults()
    
    func isBiometricsSetup() -> Bool {
        return defaults.bool(forKey: keys.Biometrics.rawValue)
    }
    
    func setupBiometrics() {
        defaults.setValue(true, forKey: keys.Biometrics.rawValue)
    }
    
    func saveEmail(_ email: String) {
        defaults.setValue(email, forKey: keys.Email.rawValue)
    }
    
    func getEmail() -> String? {
        return defaults.string(forKey: keys.Email.rawValue)
    }
}
