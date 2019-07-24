//
//  PersonalZoneViewModel.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalZoneViewModel: BaseViewModel {
 
    func moveToExitPopup() {
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.popupType = .exit
        popupInfoObj.strTitle = Translation(Translations.Titles.dialogDisconnectTitle, Translations.Titles.dialogDisconnectTitleDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.dialogDisconnectSubtitle, Translations.SubTitles.dialogDisconnectSubtitleDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.dialogDsconnectYes, Translations.AlertButtonsKeys.dialogDsconnectYesDefault)
        popupInfoObj.strSkipButtonTitle = Translation(Translations.AlertButtonsKeys.dialogDisconnectNo, Translations.AlertButtonsKeys.dialogDisconnectNoDefault)
        popupInfoObj.firstButtonAction = {
            if let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: SignUpWithPhoneNumberViewController.className) as? SignUpWithPhoneNumberViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                
            }
        }
        
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}
