//
//  ApplicationImage.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

// Keys for retrieving the object from application dictionary property

let kApplicationBackground = "application_background"
let kDefaultUserImage = "default_user_image"

class ApplicationImage: BaseInnerResponse {

    var numType = 0
    var strImageUrl: String!
    var addUnderscoreIphone = false
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.numType = ParseValidator.getIntForKey(key: "type", JSONDict: JSONDict, defaultValue: 0)
        
        if self.numType == 1 {
            
            self.strImageUrl = ParseValidator.getStringForKey(key: "image_path", JSONDict: JSONDict, defaultValue: "")
            self.addUnderscoreIphone = true
            
        } else if self.numType == 2 {
            
            self.addUnderscoreIphone = false
            
            let dictImages = ParseValidator.getDictionaryForKey(key: "imagesArr", JSONDict: JSONDict, defaultValue: [String:Any]())
            
            if dictImages.count > 0 {
                
                if DeviceType.IS_IPHONE_4_OR_LESS {
                    self.strImageUrl = ParseValidator.getStringForKey(key: "iPhone4", JSONDict: JSONDict, defaultValue: "")
                } else if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_6 {
                    self.strImageUrl = ParseValidator.getStringForKey(key: "iPhone5_6", JSONDict: JSONDict, defaultValue: "")
                } else {
                    self.strImageUrl = ParseValidator.getStringForKey(key: "iPhoneBIG", JSONDict: JSONDict, defaultValue: "")
                }
            }
        }
        
        return self
    }
    
}
