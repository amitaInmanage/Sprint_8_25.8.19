//
//  Avarage.swift
//  Ten
//
//  Created by Amit on 19/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class Avarage: BaseInnerResponse {
    
    var intLiter = 0
    var intSum = 0
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intLiter = ParseValidator.getIntForKey(key: "litre", JSONDict: JSONDict, defaultValue: 0)
        self.intSum = ParseValidator.getIntForKey(key: "sum", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
