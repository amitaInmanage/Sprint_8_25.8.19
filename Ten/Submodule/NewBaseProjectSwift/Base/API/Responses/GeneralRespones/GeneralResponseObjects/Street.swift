//
//  Street.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class Street: BaseInnerResponse {
    
    var strTitle: String!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "name", JSONDict: JSONDict, defaultValue: "")
                
        return self
    }
    
}
