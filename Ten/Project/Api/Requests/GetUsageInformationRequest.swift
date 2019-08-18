//
//  GetUsageInformationRequest.swift
//  Ten
//
//  Created by Amit on 18/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class GetUsageInformationRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = GetUsageInformationResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getUsageInformation
        }
    }
}
