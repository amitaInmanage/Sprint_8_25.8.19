//
//  ApplicationTokenResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ApplicationTokenResponse: BaseInnerResponse {
    
    var strApplicationToken : String = ""

    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strApplicationToken = ParseValidator.getStringForKey(key: "token", JSONDict: JSONDict, defaultValue: "")
        
        return self
        
    }
    
}
