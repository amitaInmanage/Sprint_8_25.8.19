//
//  GetCitiesResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class GetCitiesResponse: BaseInnerResponse {
    
    var dicCities: [String:Any]!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempDictCites = ParseValidator.getDictionaryForKey(key: "citiesArr", JSONDict: JSONDict, defaultValue: [String:Any]())
        self.dicCities = tempDictCites
        
        return self
    }
    
}
