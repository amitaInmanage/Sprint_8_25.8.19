//
//  CustomerProgram.swift
//  Ten
//
//  Created by Amit on 13/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CustomerProgramUser: BaseInnerResponse {
    
    var intCurrentProgrramId = 0
    var changesMode = 0
    var changesRemaining = 0
    var availableProgram: [Int] = []
    
    override func buildFromJSONDict(JSONDict:  [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.intCurrentProgrramId = ParseValidator.getIntForKey(key: "current_program_id", JSONDict: JSONDict, defaultValue: 0)
        self.changesMode = ParseValidator.getIntForKey(key: "changes_made", JSONDict: JSONDict, defaultValue: 0)
        self.changesRemaining = ParseValidator.getIntForKey(key: "changes_remaining", JSONDict: JSONDict, defaultValue: 0)
        self.availableProgram = ParseValidator.getArrayForKey(key: "available_programsArr", JSONDict: JSONDict, defaultValue: [Int]()) as! [Int]
        
      //  guard let availablePrograms = JSONDict?["available_programsArr"] as? Array<String> else { return self }
        return self
    }
}
