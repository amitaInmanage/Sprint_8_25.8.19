//
//  BiometricHelper.swift
//  Ten
//
//  Created by Amit on 23/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit

enum BiometricType {
    case none
    case touch
    case face
}

enum BiometricActionType {
    case notAvailable, authSuccess, authFailed, notEnrolled, biometricLockout
}

class BiometricHelper {
    
    let localAuthenticationContext = LAContext()
    var strPasscode = "Use Passcode"
    var strReason = "To access the secure data"
    var action: (BiometricActionType)->()?
    var parent: UIViewController?
    
    init(action: @escaping (BiometricActionType)->(), parent: UIViewController) {
        self.action = action
        self.parent = parent
    }
    
    func authenticationWithBiometric() {
        
        localAuthenticationContext.localizedFallbackTitle = strPasscode
        
        var authError: NSError?
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: strReason) { success, evaluateError in
                
                if success {
                    //User authenticated successfully, take appropriate action
                    self.action(.authSuccess)
                    
                } else {
                    
                    //User did not authenticate successfully, look at error and take appropriate action
                    
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    //If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                    self.action(.authFailed)
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                self.action(.biometricLockout)
                self.biometricLockedAlert()
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                self.action(.notAvailable)
                self.biometricNotAvailableAlert()
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                self.action(.notEnrolled)
                self.openBiometricSettings()
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                self.action(.biometricLockout)
                self.biometricLockedAlert()
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                self.action(.notAvailable)
                self.biometricNotAvailableAlert()
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                self.action(.notEnrolled)
                self.openBiometricSettings()
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func openBiometricSettings() {
        let alertController = UIAlertController (title: "Error", message: "Go to Settings and initiate biometric password", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        parent?.present(alertController, animated: true, completion: nil)
    }
    
    func biometricNotAvailableAlert() {
        let alertController = UIAlertController (title: "Error", message: "Biometric not available on your device", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        parent?.present(alertController, animated: true, completion: nil)
    }
    
    func biometricLockedAlert() {
        let alertController = UIAlertController (title: "Error", message: "You tried to many times, you are locked", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        parent?.present(alertController, animated: true, completion: nil)
    }
    
    func deviceBiometricType() -> BiometricType  {
        
        if #available(iOS 11.0, *) {
            let _ = localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(localAuthenticationContext.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            @unknown default:
                return .none
            }
        } else {
            return localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
        
    }
    
}

