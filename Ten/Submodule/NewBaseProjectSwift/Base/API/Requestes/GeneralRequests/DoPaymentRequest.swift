//
//  DoPaymentRequest.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class DoPaymentRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = DoPaymentResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
 
    override var requestName: String {
        get {
            return ServerPaymentRequests.doPayment
        }
    }
    
}
