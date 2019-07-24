//
//  FaceIdTableViewCell.swift
//  Ten
//
//  Created by Amit on 21/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIdableViewCell: UITableViewCell {
    
    var biometricHelper: BiometricHelper?
    @IBOutlet weak var vwContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContent.addShadow()
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //  present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var lblTouchId: UILabel!
    @IBOutlet weak var lblRemoveTouchId: UILabel!
    
    //IBAction:
    @IBAction func didTapRemoveTouchId(_ sender: Any) {
     
    }
    
    
    @IBAction func didTapCreateTouchId(_ sender: Any) {
        
        print("hello there!.. You have clicked the touch ID")
        
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        var authError: NSError?
        
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                        //  self.lblTouchId.text = "done"
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            //            self.successLabel.text = "Sorry!!... User did not authenticate successfully"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                //  successLabel.text = "Sorry!!.. Could not evaluate policy."
            }
        } else {
            // Fallback on earlier versions
            //successLabel.text = "Ooops!!.. This feature is not supported."
        }
        
        
    }
    
    
    //        let context = LAContext()
    //        var error: NSError?
    //
    //        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
    //            let reason = "Identify yourself!"
    //
    //            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
    //                [unowned self] success, authenticationError in
    //
    //                DispatchQueue.main.async {
    //                    if success {
    //                        self.runSecretCode()
    //                    } else {
    //                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
    //                        ac.addAction(UIAlertAction(title: "OK", style: .default))
    //                        self.present(ac, animated: true)
    //                    }
    //                }
    //            }
    //        } else {
    //            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
    //            ac.addAction(UIAlertAction(title: "OK", style: .default))
    //            present(ac, animated: true)
    //        }
    
    
    
    
    //        biometricHelper = BiometricHelper(action: { (newVal) in
    //            switch newVal {
    //            case .authSuccess:
    //                print("biometric auth success")
    //                break
    //            case .authFailed:
    //                print("biometric auth fail")
    //                break
    //                //            case .biometricLockout:
    //                //                print("biometric auth lockout")
    //                //                break
    //                //            case .notAvailable:
    //                //                print("biometric not available")
    //                //                break
    //                //            case .notEnrolled:
    //                //                print("biometric not set")
    //            //                break
    //            default:
    //                break
    //            }
    //        }, parent: UIViewController())
    //    }
}


