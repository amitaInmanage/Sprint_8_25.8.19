//
//  ErrorReportResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class ErrorReportResponse: BaseInnerResponse {
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        return self
    }
    
}
