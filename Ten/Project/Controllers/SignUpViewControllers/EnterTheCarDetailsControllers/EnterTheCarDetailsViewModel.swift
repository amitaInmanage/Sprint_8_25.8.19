//
//  EnterTheCardDescriptionViewModel.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class EnterTheCarDetailsViewModel: BaseViewModel {
    
    var fieldsArr = [String: Any]()
    var strFuilingCard = ""
    var strSecretCode = ""
    var screenName = ""
    var strAdditionalCard = ""
    var blockCard = 55
    var intSecretCodeMax = ApplicationManager.sharedInstance.appGD.secretCodeMax
    var intSecretCodeMin = ApplicationManager.sharedInstance.appGD.secretCodeMin
    var intFuilingCardMin = ApplicationManager.sharedInstance.appGD.tenCardMin
    var intFuilingCardMax = ApplicationManager.sharedInstance.appGD.tenCardMax
    
    func validateTenCard(strFuilingCard: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{\(self.intFuilingCardMin),\(self.intFuilingCardMax)}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: strFuilingCard)
    }
    
    func validatePassword(strSecretCode: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{\(self.intSecretCodeMin),\(self.intSecretCodeMax)}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: strSecretCode)
    }
    
    func moveToToolTipsPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .toolTips
        popupInfoObj.strTitle = Translation(Translations.Titles.toolTipsVipCard, Translations.Titles.toolTipsVipCardDefault)
        popupInfoObj.strImageName = "vipCard"
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
    
    func moveToBlockedPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "blocked"
        popupInfoObj.strTitle = Translation(Translations.Titles.userBlocked, Translations.Titles.userBlockedDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.userBlocked, Translations.SubTitles.userBlockedDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.blockUserContactUs, Translations.AlertButtonsKeys.blockUserContactUsDefault)
        popupInfoObj.firstButtonAction = {
            //TODO: send to Context Us with title: חסימת כרטיס טן
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String, vc: UIViewController? = nil) {
        
        let dict = [TenParamsNames.cardNumber: self.strFuilingCard, TenParamsNames.cardSecret: self.strSecretCode, TenParamsNames.isAdditionalCard: self.strAdditionalCard] as [String : Any]
        
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: vc as? RequestFinishedProtocol)
    }
}
