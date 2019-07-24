//
//  ValidateVersionResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

enum VersionStatus: Int {
    case valid = 0, deprecated, notSupported
}

class ValidateVersionResponse: BaseInnerResponse {

    var strVersionState = ""
    var strAppStoreUrl = ""
    var strMessage = ""
    var versionStatus : VersionStatus = .valid
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strVersionState = ParseValidator.getStringForKey(key: "versionState", JSONDict: JSONDict, defaultValue: "")
        
        switch self.strVersionState {
        case "valid":
            self.versionStatus = .valid
        case "deprecated":
            self.versionStatus = .deprecated
        case "not supported":
            self.versionStatus = .notSupported
        default:
            self.versionStatus = .valid
        }
        
        self.strAppStoreUrl = ParseValidator.getStringForKey(key: "appStoreUrl", JSONDict: JSONDict, defaultValue: "")
        self.strMessage = ParseValidator.getStringForKey(key: "message", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }

}
