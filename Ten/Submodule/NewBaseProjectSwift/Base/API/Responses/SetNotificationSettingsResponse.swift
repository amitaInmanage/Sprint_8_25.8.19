//
//  SetNotificationSettingsResponse.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 31/12/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class SetNotificationSettingsResponse: BaseInnerResponse {

    var pushTypes = false
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let notificationTypesArr = ParseValidator.getDictionaryForKey(key: "notification_typesArr", JSONDict: JSONDict, defaultValue: [String : Any]())
        
        self.pushTypes = ParseValidator.getBoolForKey(key: "push_types", JSONDict: notificationTypesArr, defaultValue: false)
        
        return self
    }
}
