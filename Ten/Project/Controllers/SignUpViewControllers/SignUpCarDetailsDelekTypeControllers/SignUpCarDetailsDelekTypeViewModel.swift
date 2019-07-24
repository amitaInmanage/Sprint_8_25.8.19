//
//  SignUpCarDetailsDelekTypeViewModel.swift
//  Ten
//
//  Created by inmanage on 26/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpCarDetailsDelekTypeViewModel: BaseViewModel {
    
    var strCode = ""
    var screenName = ""
    var strCarNumber = ""
    var selectedIndexPath = 100
    var fieldsArr = [String:Any]()
    var fuelType = [String: Any]()
    var data = ApplicationManager.sharedInstance.appGD.fuelTypesArr
    
    func validateCarNumber() ->Bool {
        return ApplicationManager.sharedInstance.inputValidationManager.isValidCarNumber(carStr: strCarNumber)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String) {
        
        let dict = [TenParamsNames.licensePlate: self.strCarNumber, TenParamsNames.fuelTypes: self.strCode] as [String:Any]
        
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}
