//
//  Payment.swift
//  Ten
//
//  Created by inmanage on 24/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class Payment: BaseInnerResponse {

    var strIcon = ""
    var intType = 0
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.intType = ParseValidator.getIntForKey(key: "type", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
