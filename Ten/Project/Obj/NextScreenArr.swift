//
//  NextScreenArr.swift
//  Ten
//
//  Created by inmanage on 19/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class NextScreenArr: BaseInnerResponse {
    
    var screen = ""
    var orderNum = 0
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.screen = ParseValidator.getStringForKey(key: "screen", JSONDict: JSONDict, defaultValue: "")
        self.orderNum = ParseValidator.getIntForKey(key: "orderNum", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
