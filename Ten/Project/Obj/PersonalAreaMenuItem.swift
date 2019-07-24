//
//  PersonalAreaMenuItem.swift
//  Ten
//
//  Created by inmanage on 11/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalAreaMenuItem: BaseInnerResponse {
    
    var strIcon = ""
    var strTitle = ""
    var strDeepLink = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
     
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strDeepLink = ParseValidator.getStringForKey(key: "deeplink", JSONDict: JSONDict, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        
        
        return self
    }
    
}
