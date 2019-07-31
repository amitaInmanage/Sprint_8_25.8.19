//
//  SignUpFullNameViewModel.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpFullNameViewModel: BaseViewModel {
    
    var fieldsArr = [String: Any]()
    var screenName = ""
    var strFirstName = ""
    var strLastName = ""
    
    func validateFirstName() -> Bool {
        return ApplicationManager.sharedInstance.inputValidationManager.isHebrewValidSingleName(name: strFirstName)
    }
    
    func validateLastName() -> Bool {
        return ApplicationManager.sharedInstance.inputValidationManager.isHebrewValidSingleName(name: strLastName)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String) {
        let dict = [updateRegistrationParams.firstName: self.strFirstName, updateRegistrationParams.lastName: self.strLastName]
        
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}
