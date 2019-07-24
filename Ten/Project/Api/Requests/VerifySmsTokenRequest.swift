//
//  VerifySmsTokenRequest.swift
//  Ten
//
//  Created by inmanage on 19/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class VerifySmsTokenRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = VerifySmsTokenResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getVerifySmsToken
        }
    }
}
