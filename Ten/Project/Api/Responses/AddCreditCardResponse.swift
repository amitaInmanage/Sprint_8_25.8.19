//
//  AddCreditCardResponse.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class AddCreditCardResponse: BaseInnerResponse {
    
    var strUrl = ""
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
  
        self.strUrl = ParseValidator.getStringForKey(key: "url", JSONDict: JSONDict, defaultValue: "")
        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
        if !tempUser.isEmpty {
            ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser
        }
        
        return self
    }
}
