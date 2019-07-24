//
//  City.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class City: BaseInnerResponse {
    
    var strTitle: String!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        if let firstKey = JSONDict.keys.first {
            
            self.numID = Int(firstKey)!
            self.strTitle = ParseValidator.getStringForKey(key: firstKey, JSONDict: JSONDict, defaultValue: "")
            
        } else {
            self.strTitle = ""
        }
        
        
        return self
    }
    
}
