//
//  item.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TransactionHistoryItem: BaseInnerResponse {
 
    var strId = ""
    var intType = 0
    var strIcon = ""
    var strDate = ""
    var strTime = ""
    var amount = AmountHistory()
    var store = StoreHistoey()
    var accumulationAmount = AccumulationAmount()
    var usageAmount = UsageAmount()
    var isExtended = false
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)

        self.strId = ParseValidator.getStringForKey(key: "id", JSONDict: JSONDict, defaultValue: "")
        self.intType = ParseValidator.getIntForKey(key: "type", JSONDict: JSONDict, defaultValue: 0)
        self.strIcon = ParseValidator.getStringForKey(key: "icon", JSONDict: JSONDict, defaultValue: "")
        self.strDate = ParseValidator.getStringForKey(key: "date", JSONDict: JSONDict, defaultValue: "")
        self.strTime = ParseValidator.getStringForKey(key: "time", JSONDict: JSONDict, defaultValue: "")

        let tempAmount = ParseValidator.getDictionaryForKey(key: "amount", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.amount = AmountHistory().buildFromJSONDict(JSONDict: tempAmount) as! AmountHistory
        
        let tempStore = ParseValidator.getDictionaryForKey(key: "store", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.store = StoreHistoey().buildFromJSONDict(JSONDict: tempStore) as! StoreHistoey
        
        let tempAccumulationAmount = ParseValidator.getDictionaryForKey(key: "accumulation_amount", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.accumulationAmount = AccumulationAmount().buildFromJSONDict(JSONDict: tempAccumulationAmount) as! AccumulationAmount
        
        let tempUsageAmount = ParseValidator.getDictionaryForKey(key: "usage_amount", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.usageAmount = UsageAmount().buildFromJSONDict(JSONDict: tempUsageAmount) as! UsageAmount
        
        return self
    }
}

