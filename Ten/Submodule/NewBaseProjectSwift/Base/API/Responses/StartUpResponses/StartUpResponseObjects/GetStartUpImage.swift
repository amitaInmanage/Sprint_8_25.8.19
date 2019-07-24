//
//  GetStartUpImage.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class GetStartUpImage: BaseInnerResponse {

    var strURL: String!
    var strMediaId: String!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strURL = ParseValidator.getStringForKey(key: "url", JSONDict: JSONDict, defaultValue: "")
        self.strMediaId = ParseValidator.getStringForKey(key: "media_id", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
