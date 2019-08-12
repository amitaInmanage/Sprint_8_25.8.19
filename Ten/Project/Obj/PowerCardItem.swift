//
//  PowerCardItem.swift
//  Ten
//
//  Created by inmanage on 11/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardItem: BaseInnerResponse {
    
  
    var isHasCard = false
    var strBudget = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
       self.isHasCard = ParseValidator.getBoolForKey(key: "has_card", JSONDict: JSONDict, defaultValue: false)
       self.strBudget = ParseValidator.getStringForKey(key: "budget", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
}
