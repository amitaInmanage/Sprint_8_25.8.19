//
//  RegisterPushNotificationRequest.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class RegisterPushNotificationRequest: BaseRequest {

    static func createInitialDictParams() -> ([String:Any]) {
    
        var initialDictParams = [String:Any]()
        
        if let aStrDeviceToken = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: Constans.kDeviceToken) {
            initialDictParams.updateValue(aStrDeviceToken, forKey: Constans.kDeviceToken)
            
        }
    
        if let vendor = UIDevice.current.identifierForVendor {
            initialDictParams.updateValue(vendor.uuidString, forKey: "udid")
        }

        let numUserId = ApplicationManager.sharedInstance.userAccountManager.user.numID
        
        if numUserId > 0 {
            initialDictParams.updateValue(numUserId, forKey: "user_id")
        }

        return initialDictParams
    
    }
    
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = RegisterPushNotificationResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
        
    }
    
    override var requestName: String {
        get {
            return ServerStartupRequests.registerPushNotification
        }
    }
    
    
}
