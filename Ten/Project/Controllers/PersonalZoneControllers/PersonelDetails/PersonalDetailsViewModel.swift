//
//  PersonalDetailsViewModel.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalDetailsViewModel: BaseViewModel {
    
    var strEmail = ""
    var strFirstName = ""
    var strLastName = ""
    var strGender = ""
    var strCellPhone = ""
    var strAcceptsUpdates = false
    
    func buildJsonAndSendEditUserInformation(vc: UIViewController?) {
        
        let dict = [TenParamsNames.firstName: self.strFirstName,
                    TenParamsNames.lastName: self.strLastName,
                    TenParamsNames.email: self.strEmail,
                    TenParamsNames.gender: self.strGender,
                    TenParamsNames.acceptsUpdates: self.strAcceptsUpdates] as [String : Any]
        
        ApplicationManager.sharedInstance.userAccountManager.callEditUserInformation(dictParams: dict, andRequestFinishedDelegate: vc as! RequestFinishedProtocol)
    }
    
}
