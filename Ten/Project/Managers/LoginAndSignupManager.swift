//
//  LoginAndSignupManager.swift
//  Ten
//
//  Created by inmanage on 18/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class LoginAndSignupManager: BaseManager {

    static var sharedInstance = LoginAndSignupManager()

    func callGetSmsToken(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetSmsTokenRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        request.showResponseMessages = false
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callVerifySmsToken(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = VerifySmsTokenRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        request.showResponseMessages = false
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callUpdateRegistrationData(dictParams: [String:Any]?, screenName: Any?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
       
        let request = UpdateRegistrationDataRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }

    // MARK: RequestFinishedProtocol
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
    
}
