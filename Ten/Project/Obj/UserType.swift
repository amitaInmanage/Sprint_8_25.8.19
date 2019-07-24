//
//  UserType.swift
//  Ten
//
//  Created by shani daniel on 17/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//


import UIKit

class UserType: BaseInnerResponse {
    
    var intId = 0
    var orderNum = 0
    var strTitle = ""
    var strIconOn = ""
    var strIconOff = ""
    var strIconUrl = ""
    var strSubTitle = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strSubTitle = ParseValidator.getStringForKey(key: "subtitle", JSONDict: JSONDict, defaultValue: "")
        self.strIconUrl = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        
        let icons = ParseValidator.getDictionaryForKey(key: "icons", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.strIconOn = ParseValidator.getStringForKey(key: "on", JSONDict: icons, defaultValue: "")
        self.strIconOff = ParseValidator.getStringForKey(key: "off", JSONDict: icons, defaultValue: "")
        return self
    }
}


