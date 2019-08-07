//
//  StoreHistory.swift
//  Ten
//
//  Created by Amit on 25/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class StoreHistoey: BaseInnerResponse {
    
    var intId = ""
    var strTitle = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intId = ParseValidator.getStringForKey(key: "id", JSONDict: JSONDict, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
