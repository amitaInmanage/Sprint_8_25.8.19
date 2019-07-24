//
//  ShareObj.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 14/12/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ShareObj: BaseInnerResponse {

    var title = ""
    var link = ""
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.title = ParseValidator.getStringForKey(key: "text", JSONDict: JSONDict, defaultValue: "")
        self.link = ParseValidator.getStringForKey(key: "link", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }

}
