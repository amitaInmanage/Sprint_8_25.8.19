//
//  ApiPopup.swift
//  Ten
//
//  Created by inmanage on 18/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class ApiPopup: BaseInnerResponse {

    var strIcon = ""
    var strText = ""
    var numDuration = 0.0
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strText = ParseValidator.getStringForKey(key: "text", JSONDict: JSONDict, defaultValue: "")
        self.numDuration = ParseValidator.getDoubleForKey(key: "duration", JSONDict: JSONDict, defaultValue: 0.0)
        
        return self
        
    }
    
}
