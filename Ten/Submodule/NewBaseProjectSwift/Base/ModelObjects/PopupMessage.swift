//
//  PopupMessage.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 23/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class PopupMessage: BaseInnerResponse {

    var strTitle = ""
    var strSubtitle = ""
    var strContent = ""
    var strKey = ""
    var strImg = ""
    var arrButtons = [DynamicButton]()
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strSubtitle = ParseValidator.getStringForKey(key: "sub_title", JSONDict: JSONDict, defaultValue: "")
        self.strContent = ParseValidator.getStringForKey(key: "content", JSONDict: JSONDict, defaultValue: "")
        self.strKey = ParseValidator.getStringForKey(key: "key", JSONDict: JSONDict, defaultValue: "")
        self.strImg = ParseValidator.getStringForKey(key: "image", JSONDict: JSONDict, defaultValue: "")

        let arrButtons = ParseValidator.getArrayForKey(key: "buttonsArr", JSONDict: JSONDict, defaultValue: [DynamicButton]())
        self.arrButtons = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: arrButtons, innerResponse: DynamicButton(), shouldReverseOrder: false)
            as! [DynamicButton]
        
        return self
    }
}
