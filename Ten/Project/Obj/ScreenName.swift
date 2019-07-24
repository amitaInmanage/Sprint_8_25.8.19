//
//  ScreenName.swift
//  Ten
//
//  Created by Shani on 25/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class ScreenName: BaseInnerResponse {
    
    var intId = 0
    var strUrl = ""
    var strTitle = ""
    var screenName = ""
    var strIdNumber = ""
    var strLincensePlate = ""
    var strFuelTypeCode = ""
    var contentHtml = ""
    var intLicensePlate = 0
    var intFuelTypeCode = 0
    var strWebViewUrl = ""
    var sendUpdates = false
    var strIsAdditionalCard = ""
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.screenName = ParseValidator.getStringForKey(key: "screen", JSONDict: JSONDict, defaultValue: "")
        let err = ParseValidator.getDictionaryForKey(key: "err", JSONDict: JSONDict, defaultValue: [String : Any]())
        let data = ParseValidator.getDictionaryForKey(key: "data", JSONDict: JSONDict, defaultValue: [String : Any]())
        let content = ParseValidator.getDictionaryForKey(key: "content", JSONDict: data, defaultValue: [String : Any]())
        let additionalFuelingCard = ParseValidator.getDictionaryForKey(key: "additional_fueling_cardArr", JSONDict: data, defaultValue: [String : Any]())
        let defaultDataArr = ParseValidator.getDictionaryForKey(key: "default_dataArr", JSONDict: data, defaultValue: [String : Any]())
        
        self.strIdNumber = ParseValidator.getStringForKey(key: "id_number", JSONDict: defaultDataArr, defaultValue: "")
        self.strLincensePlate = ParseValidator.getStringForKey(key: "license_plate", JSONDict: defaultDataArr, defaultValue: "")
        self.strFuelTypeCode = ParseValidator.getStringForKey(key: "fuel_type_code", JSONDict: defaultDataArr, defaultValue: "")
        self.strIsAdditionalCard = ParseValidator.getStringForKey(key: "is_additional_card", JSONDict: data, defaultValue: "")
        self.intFuelTypeCode = ParseValidator.getIntForKey(key: "fuel_type_code", JSONDict: additionalFuelingCard, defaultValue: 0)
        self.intLicensePlate = ParseValidator.getIntForKey(key: "license_plate", JSONDict: additionalFuelingCard, defaultValue: 0)
        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: err, defaultValue: 0)
        self.strUrl = ParseValidator.getStringForKey(key: "url", JSONDict: content, defaultValue: "")
        self.strWebViewUrl = ParseValidator.getStringForKey(key: "url", JSONDict: data, defaultValue: "")
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: content, defaultValue: "")
        self.contentHtml = ParseValidator.getStringForKey(key: "content", JSONDict: content, defaultValue: "")
        self.sendUpdates = ParseValidator.getBoolForKey(key: "send_update", JSONDict: data, defaultValue: false)

        return self
    }
}
