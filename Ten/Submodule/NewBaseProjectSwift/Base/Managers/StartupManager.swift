//
//  StartupManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

let kNumberOfResponses = 6

class StartupManager: BaseProcessManager, ProcessFinishedProtocol {
    
    static var sharedInstance = StartupManager()
    
    var itemSlide = ""
    
    var responseCounter = 0
    
    override func startProcess(processType: ProcessType, processObj:BaseProcessObj?, processFinishedDelegate: ProcessFinishedProtocol?, processCompletion:@escaping ProcessCompletion ) {
        
        super.startProcess(processType: processType, processObj: processObj, processFinishedDelegate: processFinishedDelegate, processCompletion: processCompletion)
        
        responseCounter = 0
        
        self.callGetHostUrlWithDictParams(dictParams: nil, andRequestFinishedDelegate: self)
    }
    
    
    //MARK : Requests
    
    func callGetOnBoarding(requestFinishedDelegate: RequestFinishedProtocol?) {
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetOnBoardingRequest().initWithDictParams(dictParams: nil, andRequestFinishDelegate: requestFinishedDelegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callGetHostUrlWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = GetHostUrlRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callClearSessionWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = ClearSessionRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callApplicationTokenWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = ApplicationTokenRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callSetSettingsWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = SetSettingsRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        //        request.showResponseMessageForSuccess  = false
        //
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callValidateVersionWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = ValidateVersionRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callGeneralDeclarationWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = GeneralDeclarationRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    
    func callGetStartUpMessageWithDictParams(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        let request = GetStartUpMessageRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: requestFinishedDelegate)
        
        request.showHUD = false
        request.allowSendingAboveMaxAllowedRequestAttempts = true
        request.showResponseMessages = true
        request.alertDisplayInViewTypeForFailureMessage = .alertView
        request.alertDisplayInViewTypeForSuccessMessage = .alertView
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    
    func startLoginProcess() {
        
        ApplicationManager.sharedInstance.userAccountManager.loggedInStatus = .notLoggedIn
        
        let userAccountProcessObj = UserAccountProcessObj()
        userAccountProcessObj.isSilentRequest = true
        
        ApplicationManager.sharedInstance.userAccountManager.startProcess(processType: .login, processObj: userAccountProcessObj, processFinishedDelegate: nil) { (processManager, processFinishedStatus) in
            
            self.handleStartUpMessages()
            
            if self.isShowOnBoarding() {
                self.callGetOnBoarding(requestFinishedDelegate: self)
            } else{
                if ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn {
                    //TODO: send to Main Screen
                    print("Main Screen")
                }else {
                    if let login = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: SignUpWithPhoneNumberViewController.className) as? SignUpWithPhoneNumberViewController {
                        ApplicationManager.sharedInstance.navigationController.pushTenViewController(login, animated: true)
                    }
                }
            }
        }
    }
    
    
    func handleStartUpMessages() {
        
        self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
    }
    
    
    func isIncreaseResponseCounterRequest(request: BaseRequest) -> (Bool) {
        
        let requestName = request.requestName
        
        if  requestName == ServerStartupRequests.getHostUrl          ||
            requestName == ServerStartupRequests.clearSeesion        ||
            requestName == ServerStartupRequests.getApplicationToken  ||
            requestName == ServerStartupRequests.setSettings         ||
            requestName == ServerStartupRequests.validateVersion     ||
            requestName == ServerStartupRequests.generalDeclaration  ||
            requestName == ServerStartupRequests.getStartupMessage   {
            
            return true
            
        }
        
        return false
    }
    
    
    //MARK: RequestFinishedProtocol
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == ServerStartupRequests.getHostUrl {
            
            if !ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment {
                ApplicationManager.sharedInstance.keychainManager.saveStringToKeychain((innerResponse as! GetHostUrlResponse).strHostUrl, forKey: Constans.hostLiveURLKey)
            }
            
            self.callClearSessionWithDictParams(dictParams: nil, andRequestFinishedDelegate: self)
            
        } else if request.requestName == ServerStartupRequests.clearSeesion {
            
            let dictParams = ApplicationTokenRequest.createInitialDictParams()
            
            self.callApplicationTokenWithDictParams(dictParams: dictParams, andRequestFinishedDelegate: self)
            
        } else if request.requestName == ServerStartupRequests.getApplicationToken {
            
            ApplicationManager.sharedInstance.requestManager.strApplicationToken = (innerResponse as! ApplicationTokenResponse).strApplicationToken
            
            ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.registerForRemoteNotifications()
            
            let dictParams = SetSettingsRequest.createInitialDictParams()
            
            self.callSetSettingsWithDictParams(dictParams: dictParams, andRequestFinishedDelegate: self)
            
        } else if request.requestName == ServerStartupRequests.setSettings {
            
            ApplicationManager.sharedInstance.crashAndReportsLogManager.reportCrashLog()
            
            self.callValidateVersionWithDictParams(dictParams: nil, andRequestFinishedDelegate: self)
            
        } else if request.requestName == ServerStartupRequests.validateVersion {
            
            let strRemindMeLater = Translation(Translations.AlertButtonsKeys.remindMeLater, Translations.AlertButtonsKeys.remindMeLaterDefault)
            
            let strUpdateMe = Translation(Translations.AlertButtonsKeys.updateMe, Translations.AlertButtonsKeys.updateMeDefault)
            
            //            let strExit = Translation(Translations.AlertButtonsKeys.exit, Translations.AlertButtonsKeys.exitDefault)
            
            switch (innerResponse as! ValidateVersionResponse).versionStatus {
                
            case .valid:
                self.callGeneralDeclarationWithDictParams(dictParams: nil, andRequestFinishedDelegate: self)
                
            case .deprecated:
                
                let arrRIButtonsItems : [RIButtonItem] = [RIButtonItem.item(withLabel: strRemindMeLater, style: .default, action: {
                    self.callGeneralDeclarationWithDictParams(dictParams: nil, andRequestFinishedDelegate: self)
                }) as! RIButtonItem, RIButtonItem.item(withLabel: strUpdateMe, style: .default, action: {
                    
                    if let url = URL(string: (innerResponse as! ValidateVersionResponse).strAppStoreUrl) {
                        
                        if UIApplication.shared.canOpenURL(url) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                // Fallback on earlier versions
                            }
                            
                        }
                    }
                    
                }) as! RIButtonItem]
                
                ApplicationManager.sharedInstance.alertManager .showAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertView, andTitle: (innerResponse as! ValidateVersionResponse).strMessage, andMessage: "", andArrRIButtonItems: arrRIButtonsItems)
                
                
            case .notSupported:
                
