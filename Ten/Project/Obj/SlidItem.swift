//
//  SlidItem.swift
//  Ten
//
//  Created by inmanage on 15/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SlidItem: BaseInnerResponse {

//    enum TitlePosition: String {
//        case top = "top"
//        case buttom = "buttom"
//    }
//
    var strContent = ""
    var intId = 0
    var strImage = ""
    var strTitle = ""
    var titlePosition = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strContent = ParseValidator.getStringForKey(key: "content", JSONDict: JSONDict, defaultValue: "")
        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.strImage = ParseValidator.getStringForKey(key: "image", JSONDict: JSONDict, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.titlePosition = ParseValidator.getStringForKey(key: "title_position", JSONDict: JSONDict, defaultValue: "")
        
//        TitlePosition.top = ParseValidator.getStringForKey(key: "title_position", JSONDict: JSONDict, defaultValue: "") == "top"
        return self
    }
}
