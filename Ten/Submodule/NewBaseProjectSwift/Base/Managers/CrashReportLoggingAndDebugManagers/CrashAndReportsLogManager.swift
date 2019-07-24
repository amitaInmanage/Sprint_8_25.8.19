//
//  CrashAndReportsLogManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit


class CrashAndReportsLogManager: BaseManager {
    
    var didAttemptToPostErrorReport = false
    
    override init(){
        // init all properties
        super.init()
        self.handleException()
    }
    
    static var sharedInstance = CrashAndReportsLogManager()
    
    
    func handleException() {
        
        NSSetUncaughtExceptionHandler { (exception) in
            
            let userId = ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn ? "\(ApplicationManager.sharedInstance.userAccountManager.user.numID)": "no id"
            
            let str = "SYSTEM VERSION: \(UIDevice.current.systemVersion)\n APP VERSION: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"))\n APP BUILD: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion"))\n USER ID: \(userId)\n TIME: \(ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: ApplicationManager.sharedInstance.timeManager.getCurrentServerDate()))\n NAME: \(exception.name)\n REASON: \(exception.reason)\n STACKTRACE: \(exception.callStackSymbols.description.components(separatedBy: ""))"
            
            ApplicationManager.sharedInstance.keychainManager.saveStringToKeychain(str, forKey: "exceptionStack")
            
            let lastHttpRequest = ApplicationManager.sharedInstance.debugAndDevEnviromentManager.getLastHttpRequest()
            
            if !lastHttpRequest.isEmpty {
                ApplicationManager.sharedInstance.keychainManager.saveStringToKeychain(lastHttpRequest, forKey: "HTTPRequestLog")
            }
            
        }
    }
    
    
    func reportCrashLog() {
        
        if self.didAttemptToPostErrorReport {
            return
        }
        
        if let errorStack = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: "exceptionStack") {
            
            var HTTPRequestLog: String {
                
                if let httpRequest = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: "httpRequest") {
                    return httpRequest
                } else {
                    return "httpRequest not found"
                }
            }
            
            self.postErrorReport(errorStack: errorStack, andHTTPRequest: HTTPRequestLog)
            
        }
    }
    
    func postErrorReport(errorStack: String, andHTTPRequest request: String) {
        
        self.didAttemptToPostErrorReport = true
        
        var infoDict = [String:Any]()
        infoDict.updateValue("\(request)\n\n\(errorStack)", forKey: "content")
        
        let errorReportRequest = ErrorReportRequest().initWithDictParams(dictParams: infoDict, andRequestFinishDelegate: nil)
        
        errorReportRequest.showHUD = false
        errorReportRequest.showResponseMessages = false
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: errorReportRequest, view: nil)
        
        // Clear exceptionStrack and HTTPRequestLog
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: "exceptionStack")
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: "httpRequest")
        
    }
    
    func logLastHTTPRequest(request: NSMutableURLRequest) {
        
        var urlAndParams = ""
        let urlDest = "\(request.url?.description)"
        let bodyDesc = String(data: request.httpBody!, encoding: .utf8)
        
        if let aBodyDesc = bodyDesc {
            
            urlAndParams = "urlAndParams:\nURL: \(urlDest)\nParams: \(aBodyDesc)"
            
            ApplicationManager.sharedInstance.keychainManager.saveStringToKeychain(urlAndParams, forKey: "HTTPRequestLog")
            
        }
        
    }
    
    
    override func reset() {
        CrashAndReportsLogManager.sharedInstance = CrashAndReportsLogManager()
    }
    
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
    }
    
    
}

