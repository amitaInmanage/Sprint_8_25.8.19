//
//  SetUserCustomerProgramRequest.swift
//  Ten
//
//  Created by Amit on 13/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class SetUserCustomerProgramRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = SetUserCustomerProgramResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getSetUserCustomerProgram
        }
    }
}
