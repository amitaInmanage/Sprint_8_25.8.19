//
//  CheckSmsTokenRequest.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 08/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class CheckSmsTokenRequest: BaseRequest {

    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = CheckSmsTokenResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return ServerUserRequests.checkSmsToken
        }
    }
    
}
