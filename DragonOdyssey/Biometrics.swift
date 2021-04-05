//
//  Biometrics.swift
//  LoginTest
//
//  Created by James Sedlacek on 3/3/21.
//

import UIKit
import LocalAuthentication

enum BiometricType: Int {
  case none = 0
  case touchID = 1
  case faceID = 2
}

@available(iOS 13.0, *)
struct Biometrics {
    static func signin(_ viewController: UIViewController, successful: @escaping () -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        successful()
//                        print("Success!")
                    } else {
                        // error
//                        print("Error! \(String(describing: error))")
                    }
                }
            }
        } else {
            // no biometry
        }
    }
    
    static func biometricType() -> BiometricType {
        let context = LAContext()
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType.rawValue {
        case BiometricType.none.rawValue:
                return .none
        case BiometricType.touchID.rawValue:
                return .touchID
        case BiometricType.faceID.rawValue:
                return .faceID
        default:
                return .none
        }
    }
    
    static func getBioImage() -> UIImage? {
        let bioType = biometricType()
        switch bioType {
        case .faceID:
            return K.Images.faceid
        case .touchID:
            return K.Images.touchid
        default:
            return nil
        }
    }
    
    static func getKeyChainPassword() -> String? {
        guard let email = UserDefaultsManager.shared.getEmail() else { return nil }
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                   account: email,
                                                   accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return keychainPassword
         } catch {
            fatalError("Error reading password from keychain - \(error)")
         }
    }
    
    static func saveKeyChainPassword(email: String, password: String) {
        do {
            // This is a new account, create a new keychain item with the account name.
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                  account: email,
                                                  accessGroup: KeychainConfiguration.accessGroup)
            // Save the password for the new item.
            try passwordItem.savePassword(password)
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
}
