//
//  FulingDeviceArr.swift
//  Ten
//
//  Created by inmanage on 24/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class FulingDevice: BaseInnerResponse {
    
    var objFuel = Fuel()
    var strIcon = ""
    var intId = 0
    var objPayment = Payment()
    var strTitle = ""
    var intType = 0
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempFuel = ParseValidator.getDictionaryForKey(key: "fuel", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.objFuel = Fuel().buildFromJSONDict(JSONDict: tempFuel) as! Fuel
        
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        
        let tempPayment = ParseValidator.getDictionaryForKey(key: "payment", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.objPayment = Payment().buildFromJSONDict(JSONDict: tempPayment) as! Payment
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.intType = ParseValidator.getIntForKey(key: "type", JSONDict: JSONDict, defaultValue: 0)
        
        return self
    }
}
