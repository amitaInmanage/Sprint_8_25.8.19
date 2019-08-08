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
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "carAdd"
        popupInfoObj.strTitle = Translation(Translations.Titles.addFuelingCardSuccess, Translations.Titles.addFuelingCardSuccessDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.addFuelingCardSuccess, Translations.SubTitles.addFuelingCardSuccessDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.addFuelingCardSucces, Translations.AlertButtonsKeys.addFuelingCardSuccesDefault)
        
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    
    
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
//                            self.successLabel.text = "Awesome!!... User authenticated successfully"
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
//                            self.successLabel.text = "Sorry!!... User did not authenticate successfully"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
//                successLabel.text = "Sorry!!.. Could not evaluate policy."
            }
        } else {
            // Fallback on earlier versions
//            successLabel.text = "Ooops!!.. This feature is not supported."
        }
    }
}



