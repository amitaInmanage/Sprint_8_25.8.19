//
//  SetNotificationSettingsRequest.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 31/12/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class SetNotificationSettingsRequest: BaseRequest {

    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = SetNotificationSettingsResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return ServerGeneralRequests.setNotificationSettings
        }
    }
    
    
}
