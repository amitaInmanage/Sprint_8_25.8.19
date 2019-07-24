//
//  FeatureFlags.swift
//  WelcomeInSwift
//
//  Created by inmanage on 27/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class FeatureFlags: BaseInnerResponse {
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        return self
        
    }
    
}
