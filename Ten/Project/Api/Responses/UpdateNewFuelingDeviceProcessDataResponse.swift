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

        let tempScreens = ParseValidator.getArrayForKey(key: "next_screensArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.arrNextScreens = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempScreens, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]
        
        return self
        
    }
}
