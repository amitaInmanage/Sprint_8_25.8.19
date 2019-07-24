//
//  GetStartUpImagesRequest.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class GetStartUpImagesRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = GetStartUpImagesResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
        
    }
    
    override var requestName: String {
        get {
            return ServerStartupRequests.getStartUpImages
        }
    }
    
}
