//
//  UpdateRegistrationDataRequest.swift
//  Ten
//
//  Created by inmanage on 20/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class UpdateRegistrationDataRequest: BaseRequest {

    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = UpdateRegistrationDataResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getUpdateRegistrationData
        }
    }
}


