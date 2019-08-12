//
//  RemovePowerCardRequest.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class RemovePowerCardRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = RemovePowerCardResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getRemovePowerCard
        }
    }
}
