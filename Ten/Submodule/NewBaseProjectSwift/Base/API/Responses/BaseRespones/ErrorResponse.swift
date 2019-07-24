//
//  ErrorResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ErrorResponse: BaseInnerResponse {
    
    var strContent: String?
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strContent = ParseValidator.getStringForKey(key: "content", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
