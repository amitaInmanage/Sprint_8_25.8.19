//
//  SumByMountItem.swift
//  Ten
//
//  Created by Amit on 19/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class SumByMountItem: BaseInnerResponse {
    
    var strMonth = ""
    var intOrderNum = 0
    var intSum = 0
    var intYear = 0

    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strMonth = ParseValidator.getStringForKey(key: "month", JSONDict: JSONDict, defaultValue: "")
        self.intOrderNum = ParseValidator.getIntForKey(key: "order_num", JSONDict: JSONDict, defaultValue: 0)
        self.intSum = ParseValidator.getIntForKey(key: "sum", JSONDict: JSONDict, defaultValue: 0)
        self.intYear = ParseValidator.getIntForKey(key: "year", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
