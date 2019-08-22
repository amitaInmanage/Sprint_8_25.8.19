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
    
    @IBOutlet weak var lblTouchId: RegularText!
    @IBOutlet weak var lblRemoveTouchId: SmallText!
    @IBOutlet weak var vwContent: UIView!
    
    var userHaveTouchId = ApplicationManager.sharedInstance.userAccountManager.user.hasTouchId
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContent.addShadow()
        self.lblRemoveTouchId.textColor = UIColor.getApllicationErrorColor()
    
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //  present(alertController, animated: true, completion: nil)
    }
    
    //IBAction:
    @IBAction func didTapRemoveTouchId(_ sender: Any) {
        self.userHaveTouchId = false
    }
    
    
    @IBAction func didTapCreateTouchId(_ sender: Any) {
        
        print("hello there!.. You have clicked the touch ID")
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "touchId"
        popupInfoObj.strTitle = Translation(Translations.Titles.fingertipTooltip, Translations.Titles.fingertipTooltipDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.fingertipTooltip, Translations.SubTitles.fingertipTooltipDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.fingertipTooltip, Translations.AlertButtonsKeys.fingertipTooltipDefault)
        popupInfoObj.strSecondButtonTitle = Translation(Translations.AlertButtonsKeys.fingertipTooltipSkip, Translations.AlertButtonsKeys.fingertipTooltipSkipDefault)
        
        popupInfoObj.firstButtonAction = {
            
            let myContext = LAContext()
            let myLocalizedReasonString = "Biometric Authntication testing !! "
            
            var authError: NSError?
            if #available(iOS 8.0, macOS 10.12.1, *) {
                if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                    myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                        
                        DispatchQueue.main.async {
                            if success {
                                let userDefaults = UserDefaults.standard
                                
                                userDefaults.set(true, forKey: "Biomatric")
                                
                                UserDefaults.standard.synchronize()
                                
                            } else {
                            
                            }
                        }
                    }
                } else {
                    
                }
            } else {
                
            }
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}



