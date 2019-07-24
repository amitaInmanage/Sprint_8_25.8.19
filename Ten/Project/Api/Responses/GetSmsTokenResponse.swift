//
//  GetSmsTokenResponse.swift
//  Ten
//
//  Created by inmanage on 18/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class GetSmsTokenResponse: BaseInnerResponse {
    
    var token = ""
    var userExists = false
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.token = ParseValidator.getStringForKey(key: "token", JSONDict: JSONDict, defaultValue: "")
        self.userExists = ParseValidator.getBoolForKey(key: "user_exists", JSONDict: JSONDict, defaultValue: false)
        
        return self
    }
}
