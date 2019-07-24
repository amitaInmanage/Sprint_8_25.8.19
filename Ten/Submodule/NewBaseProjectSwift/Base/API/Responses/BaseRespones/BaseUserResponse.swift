//
//  BaseUserResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class BaseUserResponse: BaseInnerResponse {
    
    var user = User()
    var registerWithSmsAuth = false
    
    @objc @discardableResult override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.user = User().buildFromJSONDict(JSONDict: JSONDict) as! User
        
//        let arrScreensTemp = ParseValidator.getArrayForKey(key: "next_screensArr", JSONDict: JSONDict, defaultValue: [Any]())
//        let arrScreens = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: arrScreensTemp, innerResponse: ScreenName(), shouldReverseOrder: false) as! [ScreenName]
//        arrScreens.forEach { (screen) in
//            ApplicationManager.sharedInstance.userAccountManager.arrScreens.insert(screen)
//        }
        return self
    }
}
