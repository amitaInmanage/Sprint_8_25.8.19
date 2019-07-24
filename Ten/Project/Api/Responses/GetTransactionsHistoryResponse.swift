//
//  GetTransactionsHistoryResponse.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class GetTransactionsHistoryResponse: BaseInnerResponse {
    
    var intTabId = 0
    var intPage = 0
    var hasNextPage = false
    var transactionHistoryList = [TransactionHistoryItem]()
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intTabId = ParseValidator.getIntForKey(key: "tab_id", JSONDict: JSONDict, defaultValue: 0)
        self.intPage = ParseValidator.getIntForKey(key: "page", JSONDict: JSONDict, defaultValue: 0)
        self.hasNextPage = ParseValidator.getBoolForKey(key: "has_next_page", JSONDict: JSONDict, defaultValue: false)
        
        let itemArr = ParseValidator.getArrayForKey(key: "itemsArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.transactionHistoryList = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: itemArr, innerResponse: TransactionHistoryItem(), shouldReverseOrder: false) as! [TransactionHistoryItem]
        
        return self
    }
}
