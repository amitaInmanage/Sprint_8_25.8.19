//
//  GetContentPageRequest.swift
//  WelcomeInSwift
//
//  Created by inmanage on 21/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class GetContentPageRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = GetContentPageResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
        
    }
    
    override var requestName: String {
        get {
            return ServerGeneralRequests.getContentPage
        }
    }
    
}
