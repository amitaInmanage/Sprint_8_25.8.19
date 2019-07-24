//
//  Language.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class Language: BaseInnerResponse {

    var strTitle: String!
    var strLangDescription: String!
    var strTitleShow: String!
    var isActive = false
    var languageDirection : LanguageDirection!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strLangDescription = ParseValidator.getStringForKey(key: "description", JSONDict: JSONDict, defaultValue: "")
        self.strTitleShow = ParseValidator.getStringForKey(key: "title_show", JSONDict: JSONDict, defaultValue: "")
        
        let langDirection = ParseValidator.getIntForKey(key: "direction", JSONDict: JSONDict, defaultValue: 1)
        self.languageDirection = LanguageDirection(rawValue: langDirection)
                
        return self
    }
    
}
