//
//  SilentLoginResponse.swift
//  Mindspace
//
//  Created by inmanage on 25/06/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

class SilentLoginResponse: BaseUserResponse {

    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        return self
    }
    
    
}
