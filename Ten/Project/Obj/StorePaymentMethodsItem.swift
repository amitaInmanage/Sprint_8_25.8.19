//
//  StorePaymentMethodsItem.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StorePaymentMethodsItem: BaseInnerResponse {
    
    var intOrderNum = 0
    var intId = 0
    var strtitle = ""
    var isActiveInStore = false
    var intType = 0
    var strIcon = ""
    var isRemovable = false 
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
       
        self.intOrderNum = ParseValidator.getIntForKey(key: "order_num", JSONDict: JSONDict, defaultValue: 0)
        self.intId = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.intType = ParseValidator.getIntForKey(key: "type", JSONDict: JSONDict, defaultValue: 0)
        self.strtitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.isRemovable = ParseValidator.getBoolForKey(key: "is_removable", JSONDict: JSONDict, defaultValue: false)
        self.isActiveInStore = ParseValidator.getBoolForKey(key: "active_in_store", JSONDict: JSONDict, defaultValue: false)

        
        return self
    }
    
}
