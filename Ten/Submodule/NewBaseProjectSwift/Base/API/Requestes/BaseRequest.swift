//
//  BaseRequest.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 06/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MBProgressHUD


class BaseRequest : NSObject {
    
    var requestName: String {
        get {
            return self.requestName
        }
    }
    var dictParams = [String:Any]()
    var requestFinishedDelegate:RequestFinishedProtocol?
    var showHUD: Bool
    var HUDMode: MBProgressHUDMode?
    var strHUDLabelText: String?
    var showResponseMessages: Bool
    var showResponseMessageForSuccess: Bool
    var showResponseMessageForFailure: Bool
    var maxAllowedRequestAttempts: Int
    var allowSendingAboveMaxAllowedRequestAttempts: Bool
    var skipUpdatingRequestFinishedDelegates: Bool
    
    typealias completion = (()->())?
    
    var responseMessageForSuccessButtonAction: completion
    var responseMessageForFailureButtonAction: completion
    var responseMessageCloseButtonAction: completion
    var strResponseMessageButtonTitle:String?
    
    var alertDisplayInViewTypeForSuccessMessage:AlertDisplayInViewType
    var alertDisplayInViewTypeForFailureMessage:AlertDisplayInViewType
    
    var requestAttemptsCounter:Int = 0
    var shouldSendRequestAgain = true
    
    
    override init() {
        
        // Default values
        self.showHUD = true;
        self.showResponseMessages = true
        self.showResponseMessageForSuccess = true
        self.showResponseMessageForFailure = true
        self.alertDisplayInViewTypeForSuccessMessage = .alertCustomView
        self.alertDisplayInViewTypeForFailureMessage = .alertCustomView
        
        self.HUDMode = .indeterminate;
        
        self.maxAllowedRequestAttempts = (ApplicationManager.sharedInstance.appGD.methodAttempts > 0) ? ApplicationManager.sharedInstance.appGD.methodAttempts : 3
        
        self.allowSendingAboveMaxAllowedRequestAttempts = false;
        self.skipUpdatingRequestFinishedDelegates = false;
        
        self.responseMessageForSuccessButtonAction = nil;
        self.responseMessageForFailureButtonAction = nil;
        self.responseMessageCloseButtonAction = nil;
        
    }
    
    
    func initWithDictParams(dictParams: [String: Any]?, andRequestFinishDelegate wantedRequestFinishDelegate: RequestFinishedProtocol?)->BaseRequest {
        
        if let params = dictParams {
            self.dictParams = params
        }
        
        self.requestFinishedDelegate = wantedRequestFinishDelegate
        requestAttemptsCounter = 0;
        
        
        // Default values
        self.showHUD = true;
        self.showResponseMessages = true;
        self.showResponseMessageForSuccess = true
        self.showResponseMessageForFailure = true
        self.alertDisplayInViewTypeForSuccessMessage = .alertCustomView
        self.alertDisplayInViewTypeForFailureMessage = .alertCustomView
        
        self.HUDMode = .indeterminate;
        
        self.maxAllowedRequestAttempts = (ApplicationManager.sharedInstance.appGD.methodAttempts > 0) ? ApplicationManager.sharedInstance.appGD.methodAttempts : 3
        
        self.allowSendingAboveMaxAllowedRequestAttempts = false;
        self.skipUpdatingRequestFinishedDelegates = false;
        
        self.responseMessageForSuccessButtonAction = nil;
        self.responseMessageForFailureButtonAction = nil;
        self.responseMessageCloseButtonAction = nil;
        resetRequestAttemptsCounter()
        
        return self
    }
    
    
    
    public func createOuterResponseFromJSONDict(JSONDict:Dictionary<String,Any>)->BaseOuterResponse?{
        return nil
        
    }
    
    
    public func shouldAttemptSendingRequestAgain()->Bool{
        
        if (requestAttemptsCounter < self.maxAllowedRequestAttempts) {
            return true;
        }
        else {
            return false;
        }
        
    }
    
    public func increaseRequestAttemptsCounter() {
        requestAttemptsCounter += 1
    }
    
    
    public func resetRequestAttemptsCounter() {
        requestAttemptsCounter = 0
    }
    
  
}
