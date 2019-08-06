//
//  Info.swift
//  Ten
//
//  Created by Amit on 06/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class Info: BaseInnerResponse {
    
    var carInspectionValidityDate = ""
    var carManufacturer = ""
    var carModel = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.carInspectionValidityDate = ParseValidator.getStringForKey(key: "car_inspection_validity_date", JSONDict: JSONDict, defaultValue: "")
        self.carManufacturer = ParseValidator.getStringForKey(key: "car_manufacturer", JSONDict: JSONDict, defaultValue: "")
        self.carModel = ParseValidator.getStringForKey(key: "car_model", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
