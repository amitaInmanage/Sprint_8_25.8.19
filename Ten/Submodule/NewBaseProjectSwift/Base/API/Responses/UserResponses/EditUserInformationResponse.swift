//
//  EditUserInformationResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class EditUserInformationResponse: BaseUserResponse {
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
      let user = TenUser().buildFromJSONDict(JSONDict: tempUser) as! TenUser

            ApplicationManager.sharedInstance.userAccountManager.user = user

        return self
    }
}
