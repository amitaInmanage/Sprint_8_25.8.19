//
//  StartNewFuelingDeviceProcessRequest.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation


class StartNewFuelingDeviceProcessRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = StartNewFuelingDeviceProcessResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getStarsNewFuelingDeviceProcess
        }
    }
}
