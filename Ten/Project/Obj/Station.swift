//
//  Station.swift
//  Ten
//
//  Created by shani daniel on 10/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//


import Foundation
import UIKit

class Station: BaseInnerResponse {
    
    var id = 0
    var orderNum = 0
    var strName = ""
    var strAddress = ""
    var StrRange = 0
    var isOpen = false

    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strName = ParseValidator.getStringForKey(key: "??", JSONDict: JSONDict, defaultValue: "") //need to get the real key??
        self.strAddress = ParseValidator.getStringForKey(key: "??", JSONDict: JSONDict, defaultValue: "")// need to get the real key??
        self.StrRange = ParseValidator.getIntForKey(key: "??", JSONDict: JSONDict, defaultValue: 0) // need to get the real key ??
        self.isOpen = ParseValidator.getBoolForKey(key: "??", JSONDict: JSONDict, defaultValue: false)//need to get the real key??
        
        self.id = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)//need to get the real key??
        self.orderNum = ParseValidator.getIntForKey(key: "order_num", JSONDict: JSONDict, defaultValue: 0)//need to get the real key??
        
        return self
    }
}
