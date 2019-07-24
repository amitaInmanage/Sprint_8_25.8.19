//
//  GameButton.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 26/09/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class DynamicButton: BaseInnerResponse {
    
    var strTitle = ""
    var strDeeplink = ""
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strDeeplink = ParseValidator.getStringForKey(key: "deeplink", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}

