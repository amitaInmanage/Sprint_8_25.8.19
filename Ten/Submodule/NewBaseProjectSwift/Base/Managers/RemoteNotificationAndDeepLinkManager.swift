//
//  RemoteNotificationAndDeepLinkManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import UserNotifications
import Pushwoosh

struct RemoteNotificationKeys {
    static let alert = "alert"
    static let deepLink = "deep_link"
}

struct PayloadKeys {
    static let action = "action"
    static let activity = "activity"
    static let status = "status"
    static let page = "page"
}

enum ApplicationOpenedEventType: Int{
    case none = 0, url, remoteNotification
}

class RemoteNotificationAndDeepLinkManager: BaseManager {
    
    static var sharedInstance = RemoteNotificationAndDeepLinkManager()
    
    var storePamentMathods = [StorePaymentMethodsItem]()
    var launchRemoteNotificationDict = [String:Any]()
    var launchURL : URL?
    var didRegisterForRemoteNotificationsCalled = false
    var pushTypes = false
  
    func registerForRemoteNotifications() {
        
        if !DeviceType.isSimulator {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    
                    if granted {
                        
                        DispatchQueue.main.async(execute: {
                            UIApplication.shared.registerForRemoteNotifications()
                        })
                    }
                }
                
            } else {
                
                let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
                
            }
            
        }
        
        let strDeviceToken = ""
        ApplicationManager.sharedInstance.keychainManager.saveStringToKeychain(strDeviceToken, forKey: Constans.kDeviceToken)
        
    }
    
    //MARK: Remote Notification and openURL handling
    func handleRemoteNotification(dict :[String:Any], isFromFinishLaunching fromFinishLaunching: Bool) {
        
        // App was in the background when the remote notification was tapped - restarts the app but saves dict
        if !fromFinishLaunching && UIApplication.shared.applicationState != .active {
            
            ApplicationManager.sharedInstance.restartAppWithBlockToExecute(blockToExecute: {
                ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.launchRemoteNotificationDict = dict
            })
            
        }
            // App was terminated when the remote notification was tapped, or app was restarted (see above), or app was in the foreground when remote notif arrived
        else {
            
            //            var notificationAlertStr : String = "\(dict[RemoteNotificationKeys.alert])"
            //            
            //            if notificationAlertStr.isEmpty {
            //                notificationAlertStr = "."
            //            }
            ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(withDictPayLoad: dict, dataObject: nil, animated: true, completionHandler: nil)
            
            
        }
        
    }
    
    // Open url (deeplink) handling
    func handleApplicationLaunchedWithUrl(url: URL?, andIsFromFinishLaunching isFromFinishLaunching: Bool) {
        
        if url == nil {
            return
        }
        
        var applicationState = ""
        
        switch UIApplication.shared.applicationState {
            
        case .active:
            applicationState = "UIApplicationStateActive"
            
        case .inactive:
            applicationState = "UIApplicationStateInactive"
            
        case .background:
            applicationState = "UIApplicationStateBackground"
            
        }
        
        LogMsg("UIApplication.shared.applicationState: \(applicationState)")
        
        // App was in the background when the Open url event occurred - restarts the app but saves url
        if !isFromFinishLaunching && UIApplication.shared.applicationState != .active || ApplicationManager.sharedInstance.timeManager.registerCallTimeAndCheckIfMaxTimePassed(){
            
            ApplicationManager.sharedInstance.restartAppWithBlockToExecute(blockToExecute: {
                ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.launchURL = url!
            })
        }
        else {
            
            _ =   ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(strFullDeeplink: url!.absoluteString, dataObject: nil, animated: true, completionHandler: nil)
            
        }
        
    }
    
    func getPageStringFromURL(url:URL)->(String)
    {
        
        let strURL = String(describing: url)
        
        let arr = strURL.components(separatedBy:"page=")
        
        let strPage = arr.last
        
        return strPage!
        
    }
    
    
    
    // Remote notification and Open url (deeplink) handling - change behavior per application
    func handleApplicationOpenedEvent(applicationOpenedEventType :ApplicationOpenedEventType, withPayloadDict payloadDict: [String:Any], andNotificationAlertStr notificationAlertStr: String, andIsFromFinishLaunching isFromFinishLaunching: Bool) {
        
        let strAction : String = ParseValidator.getStringForKey(key: PayloadKeys.action, JSONDict: payloadDict, defaultValue: "")
        
        let numActivityStatus = payloadDict[PayloadKeys.status]
        
        // App was in foreground when event occured - therefor show 2 button alert
        if !isFromFinishLaunching && UIApplication.shared.applicationState == .active {
            
            // Removes all displayed alertViews
            ApplicationManager.sharedInstance.alertManager.isAppShowingAlertViews()
            
        } else {
            self.handleApplicationEventActivityWithNumActivityStatus(numActivityStatus: numActivityStatus!)
        }
        
    }
    
    
    // Posts notification to handle the Open url (deeplink) or remote notification event (usually caught and handled by the side menu, since most relevant screens can be navigated to by the side menu...)
    func handleApplicationEventActivityWithNumActivityStatus(numActivityStatus: Any) {
        
        ApplicationManager.sharedInstance.popupManager.dismissAllPopups()
        
        var dictUserInfo = [String:Any]()
        
        dictUserInfo.updateValue(SideMenuItemID.activity, forKey: "")
        dictUserInfo.updateValue(numActivityStatus, forKey: "")
        
        if let presntedViewContorller = ApplicationManager.sharedInstance.navigationController.presentedViewController {
            
            presntedViewContorller.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: dictUserInfo)
            })
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: dictUserInfo)
        }
        
    }
    
    // Registers push notification deviceToken with server
    func callRegisterPushNotification() {
        
        let dictParams = RegisterPushNotificationRequest.createInitialDictParams()
        
        let request = RegisterPushNotificationRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: self)
        
        request.showHUD = false
        request.showResponseMessages = false
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callSetNotificationsSettings(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        if delegate == nil {
            delegate = self
        }
        
        let request = SetNotificationSettingsRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    override func reset() {
        RemoteNotificationAndDeepLinkManager.sharedInstance = RemoteNotificationAndDeepLinkManager()
    }
    
    func openDeepLink(strFullDeeplink: String, dataObject: Any?, animated: Bool?, completionHandler: (() -> Void)!, isFromHomePage: Bool = false) -> Bool{
        
        let dictPayload = self.getPayloadDictFrom(deeplinkStr: strFullDeeplink)
        
        return self.openDeepLink(withDictPayLoad: dictPayload, dataObject: dataObject, animated: animated, completionHandler: completionHandler, isFromHomePage: isFromHomePage)
    }
    
    func openDeepLink(withDictPayLoad: [String:Any], dataObject: Any?, animated: Bool?, completionHandler: (() -> Void)!, isFromHomePage: Bool = false) -> Bool {
        
        let strPage = withDictPayLoad["page"]
        
        if let aStrPage = strPage as? String {
            
            switch aStrPage {
            case DeepLinkPageStrings.personalInformation.rawValue:
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PersonalDetailsViewControlles.className) as? PersonalDetailsViewControlles {
                    personalZone.user = ApplicationManager.sharedInstance.userAccountManager.user
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
                break
            case DeepLinkPageStrings.transactionsHistory.rawValue:
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: TransactionsHistoryViewController.className) as? TransactionsHistoryViewController {
                    personalZone.user = ApplicationManager.sharedInstance.userAccountManager.user
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
                break
            case DeepLinkPageStrings.fuelingDevices.rawValue:
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: CarManagmentViewControoler.className) as? CarManagmentViewControoler {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
                break
                
            case DeepLinkPageStrings.myClubs.rawValue:
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: ClubsViewController.className) as? ClubsViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
                break
         
            case DeepLinkPageStrings.usageInformation.rawValue:
                print("usage_information")
                break
                
            case DeepLinkPageStrings.storePaymentMethods.rawValue:
                
                UserAccountManager.sharedInstance.validateUserPayment(storePamentMathods: storePamentMathods)
                
                break
            case DeepLinkPageStrings.logout.rawValue:
                ApplicationManager.sharedInstance.userAccountManager.callLogoutWithUserAccountProcessObj(userAccountProcessObj: nil, andRequestFinishedDelegate: nil)
                break
            case DeepLinkPageStrings.content.rawValue:
                let contentId = ParseValidator.getStringForKey(key: "id", JSONDict: withDictPayLoad, defaultValue: "")
                if !contentId.isEmpty {
                    ApplicationManager.sharedInstance.sideMenuAndContentPageManager.callGetContentPageWithDictParams(dictParams: [ServerGeneralParams.pageId:contentId], andRequestFinishedDelegate: nil)
                    
                }
                break
            case DeepLinkPageStrings.order.rawValue:
                break
            case DeepLinkPageStrings.paymentRequest.rawValue:
                break
            default:
                break
            }
            return true
        }
        
        return false
        
    }
    
    func getPayloadDictFrom(deeplinkStr: String ) -> [String:Any] {
        
        let newDeeplinkStr = deeplinkStr.stringByReplacingFirstOccurrenceOfString(target: "amp;", withString: "")
        
        var payloadDict = [String:Any]()
        
        if !newDeeplinkStr.isEmpty && (newDeeplinkStr.contains(AppUrlScheme.urlScheme) || newDeeplinkStr.contains(AppUrlScheme.urlScheme)) {
            
            let splitParm = newDeeplinkStr.contains(AppUrlScheme.urlSchemeSplit) ? AppUrlScheme.urlSchemeSplit : AppUrlScheme.urlScheme
            
            let stringParams = newDeeplinkStr.components(separatedBy: splitParm).last!
            
            var arrParams = [String]()
            
            if newDeeplinkStr.contains(AppUrlScheme.urlSchemeSplit) {
                arrParams = stringParams.components(separatedBy: "&")
            }
            else{
                
                arrParams = stringParams.components(separatedBy: "/")
                //TODO: page id .. copy from groupon
            }
            
            for paramAndVal in arrParams {
                let paramAndValArr = paramAndVal.components(separatedBy: "=")
                payloadDict.updateValue(paramAndValArr.last ?? "", forKey: paramAndValArr.first!)
            }
            
        }
        return payloadDict
    }
    
    func registerForPushwoosh(pushTypes: Bool) {
        
    }
    
   
    
    // MARK: - Server Request Done Delegate
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == ServerStartupRequests.registerPushNotification {
            
            if let innerRes = innerResponse as? RegisterPushNotificationResponse {
                self.pushTypes = innerRes.pushTypes
                
                self.registerForPushwoosh(pushTypes: self.pushTypes)
                
            }
        }
        
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
    
    
}
