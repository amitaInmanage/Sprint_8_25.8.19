//
//  BaseMenuItem.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 26/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

enum DisplayOptions: UInt8 {
    case guest = 1, userLogin
}

class BaseMenuItem: BaseInnerResponse {
    
    var strTitle = ""
    var strSubTitle = ""
    var strIconImageName = ""
    var strSelectedIconImageName = ""
    var strIconURL = ""
    var strSelectedIconURL = ""
    var strDeepLink = ""    
    var isContentPage = false
    var menuItemType: BaseMenuItemType = .none
    var isStaticMenuItem = false
    var isLoginOnly = false
    var displayOptions: DisplayOptions = .guest
    
    @discardableResult override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strIconURL = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strDeepLink = ParseValidator.getStringForKey(key: "deep_link", JSONDict: JSONDict, defaultValue: "")
        let displayOptions = ParseValidator.getIntForKey(key: "display_options", JSONDict: JSONDict, defaultValue: 0)
        self.displayOptions = DisplayOptions(rawValue: UInt8(displayOptions)) ?? .guest
        //self.isLoginOnly = isUser.elementsEqual("1") ? true : false
        
        return self
        
    }
    

}
