//
//  ExtraSecurity.swift
//  Ten
//
//  Created by shani daniel on 04/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//



import Foundation

import UIKit

class ExtraSecurity: BaseInnerResponse {
   
    var id = 0
    var orderNum = 0
    var strType = ""
    var strTitle = ""
    var strIconUrl = ""
   
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strIconUrl = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")// need to get the from server
        self.strType = ParseValidator.getStringForKey(key: "type", JSONDict: JSONDict, defaultValue: "")
        self.id = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.orderNum = ParseValidator.getIntForKey(key: "order_num", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}


