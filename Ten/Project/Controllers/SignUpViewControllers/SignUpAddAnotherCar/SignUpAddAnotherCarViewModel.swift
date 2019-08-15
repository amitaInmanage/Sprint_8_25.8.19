//
//  SignUpAddAnotherCarViewModel.swift
//  Ten
//
//  Created by inmanage on 02/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpAddAnotherCarViewModel: BaseViewModel {
    
    var fieldsArr = [String:Any]()
    
    func moveToTenGeneral() {
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "security"
        popupInfoObj.strSubtitle = StringManager.sharedInstance.replaceString(originalString: Translation(Translations.Titles.securityTooltip, Translations.Titles.securityTooltipDefault), replacement: ApplicationManager.sharedInstance.userAccountManager.user.strFirstName)
        popupInfoObj.strBottomText = Translation(Translations.SubTitles.securityTooltip, Translations.SubTitles.securityTooltipDefault)
        
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.securityTooltip, Translations.AlertButtonsKeys.securityTooltipDefault)
        popupInfoObj.strSecondButtonTitle = Translation(Translations.AlertButtonsKeys.onboardingSkip, Translations.AlertButtonsKeys.onboardingSkipDefault)
        popupInfoObj.firstButtonAction = {
            if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: FourDigitCodeViewController.className) as? FourDigitCodeViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
            }
        }
        popupInfoObj.secondButtonAction = {
            let secondPopupInfoObj = PopupInfoObj()
            secondPopupInfoObj.popupType = .tenGeneralPopup
            secondPopupInfoObj.strTitle = Translation(Translations.Titles.security2Tooltip, Translations.Titles.security2TooltipDefault)
            secondPopupInfoObj.strSubtitle = Translation(Translations.SubTitles.security2Tooltip, Translations.SubTitles.security2TooltipDefault)
            secondPopupInfoObj.strBottomText = Translation(Translations.SubTitles.security2TooltipBottom, Translations.SubTitles.security2TooltipBottomDefault)
            secondPopupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.security2Tooltip, Translations.AlertButtonsKeys.security2TooltipDefault)
            secondPopupInfoObj.strSecondButtonTitle = Translation(Translations.AlertButtonsKeys.security2TooltipSkip, Translations.AlertButtonsKeys.security2TooltipSkipDefault)
            secondPopupInfoObj.firstButtonAction = {
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: FourDigitCodeViewController.className) as? FourDigitCodeViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            }
            secondPopupInfoObj.secondButtonAction = {
                if let main = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: MainScreenViewController.className) as? MainScreenViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(main, animated: true)
                }
            }
            ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: secondPopupInfoObj, andPopupViewControllerDelegate: nil)
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String) {
    
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}

