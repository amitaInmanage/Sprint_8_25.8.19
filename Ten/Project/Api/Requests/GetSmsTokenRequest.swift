//
//  GetSmsTokenRequest.swift
//  Ten
//
//  Created by inmanage on 18/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class GetSmsTokenRequest: BaseRequest {
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        let response = GetSmsTokenResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getSmsToken
        }
    }
}