                let arrRIButtonsItems : [RIButtonItem] = [RIButtonItem.item(withLabel: strUpdateMe, style: .default, action: {
                    
                    if let url = URL(string: (innerResponse as! ValidateVersionResponse).strAppStoreUrl) {
                        
                        if UIApplication.shared.canOpenURL(url) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    }
                    
                }) as! RIButtonItem]
                //                ApplicationManager.sharedInstance.appGeneralManager.arrRIButtonsItems = arrRIButtonsItems
                ApplicationManager.sharedInstance.alertManager .showAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertView, andTitle: (innerResponse as! ValidateVersionResponse).strMessage, andMessage: "", andArrRIButtonItems: arrRIButtonsItems)
                if let res = innerResponse as? ValidateVersionResponse {
                    //                    ApplicationManager.sharedInstance.appGeneralManager.startupMessaage = res.strMessage
                }
            }
            
        } else if request.requestName == ServerStartupRequests.generalDeclaration {
            ApplicationManager.sharedInstance.appGD = innerResponse as! AppGeneralDeclarationResponse
            
            
        }
            
        else if request.requestName == TenRequestNames.getOnBoarding {
            onBoardingResponse(innerResponse: innerResponse)
        }
        
        if self.isIncreaseResponseCounterRequest(request: request) {
            
            responseCounter += 1
            
            if responseCounter == kNumberOfResponses {
                
                self.startLoginProcess()
            }
            
        }
        
        
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
        if request.requestName == ServerStartupRequests.setSettings {
            ApplicationManager.sharedInstance.crashAndReportsLogManager.reportCrashLog()
        }
        
    }
    
    
    
    fileprivate func onBoardingResponse(innerResponse: BaseInnerResponse) {
        
        
        if let onBoarding = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: OnBoardingViewController.className) as? OnBoardingViewController {
            onBoarding.slidItem = (innerResponse as! GetOnBoardingResponse).slidesArr
            ApplicationManager.sharedInstance.navigationController.pushViewController(onBoarding, animated: true)
        }
        
        //        let onBoarding = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: OnBoardingViewController.className)
        //            r
        //            ApplicationManager.sharedInstance.navigationController.pushViewController(onBoarding, animated: true)
        //
    }
    
    //MARK: ProcessFinishedProtocol
    
    func processFinished(processManager: BaseProcessManager, processFinishedStatus: ProcessFinishedStatus, processCompletion: (BaseProcessManager, ProcessFinishedStatus) -> ()) {
        
    }
    
    override func reset() {
        StartupManager.sharedInstance = StartupManager()
    }
    
    fileprivate func isShowOnBoarding() -> Bool {
        let val = ApplicationManager.sharedInstance.appGD.isShowBoarding && !ApplicationManager.sharedInstance.keychainManager.retrieveBoolFromKeychain(key: "isNotFirstTimeApp")
            ApplicationManager.sharedInstance.keychainManager.saveBoolToKeychain(true, forKey: "isNotFirstTimeApp")
        return val
    }
}

