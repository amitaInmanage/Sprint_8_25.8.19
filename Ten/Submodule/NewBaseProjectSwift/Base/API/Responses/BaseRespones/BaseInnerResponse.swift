//
//  BaseInnerResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 06/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseInnerResponse: NSObject {
  
    var numID  = 0
    var numSortOrder = 0
    var showDeveloperOptions = false
    
    // init method requried - to infer the inherited classes in run time.
    required override init() {
        super.init()
    }
 
    @objc @discardableResult dynamic public func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        
        self.numID = ParseValidator.getIntForKey(key: "id", JSONDict: JSONDict, defaultValue: 0)
        self.numSortOrder = ParseValidator.getIntForKey(key: "order_num", JSONDict: JSONDict, defaultValue: self.numID)
        
        return self
        
    }
    
   
    func compare<T:BaseInnerResponse>(other: T) -> Bool {
        if self.numSortOrder == other.numSortOrder {
            return self.numID < other.numID
        }
        
        return self.numSortOrder < other.numSortOrder
        
    }
    
    

    
    

    
}
