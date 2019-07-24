//
//  PowerCardItem.swift
//  Ten
//
//  Created by inmanage on 11/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardItem: BaseInnerResponse {
    
    //TODO: cahnge defualt value to false
    var isHasCard = 0
    var intBudget = 0
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        //TODO: cahnge defualt value to false
       self.isHasCard = ParseValidator.getIntForKey(key: "has_card", JSONDict: JSONDict, defaultValue: 0)
       self.intBudget = ParseValidator.getIntForKey(key: "budget", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
