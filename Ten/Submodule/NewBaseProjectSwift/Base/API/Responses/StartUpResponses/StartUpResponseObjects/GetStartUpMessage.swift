//
//  GetStartUpMessage.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class GetStartUpMessage: BaseInnerResponse {

    var strMessage: String!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strMessage = ParseValidator.getStringForKey(key: "message", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
