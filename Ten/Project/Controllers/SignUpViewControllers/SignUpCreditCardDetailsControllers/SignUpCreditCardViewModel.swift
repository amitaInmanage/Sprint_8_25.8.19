//
//  SignUpCreditCardViewModel.swift
//  Ten
//
//  Created by inmanage on 30/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpCreditCardViewModel: BaseViewModel {
    
    var screenName = ""
    var strWebViewUrl = ""
    var fieldsArr = [String: Any]()
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String, vc: UIViewController? = nil) {
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: nil)
    }
    
    
//    func buildJsonAndSendUpdateNewFuelingDeviceProcessData(screens: [ScreenName]?) {
//        
//        ApplicationManager.sharedInstance.userAccountManager.callUpdateNewFuelingDeviceProcessData(dictParams: fieldsArr, screenName: screens, andRequestFinishedDelegate: nil)
//    }
    
}
