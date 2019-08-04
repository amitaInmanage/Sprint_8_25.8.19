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
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempFuelItem = ParseValidator.getDictionaryForKey(key: "fuel", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.fuelItem = Fuel().buildFromJSONDict(JSONDict: tempFuelItem) as! Fuel
        
        let tempPayment = ParseValidator.getDictionaryForKey(key: "payment", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.payment = Payment().buildFromJSONDict(JSONDict: tempPayment) as! Payment
        
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        
        
        return self
    }
}
