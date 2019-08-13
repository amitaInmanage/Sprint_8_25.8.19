//
//  CustomerProgramBenefit.swift
//  Ten
//
//  Created by Amit on 13/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CustomerProgramBenefit: BaseInnerResponse {
    
    var intKey = 0
    var strTemplate = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intKey = ParseValidator.getIntForKey(key: "key", JSONDict: JSONDict, defaultValue: 0)
        self.strTemplate = ParseValidator.getStringForKey(key: "template", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
}
