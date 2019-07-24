//
//  RequestManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

//request
enum SendRequest: String {
    case request = "request"
    case view = "view"
}

class RequestManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }

    func getCustomHUD() -> UIImageView {
        self.imgVwCustomHud.frame = CGRect.init(x: 0, y: 0, width: 37, height: 37)
        
        self.imgVwCustomHud.animationImages = [UIImage(named: "loader_00000")!,UIImage(named: "loader_00001")!,UIImage(named: "loader_00002")!,UIImage(named: "loader_00003")!,UIImage(named: "loader_00004")!,UIImage(named: "loader_00005")!,UIImage(named: "loader_00006")!,UIImage(named: "loader_00007")!,UIImage(named: "loader_00008")!,UIImage(named: "loader_00009")!,UIImage(named: "loader_00010")!,UIImage(named: "loader_00011")!,UIImage(named: "loader_00012")!,UIImage(named: "loader_00013")!,UIImage(named: "loader_00014")!,UIImage(named: "loader_00015")!,UIImage(named: "loader_00016")!,UIImage(named: "loader_00017")!,UIImage(named: "loader_00018")!,UIImage(named: "loFader_00019")!,UIImage(named: "loader_00020")!,UIImage(named: "loader_00021")!,UIImage(named: "loader_00022")!,UIImage(named: "loader_00023")!,UIImage(named: "loader_00024")!,UIImage(named: "loader_00025")!,UIImage(named: "loader_00026")!,UIImage(named: "loader_00027")!,UIImage(named: "loader_00028")!,UIImage(named: "loader_00029")!,UIImage(named: "loader_00030")!,UIImage(named: "loader_00031")!,UIImage(named: "loader_00032")!,UIImage(named: "loader_00033")!,UIImage(named: "loader_00034")!,UIImage(named: "loader_00035")!,UIImage(named: "loader_00036")!,UIImage(named: "loader_00037")!,UIImage(named: "loader_00038")!,UIImage(named: "loader_00039")!,UIImage(named: "loader_00040")!,UIImage(named: "loader_00041")!]
        
        self.imgVwCustomHud.animationDuration = 0.5
        self.imgVwCustomHud.startAnimating()
        
        self.imgVwCustomHud.translatesAutoresizingMaskIntoConstraints = false
        
        self.imgVwCustomHud.addConstraint(NSLayoutConstraint(item: self.imgVwCustomHud, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
        self.imgVwCustomHud.addConstraint(NSLayoutConstraint(item: self.imgVwCustomHud, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
        
        return self.imgVwCustomHud
        
    }
    
    static var sharedInstance = RequestManager()
    
    var strApplicationToken = ""
    var arrRequestFinishedDelegates = [RequestFinishedProtocol]()
    
    let requestTimeoutIntervalDefault = 40
    let requestAttemptDelayDefault = 0.1
    var imgVwCustomHud = UIImageView()
    
    func sendRequest(request:BaseRequest, view:UIView? = nil) {
        
        // Tests that max session time (usually 25 minutes) hasn't passed since last contact with the server, and restarts if passed. This is needed to prevent a session dropping on server side but not on app side situation - app will receive spurious status 0 from the server (i.e. "user not logged in" even though user is logged in on app side).
        if ApplicationManager.sharedInstance.timeManager.registerCallTimeAndCheckIfMaxTimePassed() {
            
            ApplicationManager.sharedInstance.restartAppWithBlockToExecute {}
            return;
        }
        
        // The request keeps track of how many times it was sent
        request.increaseRequestAttemptsCounter()
        
        if request.showHUD {
            
            MBProgressHUD.hide(for: view ?? UIApplication.shared.keyWindow!, animated: true)
            
            if UIApplication.shared.keyWindow != nil {
                
                var hud = MBProgressHUD()
                
                DispatchQueue.main.async {
                    
                    hud = MBProgressHUD.showAdded(to: view ?? UIApplication.shared.keyWindow!, animated: true)

//                    hud.mode = .customView
//                    hud.bezelView.color = UIColor.clear
//                    hud.bezelView.style = .solidColor
//                    hud.customView = self.getCustomHUD()
//                    
                }
                
                if request.strHUDLabelText != nil && !request.strHUDLabelText!.isEmpty {
                    hud.label.text = request.strHUDLabelText!
                    
                }
            }
        }
        
        // Toasts with a request name are only displayed for debug users (configured in the salat via checkbox)
        
        if ApplicationManager.sharedInstance.userAccountManager.user.showCallToasts {
            ApplicationManager.sharedInstance.debugAndDevEnviromentManager.showRequestDebugHUDWithRequestName(requestName: request.requestName)
        }
        
        let manager = AFHTTPSessionManager()
        
        let acceptableContentTypes: Set = ["text/html"]
        
        manager.responseSerializer.acceptableContentTypes = acceptableContentTypes
        
        if request.requestName == ServerStartupRequests.getApplicationToken {
            manager.requestSerializer.setValue(Constans.applicationSecurityToken, forHTTPHeaderField: "TOKEN")
        }
        
        if !ApplicationManager.sharedInstance.requestManager.strApplicationToken.isEmpty {
            request.dictParams.updateValue(ApplicationManager.sharedInstance.requestManager.strApplicationToken, forKey: "applicationToken")
        }

        var requestTimeoutInterval : TimeInterval
        
        if ApplicationManager.sharedInstance.appGD.methodTimeout > 0 {
            requestTimeoutInterval = TimeInterval(ApplicationManager.sharedInstance.appGD.methodTimeout)
        } else {
            requestTimeoutInterval = TimeInterval(requestTimeoutIntervalDefault)
        }
        
        manager.requestSerializer.timeoutInterval = requestTimeoutInterval
        
//        let strRequestURL = Constans.baseLiveURL
        
        let strRequestURL = ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment ? ApplicationManager.sharedInstance.debugAndDevEnviromentManager.strEnviromentUrl : Constans.baseLiveURL
        
        let requestSentDate = NSDate()
        
        LogMsg("FULLPATH: \(strRequestURL)/\(Constans.defaultPath)/\(request.requestName)")
        LogMsg("requestName \(request.requestName):\r\nparamaters: \(request.dictParams)")
        
        manager.post("\(strRequestURL)/\(Constans.defaultPath)/\(request.requestName)", parameters: request.dictParams, progress: nil, success: { (task, responseObject) in
            
            let responseDateBeforeParsing = NSDate()
            
            if let aResponseObject = responseObject {
                LogMsg("requestName \(request.requestName):\r\nresponseObject: \(aResponseObject)")
            }
            
            // Prevents a silent request from hiding a HUD shown by a parallel non silent request
            if request.showHUD {
                MBProgressHUD.hide(for: view ?? UIApplication.shared.keyWindow!, animated: true)
            }
            //case the respnse returned [String:Any]
            if let responseObject = responseObject as? [String:Any] {
                let outerResponse = request.createOuterResponseFromJSONDict(JSONDict: responseObject)
                
                ApplicationManager.sharedInstance.debugAndDevEnviromentManager.createAndAddRequestLogFromRequestName(strRequestName: request.requestName, andRequestSentDate: requestSentDate as Date, andUrlRequest: (task.originalRequest)!, andResponseDateBeforeParsing: responseDateBeforeParsing as Date, andResponse: responseObject, andResponseDateAfterParsing: Date())
                
                // Success
                if outerResponse?.responseStatus == .statusSuccess {
                    self.handleSuccessForRequest(request: request, withOuterResponse: outerResponse!)
                    
                } else if outerResponse?.responseStatus == .statusFailure {
                    self.handleFailureForRequest(request: request, withOuterResponse: outerResponse!, andIsNoInternetResponse: false)
                }
            } else {
                // case the response return raw data
                if let  aResponseObject = responseObject as? Data {
                    let data = try? JSONSerialization.jsonObject(with: aResponseObject, options: []) as? [String:Any]
                    if let data = data {
                        if let outerResponse = request.createOuterResponseFromJSONDict(JSONDict: data ?? [:]) {
                            if outerResponse.responseStatus == .statusSuccess {
                                self.handleSuccessForRequest(request: request, withOuterResponse: outerResponse)
                            } else if outerResponse.responseStatus == .statusFailure {
                                self.handleFailureForRequest(request: request, withOuterResponse: outerResponse, andIsNoInternetResponse: false)
                            }
                        }
                    }
                }
            }
      
            
        }) { (task, error) in
            
            ApplicationManager.sharedInstance.debugAndDevEnviromentManager.createAndAddRequestLogFromRequestName(strRequestName: request.requestName, andRequestSentDate: requestSentDate as Date, andUrlRequest: (task?.originalRequest)!, andResponseDateBeforeParsing: Date(), andResponse: error, andResponseDateAfterParsing: Date())
            
            LogMsg("requestName \(request.requestName):\r\n failure: \(error)")
            
            if request.shouldAttemptSendingRequestAgain() && request.shouldSendRequestAgain {
                
                self.perform(#selector(self.sendReqSelector(params:)), with: [SendRequest.request.rawValue:request,SendRequest.view.rawValue:view], afterDelay: 0.1)

                
            } else {
                
                // Prevents a silent request from hiding a HUD shown by a parallel non silent request
                if request.showHUD {
                    MBProgressHUD.hide(for: view ?? UIApplication.shared.keyWindow!, animated: true)
                }
                
                let JSONDict = self.createJSONDictForNoInternetSituation()
                
                let outerResponse = request.createOuterResponseFromJSONDict(JSONDict: JSONDict)!
                
                if request.showResponseMessages && request.showResponseMessageForFailure {
                    
                    ApplicationManager.sharedInstance.alertManager.showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertView, andTitle: outerResponse.errorResponse.strContent!, andMessage: nil, andAction: {
                        
                        // Usually set to yes only for startup calls - can theoretically cause an endless loop of requesting
                        if request.allowSendingAboveMaxAllowedRequestAttempts {
                            
                            request.resetRequestAttemptsCounter()
                            
                            self.perform(#selector(self.sendReqSelector(params:)), with: [SendRequest.request.rawValue:request,SendRequest.view.rawValue:view], afterDelay: 0.1)

                        }
                    })
                    
                }
                    
                    // Usually set to yes only for startup calls - can theoretically cause an endless loop of requesting
                else if request.allowSendingAboveMaxAllowedRequestAttempts {
                    
                    request.resetRequestAttemptsCounter()
                    
                    self.perform(#selector(self.sendReqSelector(params:)), with: [SendRequest.request.rawValue:request,SendRequest.view.rawValue:view], afterDelay: 0.1)

                }
                
                self.handleFailureForRequest(request: request, withOuterResponse: outerResponse, andIsNoInternetResponse: true)
                
            }
        }
    }
    
    @objc func sendReqSelector(params: [String: Any]) {
        
        guard let request = params[SendRequest.request.rawValue] as? BaseRequest  else {
            return
        }
        
        let view = params[SendRequest.view.rawValue] as? UIView
        
        self.sendRequest(request: request, view: view)
    }
    

    private func handleSuccessForRequest(request: BaseRequest, withOuterResponse outerReponse: BaseOuterResponse) {
        
        // Handle response message for success, *Note - separate handling for AlertDisplayInViewTypeCustomView
        if request.showResponseMessages && request.showResponseMessageForSuccess {
            
            if request.alertDisplayInViewTypeForSuccessMessage == .alertCustomView {
                
                if let strSuccessMessage = outerReponse.strSuccessMessage {
                    if !strSuccessMessage.isEmpty {
                        
                        ApplicationManager.sharedInstance.popupManager.handleShowPopupVCForRequestName(requestName: request.requestName, withStrMessage: strSuccessMessage, andStrFirstButtonTitle: request.strResponseMessageButtonTitle, andCloseButtonAction: request.responseMessageCloseButtonAction, andFirstButtonAction: request.responseMessageForSuccessButtonAction, andIsSuccess: false, andPopupViewControllerDelegate: nil)
                    }
                }
                
            } else {
                
                if let strSuccessMessage = outerReponse.strSuccessMessage {
                    if !strSuccessMessage.isEmpty {
                        ApplicationManager.sharedInstance.alertManager.showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertView, andTitle: strSuccessMessage, andMessage: nil, andAction: request.responseMessageForSuccessButtonAction)
                    }
                }
            }
        }
        
        ApplicationManager.sharedInstance.serverPopupMessageManager.addPopupMessages(arrPopupMessages: outerReponse.arrMessages)
        
        //popupmanager: arrmesagges
        
        // Notify request delegate that request has succeeded with response
        if let delegate = request.requestFinishedDelegate {
            delegate.requestSucceeded!(request: request, withOuterResponse: outerReponse, andInnerResponse: outerReponse.innerResponse)
        }
        
        // Notify RequestFinishedDelegates (if necessary) that request has succeeded with response
        if !request.skipUpdatingRequestFinishedDelegates {
            
            for requestFinishedDelegate in arrRequestFinishedDelegates {
                
                if requestFinishedDelegate === request.requestFinishedDelegate {
                    continue
                }
                
                
                if let aRequestSucceeded = requestFinishedDelegate.requestSucceeded {
                   aRequestSucceeded(request, outerReponse, outerReponse.innerResponse)
                }
                
//                requestFinishedDelegate.requestSucceeded!(request: request, withOuterResponse: outerReponse, andInnerResponse: outerReponse.innerResponse)
                
            }
        }
        
    }
    
    private func handleFailureForRequest(request: BaseRequest, withOuterResponse outerReponse: BaseOuterResponse, andIsNoInternetResponse isNoInternetResponse: Bool) {
        
        // Checks whether the received error can affect application flow (i.e. causes app to pop to root...)
        let errorAlertImpactType = ApplicationManager.sharedInstance.errorManager.handleErrorWithID(intErrorID: outerReponse.errorResponse.numID, strFailureMessage: outerReponse.strFailureMessage)
        
        // Handle response message for failure, *Note - no internet situation alert already handled beforehand
        if !isNoInternetResponse && request.showResponseMessages && request.showResponseMessageForFailure && errorAlertImpactType != .disableAlert  {
            
            // If the received error does affect application flow, disable any usual actions on closing alert (or else they may cause unknown results)
            if errorAlertImpactType == .disableAlertActions {
                request.responseMessageCloseButtonAction = nil
                request.responseMessageForFailureButtonAction = nil
            }
            
            // If AlertDisplayInViewTypeCustomView, server message title may be overriden for certain requests, therefor no need to check server message title length
            if request.alertDisplayInViewTypeForFailureMessage == .alertCustomView {
                
                ApplicationManager.sharedInstance.popupManager.handleShowPopupVCForRequestName(requestName: request.requestName, withStrMessage: outerReponse.strFailureMessage!, andStrFirstButtonTitle: request.strResponseMessageButtonTitle, andCloseButtonAction: request.responseMessageCloseButtonAction, andFirstButtonAction: request.responseMessageForFailureButtonAction, andIsSuccess: false, andPopupViewControllerDelegate: nil)
                
            }
                
                // *Note - separate handling for AlertDisplayInViewTypeCustomView
            else if (outerReponse.strFailureMessage?.count)! > 0 {
                
                ApplicationManager.sharedInstance.alertManager.showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: request.alertDisplayInViewTypeForFailureMessage, andTitle: outerReponse.strFailureMessage!, andMessage: nil, andAction: request.responseMessageForFailureButtonAction)
                
            }
            
        }
        
        if let delegate = request.requestFinishedDelegate {
            
            if delegate.responds(to: #selector(delegate.requestFailed(request:withOuterResponse:))) {
                delegate.requestFailed!(request: request, withOuterResponse: outerReponse)
            }
        }
        
        if !request.skipUpdatingRequestFinishedDelegates {
            
            for requestFinishedDelegate in arrRequestFinishedDelegates {
                
                // Prevents multiple callbacks if request.requestFinishedDelegate exists in array
                if requestFinishedDelegate === request.requestFinishedDelegate {
                    continue
                }
                
                
                if let aRequestFailed = requestFinishedDelegate.requestFailed {
                    aRequestFailed(request, outerReponse)
                }
                
//                requestFinishedDelegate .requestFailed!(request: request, withOuterResponse: outerReponse)
                
            }
        }
        
    }
    
    
    func addRequestFinishDelegate(requestFinishDelegate: RequestFinishedProtocol) {
        
        if !(self.arrRequestFinishedDelegates as NSArray).contains(requestFinishDelegate) {
            self.arrRequestFinishedDelegates.append(requestFinishDelegate)
        }
    }
    
    func removeRequestFinishedDelegate(requestFinishDelegate: RequestFinishedProtocol) {
        
        if self.arrRequestFinishedDelegates.count > 0 {
            
            let index = (self.arrRequestFinishedDelegates as NSArray).index(of: requestFinishDelegate)
            
            if index <= self.arrRequestFinishedDelegates.count {
                self.arrRequestFinishedDelegates.remove(at: index)
            }
        }
    }
    
    
    //MARK: General
    
    func createJSONDictForNoInternetSituation() -> [String:Any] {
        
        var dictJSON = [String:Any]()
        
        dictJSON.updateValue(0, forKey: "status")
        
        var dictError = [String:Any]()
        
        dictError.updateValue("-1", forKey: "id")
        dictError.updateValue(Translation(Translations.AlertButtonsKeys.noInternet, Translations.AlertButtonsKeys.noInternetDefault), forKey: "content")
        
        dictJSON.updateValue(dictError, forKey: "err")
        
        return dictJSON
        
    }
    
    
    override func reset() {
        RequestManager.sharedInstance = RequestManager.init()
        
    }
    
    
}
