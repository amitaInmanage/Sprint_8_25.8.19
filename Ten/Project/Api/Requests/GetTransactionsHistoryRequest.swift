//
//  GetTransactionsHistoryRequest.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class GetTransactionsHistoryRequest: BaseRequest {
    
    
    override func createOuterResponseFromJSONDict(JSONDict: Dictionary<String, Any>) -> BaseOuterResponse? {
        let response = GetTransactionsHistoryResponse()
        
        return  BaseOuterResponse.initFromJSONDict(JSONDict:JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return TenRequestNames.getTransactionsHistory
        }
    }
    
}
