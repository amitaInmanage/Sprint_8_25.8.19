//
//  VerifySmsTokenResponse.swift
//  Ten
//
//  Created by inmanage on 19/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class VerifySmsTokenResponse: BaseInnerResponse {
    
    var userExists = false
    var registrationToken = ""
    var nextScreenArr = [ScreenName]()
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
        if !tempUser.isEmpty {
            ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser
            
        }
        
        self.userExists = ParseValidator.getBoolForKey(key: "user_exists", JSONDict: JSONDict, defaultValue: false)
        self.registrationToken = ParseValidator.getStringForKey(key: "registration_token", JSONDict: JSONDict, defaultValue: "")
        let tempNextScreenDict = ParseValidator.getArrayForKey(key: "next_screensArr",JSONDict: JSONDict, defaultValue: [Any]())
        self.nextScreenArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempNextScreenDict, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]
        
        return self
    }
}

