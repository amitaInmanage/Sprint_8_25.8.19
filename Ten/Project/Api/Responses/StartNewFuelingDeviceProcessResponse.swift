//
//  StartNewFuelingDeviceProcessResponse.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StartNewFuelingDeviceProcessResponse: BaseInnerResponse {
    
    var token = ""
    var arrNextScreens = [ScreenName]()
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        
        self.token = ParseValidator.getStringForKey(key: "token", JSONDict: JSONDict, defaultValue: "")
        
        let tempScreens = ParseValidator.getArrayForKey(key: "next_screensArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.arrNextScreens = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempScreens, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]
        
        return self
        
    }
}

