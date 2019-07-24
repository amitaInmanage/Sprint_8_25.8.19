//
//  VerifyPinCodeRequests.swift
//  Ten
//
//  Created by Amit on 22/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class VerifyPinCodeRequests: BaseRequest {
    
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = VerifyPinCodeResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getVerifyPinCode
        }
    }
    
}
