//
//  ConnectSocialAccountResponse.swift
//  Mindspace
//
//  Created by inmanage on 22/06/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

class ConnectSocialAccountResponse: BaseUserResponse {

    
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict["userArr"] as! [String: Any]!)
        
                
        return self
    }
    
}
