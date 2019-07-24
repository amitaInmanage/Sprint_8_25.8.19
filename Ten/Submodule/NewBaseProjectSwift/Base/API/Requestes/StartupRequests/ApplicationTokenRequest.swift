//
//  ApplicationTokenRequest.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ApplicationTokenRequest: BaseRequest {
    
    static func createInitialDictParams() -> ([String:String]) {
        
        var initialDictParams = [String:String]()
        
        if let vendor = UIDevice.current.identifierForVendor {
             initialDictParams.updateValue(vendor.uuidString, forKey: "udid")
        }
        
        return initialDictParams
        
    }
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = ApplicationTokenResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
        
    }
    
    override var requestName: String {
        get {
            return ServerStartupRequests.getApplicationToken
        }
    }
    
    
}
