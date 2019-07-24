//
//  DoPaymentResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class DoPaymentResponse: BaseInnerResponse {
    
    var urlString : URL!
    var strURL : String!
    var strPrice  : String!
    
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.urlString = ParseValidator.getURLForKey(key: "url", JSONDict: JSONDict, defaultValue: URL(string: "")!)
        
        if self.urlString.absoluteString.isEmpty {
            self.strURL = ParseValidator.getStringForKey(key: "url", JSONDict: JSONDict, defaultValue: "")
        }
        
        self.strPrice = ParseValidator.getStringForKey(key: "total_price", JSONDict: JSONDict, defaultValue: "")
        
        
        return self
    }
    
}
