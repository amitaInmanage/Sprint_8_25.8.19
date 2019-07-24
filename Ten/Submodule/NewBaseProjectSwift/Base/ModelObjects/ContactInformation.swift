//
//  ContactInformation.swift
//  Mindspace
//
//  Created by Amir-inManage on 06/07/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

struct ContactInformationKeys {
    static let email     = "email"
    static let cellphone = "cellphone"
    static let facebook  = "facebook"
    static let linkedin  = "linkedin"
    static let website   = "website"
    static let phone     = "phone"

}


class ContactInformation: BaseInnerResponse {

    var shouldShow = false
    var strContent = ""
    var strSocialID  = ""
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.shouldShow = ParseValidator.getBoolForKey(key: "show", JSONDict: JSONDict, defaultValue: false)
        self.strContent = ParseValidator.getStringForKey(key: "content", JSONDict: JSONDict, defaultValue: "")
        self.strSocialID = ParseValidator.getStringForKey(key: "social_id", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
