//
//  FuelingDevicesItem.swift
//  Ten
//
//  Created by inmanage on 11/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class FuelingDevicesItem: BaseInnerResponse {
    
    var strIcon = ""
    var strTitle = ""
    var fuelItem = Fuel()
    var payment = Payment()
    var strId = ""
    var isExtended = false
    var objInfo = Info()
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempInfo = ParseValidator.getDictionaryForKey(key: "info", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.objInfo = Info().buildFromJSONDict(JSONDict: tempInfo) as! Info
        
        let tempFuelItem = ParseValidator.getDictionaryForKey(key: "fuel", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.fuelItem = Fuel().buildFromJSONDict(JSONDict: tempFuelItem) as! Fuel
        
        let tempPayment = ParseValidator.getDictionaryForKey(key: "payment", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.payment = Payment().buildFromJSONDict(JSONDict: tempPayment) as! Payment
        
        self.strId = ParseValidator.getStringForKey(key: "id", JSONDict: JSONDict, defaultValue: "")
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        
        
        return self
    }
}
