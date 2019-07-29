//
//  AddCreditCardResponse.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class AddCreditCardResponse: BaseInnerResponse {
    
    var strUrl = ""
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
  
        self.strUrl = ParseValidator.getStringForKey(key: "url", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
}
