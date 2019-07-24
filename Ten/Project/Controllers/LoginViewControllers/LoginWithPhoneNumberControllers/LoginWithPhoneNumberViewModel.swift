//
//  LoginWithPhineNumberViewModel.swift
//  Ten
//
//  Created by inmanage on 27/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class LoginWithPhoneNemberViewModel: BaseViewModel, BaseViewModelDataFetchProtocol {
    var strPhoneNumber = ""
    
    
    func validatePhoneNumber() -> Bool {
        return ApplicationManager.sharedInstance.inputValidationManager.isValidMobilePhoneNumber(phoneStr: self.strPhoneNumber)
    }
    
    func sendLoginRequest() {
        //Send login request
    }
    
    
    func requestSucceeded(request:BaseRequest, withOuterResponse outerResponse:BaseOuterResponse, andInnerResponse innerResponse:BaseInnerResponse) {
//        if request.requestName == .login {
//            if let login = UIStoryboard(name: "LoginWithPhoneNumberViewController", bundle: nil).instantiateViewController(withIdentifier: EnterSecretSmsCodeViewController.className) as? EnterSecretSmsCodeViewController {
//                ApplicationManager.sharedInstance.navigationController.pushTenViewController(login, animated: true)
//            }
//        }
    }
    
    func requestFailed(request:BaseRequest, withOuterResponse outerResponse:BaseOuterResponse) {
        if let baseViewModelDataFetchProtocolToController = baseViewModelDataFetchProtocolToController {
            baseViewModelDataFetchProtocolToController.requestViewFailed(request, outerResponse)
        }
    }
}
