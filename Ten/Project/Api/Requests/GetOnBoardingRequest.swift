//
//  GetOnBoarding.swift
//  Ten
//
//  Created by inmanage on 15/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class GetOnBoardingRequest: BaseRequest {
    
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = GetOnBoardingResponse()
        
         return BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getOnBoarding
        }
    }
    
}
