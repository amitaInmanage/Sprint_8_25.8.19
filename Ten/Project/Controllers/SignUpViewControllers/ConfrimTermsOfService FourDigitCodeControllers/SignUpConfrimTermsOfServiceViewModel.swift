//
//  ConfrimTermsOfViewModel.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpConfrimTermsOfServiceViewModel: BaseViewModel {
    
    var strUrl = ""
    var strHTML = ""
    var strTitle = ""
    var screenName = ""
    var costumerType = ""
    var fieldsArr = [String: Any]()
    
    
    func buildJsonAndSendUpdateRegistrationData(strScreenName: String, vc: UIViewController? = nil) {
        
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: vc as? RequestFinishedProtocol)
    }
}
