//
//  UsageAmount.swift
//  Ten
//
//  Created by Amit on 25/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation
class UsageAmount: BaseInnerResponse {
    
    var intDisplay = 0
    var intValue = 0
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intDisplay = ParseValidator.getIntForKey(key: "display", JSONDict: JSONDict, defaultValue: 0)
        self.intValue = ParseValidator.getIntForKey(key: "value", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
