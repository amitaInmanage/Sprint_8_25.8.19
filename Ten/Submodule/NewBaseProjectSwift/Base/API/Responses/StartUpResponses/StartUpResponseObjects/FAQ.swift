//
//  FAQ.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class FAQ: BaseInnerResponse {

    var strQuestion: String!
    var strAnswer: String!
    var isOpen = false
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strQuestion = ParseValidator.getStringForKey(key: "question", JSONDict: JSONDict, defaultValue: "")
        self.strAnswer = ParseValidator.getStringForKey(key: "answer", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
