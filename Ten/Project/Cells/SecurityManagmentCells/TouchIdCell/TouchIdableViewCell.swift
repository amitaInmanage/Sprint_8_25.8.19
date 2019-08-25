//
//  FaceIdTableViewCell.swift
//  Ten
//
//  Created by Amit on 21/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol CreateTouchIdDelegate: NSObject {
    func didTapCreateTouchId()
}

class TouchIdableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnCreateTouchId: SmallBtn!
    @IBOutlet weak var lblTouchId: RegularText!
    @IBOutlet weak var vwContent: UIView!
    
    var biometricHelper: BiometricHelper?
    var userId = ApplicationManager.sharedInstance.userAccountManager.user.numID
    weak var delegate: CreateTouchIdDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContent.addShadow()
        self.btnCreateTouchId.addUnderline(title: Translation(Translations.AlertButtonsKeys.createTouchId, Translations.AlertButtonsKeys.createTouchIdDefault))
        self.lblTouchId.text = Translation(Translations.Titles.touchIdTitle, Translations.Titles.touchIdTitleDefault)
    }
    
    //IBAction:
    @IBAction func didTapCreateTouchId(_ sender: Any) {
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "touchId"
        popupInfoObj.strTitle = Translation(Translations.Titles.fingertipTooltip, Translations.Titles.fingertipTooltipDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.fingertipTooltip, Translations.SubTitles.fingertipTooltipDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.fingertipTooltip, Translations.AlertButtonsKeys.fingertipTooltipDefault)
        popupInfoObj.strSecondButtonTitle = Translation(Translations.AlertButtonsKeys.fingertipTooltipSkip, Translations.AlertButtonsKeys.fingertipTooltipSkipDefault)
        
        popupInfoObj.firstButtonAction = {
            
            let myContext = LAContext()
            let myLocalizedReasonString = Translation(Translations.SubTitles.setFingertipTooltipSubtitle, Translations.SubTitles.setFingertipTooltipSubtitleDefault)
            
            var authError: NSError?
            if #available(iOS 8.0, macOS 10.12.1, *) {
                if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                    myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                        
                        DispatchQueue.main.async {
                            if success {
                                let userDefaults = UserDefaults.standard
                                
                                userDefaults.set("TouchId", forKey: String(self.userId))

                                userDefaults.synchronize()
                                
                                if let delegate = self.delegate {
                                    delegate.didTapCreateTouchId()
                                }
                                
                            } else {
                             print("לא הצלחנו לתפוס את טביעת האצבע")
                            }
                        }
                    }
                } else {
                    print("יש להגדיר טביעת אצבע למכשיר")
                }
            } else {
                
            }
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        
       
    }
}



