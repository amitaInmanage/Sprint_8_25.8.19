//
//  CustomerProgramItem.swift
//  Ten
//
//  Created by Amit on 13/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class CustomerProgramItem: BaseInnerResponse {
    
    var intId = 0
    var strName = ""
    var strDescription = ""
    var strNotes = ""
    var strFuelBenefitType = ""
    var strfuelBenefitValue = ""
    var strSurroundingsType = ""
    var strSurroundingsValue = ""
    var strStoreBenefitType = ""
    var strStoreBenefitValue = ""
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.strName = ParseValidator.getStringForKey(key: "name", JSONDict: JSONDict, defaultValue: "")
        self.strDescription = ParseValidator.getStringForKey(key: "description", JSONDict: JSONDict, defaultValue: "")
        self.strNotes = ParseValidator.getStringForKey(key: "notes", JSONDict: JSONDict, defaultValue: "")
        self.strFuelBenefitType = ParseValidator.getStringForKey(key: "fuel_benefit_type", JSONDict: JSONDict, defaultValue: "")
        self.strfuelBenefitValue = ParseValidator.getStringForKey(key: "fuel_benefit_value", JSONDict: JSONDict, defaultValue: "")
        self.strSurroundingsType = ParseValidator.getStringForKey(key: "surroundings_benefit_type", JSONDict: JSONDict, defaultValue: "")
        self.strSurroundingsValue = ParseValidator.getStringForKey(key: "surroundings_benefit_value", JSONDict: JSONDict, defaultValue: "")
        self.strStoreBenefitType = ParseValidator.getStringForKey(key: "store_benefit_type", JSONDict: JSONDict, defaultValue: "")
        self.strStoreBenefitValue = ParseValidator.getStringForKey(key: "store_benefit_value", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
}
