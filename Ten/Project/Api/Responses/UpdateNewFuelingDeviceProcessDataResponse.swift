//
//  UpdateNewFuelingDeviceProcessData.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class UpdateNewFuelingDeviceProcessDataResponse: BaseInnerResponse {
  
    var arrNextScreens = [ScreenName]()
    
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)

        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
        if !tempUser.isEmpty {
            ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser
        }
        
        if JSONDict["data"] != nil {
            
            let data = ParseValidator.getDictionaryForKey(key: "data", JSONDict: JSONDict, defaultValue: [String : Any]())
            
            let tempScreens = ParseValidator.getArrayForKey(key: "next_screensArr", JSONDict: data, defaultValue: [Any]())
            self.arrNextScreens = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempScreens, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]
            
        } else {
            
            let tempScreens = ParseValidator.getArrayForKey(key: "next_screensArr", JSONDict: JSONDict, defaultValue: [Any]())
            self.arrNextScreens = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempScreens, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]
        }
    
        return self
        
    }
}
