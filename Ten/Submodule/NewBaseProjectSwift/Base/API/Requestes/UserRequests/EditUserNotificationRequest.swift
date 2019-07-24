//
//  EditUserNotificationRequest.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class EditUserNotificationRequest: BaseRequest {
 
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        let response = EditUserNotificationResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return ServerUserRequests.editUserNotification
        }
    }
    
}