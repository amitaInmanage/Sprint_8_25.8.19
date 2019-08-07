//
//  UpdateFuelingDeviceResponse.swift
//  Ten
//
//  Created by Amit on 06/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class UpdateFuelingDeviceResponse: BaseInnerResponse {
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
        
        ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser
        
        return self
    }
    
}
