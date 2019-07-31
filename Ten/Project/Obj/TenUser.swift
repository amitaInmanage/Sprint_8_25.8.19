//
//  TenUser.swift
//  Ten
//
//  Created by inmanage on 07/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TenUser: User {
    
    fileprivate static let noAccumulation = -1
    
    var personelAreaMenuArr = [PersonalAreaMenuItem]()
    var fuelingDevicesArr = [FuelingDevicesItem]()
    var storePaymentMethods = [StorePaymentMethodsItem]()
    var powerCardArr = PowerCardItem()
    var accumulation = noAccumulation
    var hasPinCode = false
    var isClubMamber = true
    var isAcceptsUpdates = false
    
    public func hasAccumulation() -> Bool{
        return self.accumulation != TenUser.noAccumulation
    }
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        
        let personelAreaMenu = ParseValidator.getArrayForKey(key: "personal_area_menuArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.personelAreaMenuArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: personelAreaMenu, innerResponse: PersonalAreaMenuItem(), shouldReverseOrder: false) as! [PersonalAreaMenuItem]
        
        let storePaymentMethodsArr = ParseValidator.getArrayForKey(key: "store_payment_methodsArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.storePaymentMethods = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: storePaymentMethodsArr, innerResponse: StorePaymentMethodsItem(), shouldReverseOrder: false) as! [StorePaymentMethodsItem]
        
        
        let fuelingDevices = ParseValidator.getArrayForKey(key: "fueling_devicesArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.fuelingDevicesArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: fuelingDevices, innerResponse: FuelingDevicesItem(), shouldReverseOrder: false) as! [FuelingDevicesItem]
        
        let tempPowerCardArr = ParseValidator.getDictionaryForKey(key: "powercardArr", JSONDict: JSONDict, defaultValue: [String : Any]())
        
        self.powerCardArr = PowerCardItem().buildFromJSONDict(JSONDict: tempPowerCardArr) as! PowerCardItem
        
        //TODO: replace defualt value to false 
        self.isClubMamber = ParseValidator.getBoolForKey(key: "is_club_member", JSONDict: JSONDict, defaultValue: false)
        
        //TODO: replace defualt value to noAccumulation
        self.accumulation = ParseValidator.getIntForKey(key: "accumulation", JSONDict: JSONDict, defaultValue: self.accumulation)
        
        self.hasPinCode = ParseValidator.getBoolForKey(key: "has_pin_code", JSONDict: JSONDict, defaultValue: false)
        
        self.isAcceptsUpdates = ParseValidator.getBoolForKey(key: "accepts_updates", JSONDict: JSONDict, defaultValue: false)

        return self
    }
}

