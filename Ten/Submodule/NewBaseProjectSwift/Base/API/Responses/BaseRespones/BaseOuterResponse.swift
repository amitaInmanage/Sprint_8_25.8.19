//
//  BaseOuterResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 06/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

enum ResponseStatus: Int {
    case statusFailure = 0, statusSuccess
}

class BaseOuterResponse: NSObject {
    
    var responseStatus: ResponseStatus!
    var strSuccessMessage: String?
    var strFailureMessage: String?
    var dictData: [String: Any]?
    var arrMessages: [PopupMessage]!

    var errorResponse : ErrorResponse!
    var innerResponse : BaseInnerResponse!
    
    static func initFromJSONDict(JSONDict: [String: Any], withInnerResponse innerResponse: BaseInnerResponse) -> (BaseOuterResponse) {
        
        let baseOuterResponse = BaseOuterResponse()
        
        let responseStatus = ParseValidator.getIntForKey(key: "status", JSONDict: JSONDict, defaultValue: 0)
        
        baseOuterResponse.responseStatus = ResponseStatus(rawValue: responseStatus)
        
        // Success case
        if baseOuterResponse.responseStatus == .statusSuccess {
            
            baseOuterResponse.strSuccessMessage = ParseValidator.getStringForKey(key: "message", JSONDict: JSONDict, defaultValue: "")
            baseOuterResponse.dictData = ParseValidator.getDictionaryForKey(key: "data", JSONDict: JSONDict, defaultValue: [String: Any]())
            
            if let aDictData = baseOuterResponse.dictData {
                baseOuterResponse.innerResponse = innerResponse.buildFromJSONDict(JSONDict: aDictData)
            }
            
            let arrMessages = ParseValidator.getArrayForKey(key: "popupsArr", JSONDict: JSONDict, defaultValue: [PopupMessage]())
            baseOuterResponse.arrMessages = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: arrMessages, innerResponse: PopupMessage(), shouldReverseOrder: false) as! [PopupMessage]

            
        } else {
            
            //Failure case
            
            let dictError = ParseValidator.getDictionaryForKey(key: "err", JSONDict: JSONDict, defaultValue: [String: Any]())
            
            let errorResponse = ErrorResponse()
            
            baseOuterResponse.errorResponse = errorResponse.buildFromJSONDict(JSONDict: dictError) as! ErrorResponse
            
            if let content = baseOuterResponse.errorResponse.strContent {
                baseOuterResponse.strFailureMessage = content
            }
            
        }
        
        return baseOuterResponse
        
    }
    
    
    
    
    
}
