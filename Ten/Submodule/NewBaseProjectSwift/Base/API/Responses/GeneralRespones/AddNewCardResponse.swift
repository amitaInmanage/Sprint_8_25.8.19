//
//  AddNewCardResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class AddNewCardResponse : BaseInnerResponse {
    
    var urlString : URL!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.urlString = ParseValidator.getURLForKey(key: "url", JSONDict: JSONDict, defaultValue: URL(string: "")!)
        
        return self
    }
    
    
}
