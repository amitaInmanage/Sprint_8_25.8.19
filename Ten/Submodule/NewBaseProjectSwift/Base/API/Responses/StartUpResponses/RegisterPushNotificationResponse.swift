//
//  RegisterPushNotificationResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class RegisterPushNotificationResponse: BaseInnerResponse {
    
    var pushTypes = false

    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let notificationTypesArr = ParseValidator.getDictionaryForKey(key: "notification_typesArr", JSONDict: JSONDict, defaultValue: [String : Any]())
        
        self.pushTypes = ParseValidator.getBoolForKey(key: "push_types", JSONDict: notificationTypesArr, defaultValue: false)
        
        return self
    }
    
}
