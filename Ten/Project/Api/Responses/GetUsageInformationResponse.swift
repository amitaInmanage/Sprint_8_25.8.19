//
//  GetUsageInformationResponse.swift
//  Ten
//
//  Created by Amit on 18/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class GetUsageInformationResponse: BaseInnerResponse {
    
    var avarages = Avarage()
    var sumByMountItem = SumByMountItem()
    var fuelingDeviceId = ""
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let tempUser = ParseValidator.getDictionaryForKey(key: "user", JSONDict: JSONDict, defaultValue: [String:Any]())
        ApplicationManager.sharedInstance.userAccountManager.user.buildFromJSONDict(JSONDict: tempUser) as! TenUser
        
        let tempAvarages = ParseValidator.getDictionaryForKey(key: "averages", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.avarages = Avarage().buildFromJSONDict(JSONDict: tempAvarages) as! Avarage
      
        self.fuelingDeviceId = ParseValidator.getStringForKey(key: "fueling_device_id", JSONDict: JSONDict, defaultValue: "")
    
        let tempSumByMountItem = ParseValidator.getDictionaryForKey(key: "sum_by_monthArr", JSONDict: JSONDict, defaultValue: [String : Any]())
        self.sumByMountItem = SumByMountItem().buildFromJSONDict(JSONDict: tempSumByMountItem) as! SumByMountItem
        
        return self
    }
}
