//
//  ContentPage.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ContentPage: BaseMenuItem {

    var showInMenu = false
    var strHTMLContent: String?
    var urlString: URL?
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.showInMenu = ParseValidator.getBoolForKey(key: "show_in_menu", JSONDict: JSONDict, defaultValue: false)
        self.isContentPage = true
        self.strHTMLContent = ParseValidator.getStringForKey(key: "content", JSONDict: JSONDict, defaultValue: "")
        self.urlString = ParseValidator.getURLForKey(key: "url", JSONDict: JSONDict, defaultValue: URL(string: ""))
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
