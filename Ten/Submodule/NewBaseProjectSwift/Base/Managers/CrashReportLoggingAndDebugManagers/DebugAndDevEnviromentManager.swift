//
//  DebugAndDevEnviromentManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MBProgressHUD
import MessageUI
import DeviceGuru

class DebugAndDevEnviromentManager : BaseManager,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = DebugAndDevEnviromentManager()
    
    var isAppInDevEnviroment: Bool = false {
        didSet(newValue) {
            LogMsg("isAppInDevEnviroment \(newValue)")
        }
    }
    var strDevEnviromentUrl  = "https://devapimhaifa.inmanage.com"
    var strEnviromentUrl = ""
    var arrRequestNamesForDebugging = [String]()
    var arrRequestLogs = [RequestLog]()
    
    
    func canAppBeInDevEnviromentWithShowDeveloperOptions(showDeveloperOptions :Bool) -> (Bool) {
        return showDeveloperOptions && self.strDevEnviromentUrl.count > 0
    }
    
    func showRequestDebugHUDWithRequestName(requestName :String) {
        
        arrRequestNamesForDebugging.append(requestName)
        
        if self.canShowRequestDebugHUD() {
            self.showRequestDebugHUD()
        }
        
    }
    
    
    private func canShowRequestDebugHUD() -> (Bool) {
        
        if (MBProgressHUD(for: (ApplicationManager.sharedInstance.navigationController.view)!) != nil) {
            return false
        }
        
        return true
    }
    
    func showRequestDebugHUD() {
        if arrRequestNamesForDebugging.count > 0 {
            
            DispatchQueue.main.async {
                let hud = MBProgressHUD.showAdded(to: (ApplicationManager.sharedInstance.navigationController.view)!, animated: true)
                hud.delegate = self
                hud.offset = CGPoint(x: 0, y: 250)
                hud.mode = .text
                hud.label.text = self.arrRequestNamesForDebugging.first ?? self.arrRequestNamesForDebugging.first!
                hud.margin = 10
                hud.removeFromSuperViewOnHide = true
                hud.isUserInteractionEnabled = false
                hud.hide(animated: true, afterDelay: 2)
                
            }
            
        }
    }
    
    
    
    // MARK: - Developer Options
    
    // Shows an action sheet of options (after tapping side menu cell or a button)
    func displayDeveloperOptions() {
        
        let strEnterOrExitDevEnviroment = self.isAppInDevEnviroment ? Translation(Translations.DeveloperOptions.exitDevEnviroment, Translations.DeveloperOptions.exitDevEnviromentDefault) : Translation(Translations.DeveloperOptions.enterDevEnviroment, Translations.DeveloperOptions.enterDevEnviromentDefault)
        
        let actionSheet = UIAlertController(title: Translation(Translations.DeveloperOptions.title, Translations.DeveloperOptions.titleDefault), message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Translation(Translations.AlertButtonsKeys.cancel, Translations.AlertButtonsKeys.cancelDefault), style: .cancel, handler: { (alert) in
            
        }))
        
        if ApplicationManager.sharedInstance.userAccountManager.user.showSendCallLogOption {
            actionSheet.addAction(UIAlertAction(title: Translation(Translations.DeveloperOptions.sendCallLogsToMail, Translations.DeveloperOptions.sendCallLogsToMailDefault), style: .default, handler: { (alert) in
                self.sendCallLogsToMail()
            }))
        }
        
        if ApplicationManager.sharedInstance.userAccountManager.user.showDeveloperOptions {
            actionSheet.addAction(UIAlertAction(title: strEnterOrExitDevEnviroment, style: .default, handler: { (alert) in
                self.enterOrExitDevEnviroment(strEnviromentUrl: self.strDevEnviromentUrl)
                
            }))
            
        }
        
        actionSheet.addAction(UIAlertAction(title: Translation(Translations.DeveloperOptions.generalInfo, Translations.DeveloperOptions.generalInfoDefault), style: .default, handler: { (alert) in
            self.displayApplicationGeneralInfo()
            
        }))
        
        //        ApplicationManager.sharedInstance.navigationController.present(actionSheet, animated: true)
        
        if let aDelegate = UIApplication.shared.delegate {
            if let aWindow = aDelegate.window {
                if let aRootVC = aWindow?.rootViewController {
                    aRootVC.present(actionSheet, animated: true, completion: {
                        
                    })
                }
            }
        }
        
    }
    
    // Attaches the session request logs in (txt form) to an email for easy debugging
    func sendCallLogsToMail() {
        if convertArrRequestLogsToTxtInDocumentsDirectory() {
            composeUserDebugMailMessage()
        }
        
    }
    
    // Toggles dev environement mode and restarts app
    func enterOrExitDevEnviroment(strEnviromentUrl: String) {
        
        // Failsafe for trying to enter dev enviroment
        if !self.isAppInDevEnviroment && !self.canAppBeInDevEnviromentWithShowDeveloperOptions(showDeveloperOptions: ApplicationManager.sharedInstance.userAccountManager.user.showDeveloperOptions) {
            
            ApplicationManager.sharedInstance.alertManager.showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertControllerAlert, andTitle: "Can't Enter Dev Enviroment", andMessage: "No Dev Enviroment Url Available...", andAction: nil)
            return
        }
        
        if self.strEnviromentUrl.isEmpty || self.strEnviromentUrl == strEnviromentUrl {
            self.isAppInDevEnviroment = !self.isAppInDevEnviroment
        }
        
        let isAppInDevEnviroment = self.isAppInDevEnviroment
        
        ApplicationManager.sharedInstance .restartAppWithBlockToExecute {
            ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment = isAppInDevEnviroment
            ApplicationManager.sharedInstance.debugAndDevEnviromentManager.strEnviromentUrl = strEnviromentUrl
            
        }
        
    }
    
    // Shows general information about the app in an alert
    func displayApplicationGeneralInfo() {
        let strApplicationInfo = self.createApplicationInfoString()
        
        ApplicationManager.sharedInstance.alertManager.showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertControllerAlert, andTitle: "About Application", andMessage: strApplicationInfo, andAction: nil)
        
    }
    
    
    //MARK: - Call Logs
    
    func convertArrRequestLogsToTxtInDocumentsDirectory() -> (Bool) {
        
        let strToConvert = NSMutableString(string: "")
        
        let strStartCall = "\n//////////////////// Start Call ////////////////////\n\n"
        let strEndCall = "\n//////////////////// End Call //////////////////////\n\n\n"
        
        for requestLog in self.arrRequestLogs {
            
            let strRequestLog = NSMutableString(string: strStartCall)
            
            let strRequestSentDate = ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: requestLog.requestSentDate)
            
            let strResponseDateBeforeParsing = ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: requestLog.responseDateBeforeParsing)
            
            let strResponseDateAfterParsing = ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: requestLog.responseDateAfterParsing)
            
            strRequestLog.appending("Request name: \(requestLog.strRequestName)\n")
            strRequestLog.appending("Request Sent Date: \(strRequestSentDate)\n")
            strRequestLog.appending("Response Date before Parsing: \(strResponseDateBeforeParsing)\n")
            strRequestLog.appending("Response Date after Parsing: \(strResponseDateAfterParsing)\n")
            strRequestLog.appending("Request URL: \(requestLog.strRequestUrl)\n")
            strRequestLog.appending("Request URL with Params: \(requestLog.strRequestWithParamsUrl)\n")
            strRequestLog.appending("Response: \(requestLog.strResponse)\n")
            strRequestLog.appending(strEndCall)
            strToConvert.appending(strRequestLog as String)
            
        }
        
        
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.relativePath
        
        
        do {
            try strToConvert.write(toFile: (documentsDir?.stringByAppendingPathComponent(path: "ApiCallLog.txt"))!, atomically: true, encoding: String.Encoding.utf8.rawValue)
            
            LogMsg("succeeded in writing Api call log to disk");
            return true
            
        } catch {
            LogMsg("failed in writing Api call log to disk");
            return false
            
            
        }
    }
    
    
    func composeUserDebugMailMessage() {
        
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.relativePath
        
        if let aDocumentsDir = documentsDir {
            
            let apiCallLogPath = aDocumentsDir.stringByAppendingPathComponent(path: "ApiCallLog.txt")
            
            if ApplicationManager.sharedInstance.fileManager.fileExistsAtAbsolutePath(path: apiCallLogPath) && MFMailComposeViewController.canSendMail() {
                
                if !MFMailComposeViewController.canSendMail() {
                    LogMsg("Mail services are not available")
                    return
                }
                
                let mailCont = MFMailComposeViewController()
                mailCont.delegate = self
                
                mailCont.setSubject("Api calls log")
                mailCont.setMessageBody("Api calls log", isHTML: false)
                let mailContData = NSData.init(contentsOfFile: apiCallLogPath)
                
                if let aMailContData = mailContData {
                    
                    mailCont.addAttachmentData(aMailContData as Data, mimeType: "text/plain", fileName: "ApiCallLog.txt")
                    
                    ApplicationManager.sharedInstance.navigationController.present(mailCont, animated: true)
                    
                }
                
            }
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if error != nil  {
            LogMsg("error: \(error!)")
        }
        
        if result == .sent {
            
            arrRequestLogs.removeAll()
            
            let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.relativePath
            
            if let aDocumentsDir = documentsDir {
                
                let apiCallLogPath = aDocumentsDir.stringByAppendingPathComponent(path: "ApiCallLog.txt")
                
                if ApplicationManager.sharedInstance.fileManager.fileExistsAtAbsolutePath(path: apiCallLogPath) {
                    
                    do {
                        try FileManager.default.removeItem(atPath: apiCallLogPath)
                        
                    } catch {}
                    
                }
            }
        }
        
        ApplicationManager.sharedInstance.navigationController.dismiss(animated: true, completion: nil)
        
    }
    
    // Creates an application information string from all relevant app data
    func createApplicationInfoString() -> (String) {
        
        guard let infoDict = Bundle.main.infoDictionary else {
            return ""
        }
        
        var strApplicationInfo = ""
        
        var strApplicationName = ""
        
        if let displayName = infoDict["CFBundleDisplayName"] {
            strApplicationName = "Application Name:\n \(displayName)\n\n"
        }
        
        strApplicationInfo += strApplicationName
        
        var strApplicationVersion = ""
        
        if let shortVersionString = infoDict["CFBundleShortVersionString"] {
            
            strApplicationVersion = "Application Version: \(shortVersionString)\n\n\n"
            
        }
        
        strApplicationInfo += strApplicationVersion
        
        var strAPIVersion = ""
        
        if let apiVersion = infoDict["APIVersion"] {
            strAPIVersion = "Application API Version:\n \(apiVersion)\n\n"
        }
        
        strApplicationInfo += strAPIVersion
        
        let strRequestUrl = self.isAppInDevEnviroment ? strDevEnviromentUrl : Constans.baseLiveURL
        
        let strUrl = "Application Url:\n \(strRequestUrl)\n\n"
        
        strApplicationInfo += strUrl
        
        let strRequestFullUrl = "\(strRequestUrl)/\(Constans.defaultPath)"
        
        let strFullUrl = "Application Full Url:\n \(strRequestFullUrl)\n\n"
        
        strApplicationInfo += strFullUrl
        
        let strUserAgent = "User Agent:\n \(self.getUserAgentString())\n\n"
        
        strApplicationInfo += strUserAgent
        
        /*
         NSString *strUrlScheme = [NSString stringWithFormat:@"Application Url Scheme:\n%@\n\n", kApplicationUrlSchemeIGroupon];
         
         [strApplicationInfo appendString:strUrlScheme];
         */
        
        var strDeviceToken = ""
        
        if let deviceToken = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: Constans.kDeviceToken) {
            strDeviceToken = "Device Token: \n\(deviceToken))\n\n"
        }
        
        strApplicationInfo += strDeviceToken
        
        /*
         NSString *strApplicationSecurityToken = [NSString stringWithFormat:@"Application Security Token:\n%@\n\n", kApplicationSecurityToken];
         
         [strApplicationInfo appendString:strApplicationSecurityToken];
         
         NSString *strYes = @"Yes";
         
         NSString *strNo = @"No";
         
         // Google Analytics
         NSString *strUsesGoogleAnalytics = [ApplicationManager sharedInstance].gANTManager.applicationUsesGoogleAnalytics ? strYes : strNo;
         
         NSString *strGoogleAnalytics = [NSString stringWithFormat:@"Google Analytics: %@\n\n", strUsesGoogleAnalytics];
         
         [strApplicationInfo appendString:strGoogleAnalytics];
         
         // If app uses Flurry, put yes here
         NSString *strUsesFlurry = strNo;
         
         NSString *strFlurry = [NSString stringWithFormat:@"Flurry: %@\n\n", strUsesFlurry];
         
         [strApplicationInfo appendString:strFlurry];
         
         // Can recieve remote notifications - i.e. didRegisterForRemoteNotificationsWithDeviceToken called by OS
         NSString *strReceivesRemoteNotifications = [ApplicationManager sharedInstance].remoteNotificationAndDeepLinkManager.didRegisterForRemoteNotificationsCalled ? strYes : strNo;
         
         NSString *strRemoteNotifications = [NSString stringWithFormat:@"Remote Notifications: %@\n\n", strReceivesRemoteNotifications];
         
         [strApplicationInfo appendString:strRemoteNotifications];
         
         // If app doesn't use encryption for user email/password, put no here
         NSString *strUsesEncryption = strYes;
         
         NSString *strEncryption = [NSString stringWithFormat:@"Encryption: %@\n\n", strUsesEncryption];
         
         [strApplicationInfo appendString:strEncryption];
         
         // Custom fonts
         NSString *strUsesCustomFonts = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIAppFonts"] ? strYes : strNo;
         
         NSString *strCustomFonts = [NSString stringWithFormat:@"Custom Fonts: %@\n\n", strUsesCustomFonts];
         
         [strApplicationInfo appendString:strCustomFonts];
         */
        
        return String(strApplicationInfo)
        
    }
    
    func getUserAgentString() -> (String) {
        
        let strDeviceName = self.getDeviceName()
        
        var strAppName: String {
            
            let tempAppName = Bundle.main.infoDictionary?[kCFBundleExecutableKey as String] as? String
            
            if let aAppName = tempAppName {
                return aAppName + " "
            }
            
            let strIdKey = Bundle.main.infoDictionary?[kCFBundleIdentifierKey as String] as? String
            
            if let aStrIdKey = strIdKey {
                return aStrIdKey + " "
            }
            
            return ""
            
        }
        
        var strAppVer: String {
            
            let tempAppName = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            
            if let aAppName = tempAppName {
                return aAppName + " "
            }
            
            let strIdKey = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
            
            if let aStrIdKey = strIdKey {
                return aStrIdKey + " "
            }
            
            return ""
            
        }
        
        let strSystemVer = UIDevice.current.systemVersion
        
        let strAPIVersion = Bundle.main.infoDictionary?["APIVersion"] as! String
        
        let scale = UIScreen.main.scale
        
        let userAgent = String(format: "%@/App-Ver_%@ API-Ver_%@ (%@; iOS %@; Scale/%0.2f)", strAppName , strAppVer,strAPIVersion , strDeviceName, strSystemVer, scale)
        
        return userAgent
        
    }
    
    func getDeviceName() -> (String) {
        let deviceGuru = DeviceGuru()
        let deviceName = deviceGuru.hardware()
        let strHardware = "\(deviceName)".uppercased()
        
        return strHardware
        
    }
    
    // MARK: - Request Log
    
    func createAndAddRequestLogFromRequestName(strRequestName: String, andRequestSentDate requestSentDate: Date, andUrlRequest urlRequest: URLRequest, andResponseDateBeforeParsing responseDateBeforeParsing: Date, andResponse response: Any, andResponseDateAfterParsing responseDateAfterParsing: Date) {
        
        DispatchQueue.global(qos: .background).async {
            
            var requestLog = RequestLog()
            
            requestLog.strRequestName = strRequestName
            requestLog.requestSentDate = requestSentDate
            
            var strRequestUrl: String {
                
                if let aUrlRequest = urlRequest.url {
                    return aUrlRequest.absoluteString
                }
                
                return ""
                
            }
            
            
            let strRequestParams = String(data: urlRequest.httpBody!, encoding: String.Encoding.utf8)!
            
            let strRequestWithParamsUrl = NSMutableString(string: strRequestUrl)
            
            if !strRequestParams.isEmpty {
                
                strRequestWithParamsUrl.append("/?\(strRequestParams)")
                
            }
            
            requestLog.strRequestUrl = strRequestUrl
            requestLog.strRequestWithParamsUrl = String(strRequestWithParamsUrl)
            requestLog.responseDateBeforeParsing = responseDateBeforeParsing
            
            var strResponse = String()
            
            if JSONSerialization.isValidJSONObject(response) {
                
                do {
                    let JSONData = try JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions(rawValue: 0))
                    strResponse = String(data: JSONData, encoding: String.Encoding.utf8)!
                    
                } catch {
                    print(error)
                }
                
            } else if response is Error {
                
                let errorResponse = response as! NSError
                
                strResponse = "ERROR: \(errorResponse.description)"
                
            } else {
                
                strResponse = "\(response)"
                
            }
            
            requestLog.strResponse = strResponse
            
            requestLog.responseDateAfterParsing = responseDateAfterParsing
            
            
            let lockQueue = DispatchQueue(label: "LockQueue")
            lockQueue.sync() {
                self.arrRequestLogs.append(requestLog)
            }
            
        }
        
    }
    
    
    func getRequestLog(requestLog: RequestLog) -> (NSMutableString) {
        
        let strRequestLog = NSMutableString()
        
        let strRequestSentDate = ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: requestLog.requestSentDate)
        
        let strResponseDateBeforeParsing = ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: requestLog.responseDateBeforeParsing)
        
        let strResponseDateAfterParsing = ApplicationManager.sharedInstance.timeManager.getFullDateAndTimeString(from: requestLog.responseDateAfterParsing)
        
        
        strRequestLog.append("Request Name: \(requestLog.strRequestName)/n")
        strRequestLog.append("Request Sent Date: \(strRequestSentDate)/n")
        strRequestLog.append("Response Date before Parsing: \(strResponseDateBeforeParsing)/n")
        strRequestLog.append("Response Date after Parsing: \(strResponseDateAfterParsing)/n")
        strRequestLog.append("Request URL: \(requestLog.strRequestUrl)/n")
        strRequestLog.append("Request URL with Params: \(requestLog.strRequestWithParamsUrl)/n")
        strRequestLog.append("Response: \(requestLog.strResponse)/n")
        
        return strRequestLog
        
    }
    
    func getLastHttpRequest() -> (String) {
        
        if arrRequestLogs.count > 0 {
            if let lastObject = arrRequestLogs.last {
                return "\(self.getRequestLog(requestLog: lastObject))"
            }
        }
        
        return ""
    }
    
    func showToast(title: String) {
        
        let hud = MBProgressHUD.showAdded(to: ApplicationManager.sharedInstance.tabBarController.view, animated: true)
        hud.mode = .text
        hud.detailsLabel.text = title
        hud.removeFromSuperViewOnHide = true
        hud.margin = 10
        hud.setY(newY: UIScreen.main.bounds.height / 2 - 66 - 20)
        hud.hide(animated: true, afterDelay: 5)
        hud.setupWithBorderColor(borderColor: nil, andBorderWidth: nil, addCornerRadius: true)
        
        
        
    }
    
    
    
    // MARK: - Reset Protocol
    
    override func reset() {
        DebugAndDevEnviromentManager.sharedInstance = DebugAndDevEnviromentManager()
    }
    
}


extension DebugAndDevEnviromentManager : MBProgressHUDDelegate {
    
    func hudWasHidden(_ hud: MBProgressHUD) {
        
        if arrRequestNamesForDebugging.count > 0 {
            
            arrRequestNamesForDebugging.removeFirst()
            self.showRequestDebugHUD()
            
        }
        
    }
    
    
}


