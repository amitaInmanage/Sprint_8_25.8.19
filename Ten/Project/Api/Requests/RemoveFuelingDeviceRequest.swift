//
//  RemoveFuelingDeviceRequest.swift
//  Ten
//
//  Created by Amit on 05/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class RemoveFuelingDeviceRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = RemoveFuelingDeviceResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getRemoveFuelingDevice
        }
    }
}

