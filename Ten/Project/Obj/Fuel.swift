//
//  FuelType.swift
//  Ten
//
//  Created by shani daniel on 27/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class Fuel: BaseInnerResponse {
    
    var strcode = ""
    var strTitle = ""
    var strImage = ""
    var strIconOn = ""
    var strIconOff = ""
    var intType = 0
    var strIcon = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intType = ParseValidator.getIntForKey(key: "fuel", JSONDict: JSONDict, defaultValue: 0)
        self.strcode = ParseValidator.getStringForKey(key: "code", JSONDict: JSONDict, defaultValue: "")
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strImage = ParseValidator.getStringForKey(key: "image", JSONDict: JSONDict, defaultValue: "")
        
        let icons = ParseValidator.getDictionaryForKey(key: "icons", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.strIconOn = ParseValidator.getStringForKey(key: "on", JSONDict: icons, defaultValue: "")
        self.strIconOff = ParseValidator.getStringForKey(key: "off", JSONDict: icons, defaultValue: "")
        return self
    }
}
