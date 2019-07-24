//
//  CachedMethod.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class CachedMethod: BaseInnerResponse {

    var methodName: String!
    var cacheTime = 0
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.methodName = ParseValidator.getStringForKey(key: "methodName", JSONDict: JSONDict, defaultValue: "")
        self.cacheTime = ParseValidator.getIntForKey(key: "cache_time", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
    
}
