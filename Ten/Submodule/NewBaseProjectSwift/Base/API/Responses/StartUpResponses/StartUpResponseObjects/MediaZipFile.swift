//
//  MediaZipFile.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class MediaZipFile: BaseInnerResponse {

    var strMediaFilePath: String!
    var numMediaFileSize     = 0
    var numMediaFileCheckSum = 0
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strMediaFilePath = ParseValidator.getStringForKey(key: "path", JSONDict: JSONDict, defaultValue: "")
        self.numMediaFileSize = ParseValidator.getIntForKey(key: "size", JSONDict: JSONDict, defaultValue: 0)
        self.numMediaFileCheckSum = ParseValidator.getIntForKey(key: "check_sum", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
    
}
