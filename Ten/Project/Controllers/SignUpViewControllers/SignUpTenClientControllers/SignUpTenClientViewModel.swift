//
//  SignUpTenClientViewModel.swift
//  Ten
//
//  Created by inmanage on 30/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpTenClientViewModel: BaseViewModel {
    
    var screenName = ""
    var fieldsArr = [String: Any]()
    var strBusinessId = ""
    var strLicensePlate = ""
    var intBusinessIdMax = ApplicationManager.sharedInstance.appGD.businessIdMax
    var intBusinessIdMin = ApplicationManager.sharedInstance.appGD.businessIdMin
    var intLicensePlateMin = ApplicationManager.sharedInstance.appGD.licensePlateMin
    var intLicensePlateMax = ApplicationManager.sharedInstance.appGD.licensePlateMax
    
    func moveToToolTipsPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .toolTips
        popupInfoObj.strTitle = Translation(Translations.Titles.businessIdToolTip, Translations.Titles.businessIdToolTipDefault)
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
    
    func validateBusinessId(strBusinessId: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{\(self.intBusinessIdMin),\(self.intBusinessIdMax)}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: strBusinessId)
    }
    
    func validateLicensePlat(strLicensePlate: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{\(self.intLicensePlateMin),\(self.intLicensePlateMax)}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: strLicensePlate)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String, vc: UIViewController? = nil) {
        
        let dict = [TenParamsNames.idNumber: self.strBusinessId, TenParamsNames.licensePlate: self.strLicensePlate]
       
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}
