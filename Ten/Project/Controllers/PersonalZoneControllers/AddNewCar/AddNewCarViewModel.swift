//
//  AddNewCarViewModel.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class AddNewCarViewModel: BaseViewModel {
    
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var cardId = 0
    var fieldsArr = [String: Any]()
    var screenName = ""
    var isTableVisible = false

    func buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: String) {
        
        let dict = [TenParamsNames.cardId : self.cardId]
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateNewFuelingDeviceProcessData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
}
