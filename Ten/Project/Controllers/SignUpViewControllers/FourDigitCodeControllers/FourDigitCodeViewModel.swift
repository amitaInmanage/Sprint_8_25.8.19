//
//  FourDigitCodeViewModel.swift
//  Ten
//
//  Created by aviv-inmanage on 26/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class FourDigitCodeViewModel: BaseViewModel {
    
    var code = [""]
    var strPinCode = ""
    var txtArr = [String]()
    var isCheckValidation = false
    private var maxCountDigits = 4
    
    func buildJsonAndSendEditUserInformation(vc: UIViewController?) {
        
        let encryptedPinCode = StringManager.sharedInstance.encryptedStringForString(str: strPinCode)
        let dict = [TenParamsNames.pinCode: encryptedPinCode]
        
        ApplicationManager.sharedInstance.userAccountManager.callEditUserInformation(dictParams: dict, andRequestFinishedDelegate: vc as! RequestFinishedProtocol)
    }
    
    func buildJsonAndSendVerifyPinCode(vc: UIViewController?) {
        
        let encryptedPinCode = StringManager.sharedInstance.encryptedStringForString(str: strPinCode)
        let dict = [TenParamsNames.pinCode: encryptedPinCode]
        
        ApplicationManager.sharedInstance.userAccountManager.callverifyPinCode(dictParams: dict, andRequestFinishedDelegate: vc as! RequestFinishedProtocol)
    }
    
}
