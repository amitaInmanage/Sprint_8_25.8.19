//
//  UpdateRegistrationDataResponse.swift
//  Ten
//
//  Created by inmanage on 20/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class UpdateRegistrationDataResponse: BaseInnerResponse {
    
    var arrNextScreens = [ScreenName]()
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempScreens = ParseValidator.getArrayForKey(key: "next_screensArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.arrNextScreens = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempScreens, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]

        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
        if !tempUser.isEmpty {
            ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser

        }
        return self
    }
}
