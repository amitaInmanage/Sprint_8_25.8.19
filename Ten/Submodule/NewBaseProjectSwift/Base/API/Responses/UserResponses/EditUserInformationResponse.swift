//
//  EditUserInformationResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class EditUserInformationResponse: BaseUserResponse {
    
    var tenUser = TenUser()
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String : Any]())
        
        self.tenUser = TenUser().buildFromJSONDict(JSONDict: tempUser) as! TenUser
        
        return self
    }
}
