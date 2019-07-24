//
//  SilentLoginRequest.swift
//  Mindspace
//
//  Created by inmanage on 25/06/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

class SilentLoginRequest: BaseRequest {

    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        let response = SilentLoginResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return ServerLoginCalls.silentLogin
        }
    }
    
    func getInitialDictParams () -> ([String: Any]) {
        
        var dict = [String: Any]()
        
        let strLoginHash = UserDefaults.standard.object(forKey: DiskKeys.loginHash) as? String
        
        if let aStrLoginHash = strLoginHash {
            dict.updateValue(aStrLoginHash, forKey: ServerLoginCallsParams.loginHash)
        }
        
        return dict
        
    }
    
}
