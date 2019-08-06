//
//  UpdateFuelingDeviceRequest.swift
//  Ten
//
//  Created by Amit on 06/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class UpdateFuelingDeviceRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = UpdateFuelingDeviceResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getUpdateFuelingDevice
        }
    }
}

