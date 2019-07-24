//
//  SignUpCarDetailsViewModel.swift
//  Ten
//
//  Created by inmanage on 30/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpCarDetailsViewModel: BaseViewModel {
    
    var fieldsArr = [String:Any]()
    var fuelType = [String: Any]()
    
    var screenName = ""
    var readOnly: Bool = false
    var strIdNumberRO = ""
    var strLicensePlateRO = ""
    var strFuelTypeCodeRO = ""
    var strCode = ""
    var strIdNumber = ""
    var strCarNumber = ""
    var selectedIndexPath = 100
    var data = ApplicationManager.sharedInstance.appGD.fuelTypesArr
    var intLicensePlateMin = ApplicationManager.sharedInstance.appGD.licensePlateMin
    var intLicensePlateMax = ApplicationManager.sharedInstance.appGD.licensePlateMax
    var intIdNumberMin = ApplicationManager.sharedInstance.appGD.idNumberMin
    var intIdNumberMax = ApplicationManager.sharedInstance.appGD.idNumberMax
    var invalideLicensePlat = 57
    var invalideIdNumber = 156
    
    func validateIdNumber(strIdNumber: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{\(self.intIdNumberMin),\(self.intIdNumberMax)}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: strIdNumber)
    }
    
    func validateLicensePlat(strLicensePlate: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{\(self.intLicensePlateMin),\(self.intLicensePlateMax)}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: strLicensePlate)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String, vc: UIViewController? = nil) {
        
        let dict = [TenParamsNames.idNumber: self.strIdNumber, TenParamsNames.licensePlate: self.strCarNumber, TenParamsNames.fuelTypes: self.strCode] as [String:Any]
        
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}
