//
//  PersonalDetailsViewModel.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalDetailsViewModel: BaseViewModel {
    var strCurrentEmail = ""
    var strEmail = ""
    var strFirstName = ""
    var strLastName = ""
    var intGenderId = 0
    var strCellPhone = ""
    var strAcceptsUpdates = false
    
    func buildJsonAndSendEditUserInformation(vc: UIViewController?) {
        
        var dict = [TenParamsNames.firstName: self.strFirstName,
                    TenParamsNames.lastName: self.strLastName,
                    TenParamsNames.gender: self.intGenderId,
                    TenParamsNames.acceptsUpdates: self.strAcceptsUpdates] as [String : Any]
        
        if strCurrentEmail != strEmail {
             dict.updateValue(strEmail, forKey: TenParamsNames.email)
        }
       
        ApplicationManager.sharedInstance.userAccountManager.callEditUserInformation(dictParams: dict, andRequestFinishedDelegate: vc as! RequestFinishedProtocol)
    }
}
