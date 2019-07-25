//
//  AmountHistory.swift
//  Ten
//
//  Created by Amit on 25/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class AmountHistory: BaseInnerResponse {
    
    var intDisplay = 0
    var strValue = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)

        self.intDisplay = ParseValidator.getIntForKey(key: "display", JSONDict: JSONDict, defaultValue: 0)
        self.strValue = ParseValidator.getStringForKey(key: "value", JSONDict: JSONDict, defaultValue: "")
       
        
        return self
    }
}
