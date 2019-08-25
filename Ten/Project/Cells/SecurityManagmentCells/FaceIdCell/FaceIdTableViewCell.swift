//
//  FaceIdTableViewCell.swift
//  Ten
//
//  Created by Amit on 21/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//


import UIKit
import LocalAuthentication

protocol CreateFaceIdDelegate: NSObject {
    func didTapCreateFaceId()
}


class FaceIdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnCreateFaceId: SmallBtn!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblFaceId: RegularText!
    
    weak var delegate: CreateFaceIdDelegate?
    var userId = ApplicationManager.sharedInstance.userAccountManager.user.numID
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
        
    }
    
    fileprivate func initUI() {
        self.vwContent.addShadow()
        self.btnCreateFaceId.addUnderline(title: Translation(Translations.AlertButtonsKeys.crateFaceId, Translations.AlertButtonsKeys.crateFaceIdDefault))
        self.lblFaceId.text = Translation(Translations.Titles.faceIdTitle, Translations.Titles.faceIdTitleDefault)
    }
    
    //IBAction:
    @IBAction func didTapCreateFaceId(_ sender: Any) {
        
        print("hello there!.. You have clicked the touch ID")
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "faceId"
        popupInfoObj.strTitle = Translation(Translations.Titles.faceIdTooltip, Translations.Titles.faceIdTooltipDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.faceIdTooltip, Translations.SubTitles.faceIdTooltipDefault)
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
                                
                                userDefaults.setValue("FaceId", forKey: String(self.userId))
                                
                                userDefaults.synchronize()
                                
                                if let delegate = self.delegate {
                                    delegate.didTapCreateFaceId()
                                }
                            } else {
                                print("לא הצלחנו לתפוס את סריקת הפנים")
                            }
                        }
                    }
                } else {
                    print("יש להגדיר סריקת פנים למכשיר")
                }
            } else {
              
            }
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}
