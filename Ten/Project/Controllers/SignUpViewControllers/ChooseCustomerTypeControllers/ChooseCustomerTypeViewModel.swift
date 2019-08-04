//
//  ChooseCustomerTypeViewModel.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class ChooseCustomerTypeViewModel: BaseViewModel {
    
    var screenName = ""
    var selectedIndexPath = 100
    var fieldsArr = [String: Any]()
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var data = ApplicationManager.sharedInstance.appGD.usersTypesArr
    var intType = 0
   
    func buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: String) {
        
        let dict = [TenParamsNames.customerType: self.intType]
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateNewFuelingDeviceProcessData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String) {
        
        let dict = [TenParamsNames.customerType: self.intType]
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
      
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}
