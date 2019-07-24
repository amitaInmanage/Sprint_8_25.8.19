//
//  GetCitiesStreetsResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class GetCitiesStreetsResponse: BaseInnerResponse {
    
    var arrStreets : [Street]!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let notParsedStreets = ParseValidator.getArrayForKey(key: "streetsArr", JSONDict: JSONDict, defaultValue: [Any]())
        
        self.arrStreets = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: notParsedStreets, innerResponse: Street(), shouldReverseOrder: false) as! [Street]
        
        
        return self
    }
    
}
