//
//  CheckSmsTokenResponse.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 09/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class CheckSmsTokenResponse: BaseUserResponse {

    var isUserExist = false
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.isUserExist = ParseValidator.getBoolForKey(key: "user_exists", JSONDict: JSONDict, defaultValue: false)
        

        ApplicationManager.sharedInstance.userAccountManager.registrationToken = ParseValidator.getStringForKey(key: "registration_token", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
