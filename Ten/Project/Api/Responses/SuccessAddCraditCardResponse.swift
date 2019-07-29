//
//  SuccessAddCraditCardResponse.swift
//  Ten
//
//  Created by Amit on 29/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SuccessAddCraditCardResponse: BaseInnerResponse {
    
    var user = TenUser()
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let dataObjecte = ParseValidator.getDictionaryForKey(key: "data", JSONDict: JSONDict, defaultValue: [String:Any]())
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: dataObjecte, defaultValue: [String:Any]())
        if !tempUser.isEmpty {
            
            ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser
            self.user = TenUser().buildFromJSONDict(JSONDict: tempUser) as! TenUser
            
        }
        return self
    }
}

