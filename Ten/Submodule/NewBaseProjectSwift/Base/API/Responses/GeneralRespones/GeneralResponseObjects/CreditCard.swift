//
//  CreditCard.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class CreditCard: BaseInnerResponse {
    
    var strTitle: String!
    var strMask:  String!
    var strCompany: String!
    var strExpiration: String!
    var strImageUrl: String!
    var strLastDigits: String!
    var numPaymentType: Int!
    var isMain = false
    var isSelected = false

    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strTitle = ParseValidator.getStringForKey(key: "title", JSONDict: JSONDict, defaultValue: "")
        self.strMask = ParseValidator.getStringForKey(key: "card_mask", JSONDict: JSONDict, defaultValue: "")
        self.strCompany = ParseValidator.getStringForKey(key: "creditCompany", JSONDict: JSONDict, defaultValue: "")
        self.strExpiration = ParseValidator.getStringForKey(key: "cardExpiration", JSONDict: JSONDict, defaultValue: "")
        self.numPaymentType = ParseValidator.getIntForKey(key: "payment_type", JSONDict: JSONDict, defaultValue: 0)
        self.isMain = ParseValidator.getBoolForKey(key: "main", JSONDict: JSONDict, defaultValue: false)
        self.isSelected = false
        self.strLastDigits = ParseValidator.getStringForKey(key: "last_digits", JSONDict: JSONDict, defaultValue: "")

        return self
    }
    
}
