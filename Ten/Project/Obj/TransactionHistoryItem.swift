//
//  item.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TransactionHistoryItem: BaseInnerResponse {
 
    var intId = 0
    var intType = 0
    var strIcon = ""
    var strDate = ""
    var strTime = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)

        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.intType = ParseValidator.getIntForKey(key: "type", JSONDict: JSONDict, defaultValue: 0)
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strDate = ParseValidator.getStringForKey(key: "date", JSONDict: JSONDict, defaultValue: "")
        self.strTime = ParseValidator.getStringForKey(key: "time", JSONDict: JSONDict, defaultValue: "")

        return self
    }
}

