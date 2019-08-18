//
//  UserAccountManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

enum LoggedInStatus: Int {
    case notLoggedIn = 0, loggedInWithEmail, loggedInWithFacebook, userLoggedIn
}

class UserAccountManager: BaseProcessManager,ProcessFinishedProtocol {
    
    static var sharedInstance = UserAccountManager()
    
    var user = TenUser()
    var storePamentMathods = [StorePaymentMethodsItem]()
    var tokenNewFuilingDevice = ""
    
    var isUserLoggedIn: Bool {
        get {
            return self.loggedInStatus != .notLoggedIn
        }
    }
    
    var arrScreens: Array<ScreenName> = Array<ScreenName>()
    var registrationToken = ""
    var fieldsArr = [String: Any]()
    
    fileprivate func updateSideMenu() {
        if let mainVC = ApplicationManager.sharedInstance.mainViewController {
            if let table =  mainVC.sideMenuTableViewController.tableView {
                table.reloadData()
            }
        }
    }
    
    var loggedInStatus : LoggedInStatus = .notLoggedIn {
        didSet {
            updateSideMenu()
        }
    }
    
    //MARK: Start process
    override func startProcess(processType: ProcessType, processObj: BaseProcessObj?, processFinishedDelegate: ProcessFinishedProtocol?, processCompletion: @escaping ProcessCompletion) {
        
        // Save paramaters in process
        super.startProcess(processType: processType, processObj: processObj, processFinishedDelegate: processFinishedDelegate
            , processCompletion: processCompletion)
        
        // Handle behaviour by process type (per app)
        if processType == .login || processType == .signup {
            
            // Casting to get access to all properties
            let userAccountProcessObj = processObj as! UserAccountProcessObj
            
            // User is already logged in
            if self.isUserLoggedIn {
                self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
            }
                
                // This is only for the purpose of starting the flow by pushing LoginAndSignupMainViewController and saving the delegate...
            else if userAccountProcessObj.pushLoginAndSignupTabVC {
                
                if processType == .login {
                    
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
                    
                    ApplicationManager.sharedInstance.tabBarController.pushViewController(viewController: loginVC, animated: true)
                    
                }
                else if processType == .signup {
                    
                    let signupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SignupViewController.className) as! SignupViewController
                    
                    ApplicationManager.sharedInstance.tabBarController.pushViewController(viewController: signupVC, animated: true)
                }
                
            } else {
                
                // Shouldn't be possible that userDefaults contains email and facebook login info simultaneously
                let strFBAccessToken = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.FBaccessToken)
                let strFBId = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.fbid)
                
                let strEmail = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.email)
                let strPassword = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.password)
                
                let lastLoggedInWithFacebook = ApplicationManager.sharedInstance.keychainManager.retrieveBoolFromKeychain(key: PersonalDetailsKeys.lastLoginWithFB)
                
                _ = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: DiskKeys.loginHash)
                
                // i.e. from startup
                if userAccountProcessObj.isSilentRequest {
                    
                    if !lastLoggedInWithFacebook && !((strEmail != nil) && (strPassword != nil)) || lastLoggedInWithFacebook && !((strFBAccessToken != nil) && (strFBId != nil)) {
                        self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
                    }
                    else {
                        
                        if !lastLoggedInWithFacebook && (strEmail != nil) && (strPassword != nil) {
                            
                            userAccountProcessObj.strEmail = strEmail as? String
                            userAccountProcessObj.strPassword = strPassword as? String
                            
                            userAccountProcessObj.loginOrSignupAttemptType = .loginWithEmail
                            
                        }
                        else if lastLoggedInWithFacebook && (strFBAccessToken != nil) && (strFBId != nil) {
                            
                            userAccountProcessObj.strFBAccessToken = strFBAccessToken as? String
                            userAccountProcessObj.strFBId = strFBId as? String
                            
                            userAccountProcessObj.loginOrSignupAttemptType = .loginWithFacebook
                            
                        }
                        
                        self.callLoginUserWithUserAccountProcessObj(userAccountProcessObj: userAccountProcessObj, andRequestFinishedDelegate: self)
                        
                    }
                    
                }
                else {
                    
                    let userAccountProcessObj = UserAccountProcessObj()
                    userAccountProcessObj.loginOrSignupAttemptType = .loginAny
                    userAccountProcessObj.animate = false
                    
                    ApplicationManager.sharedInstance.facebookManager.startProcess(processType: .loginOrSignupFacebook, processObj: userAccountProcessObj, processFinishedDelegate: self, processCompletion: { (processManager, processFinishedStatus) in
                        
                        if  processFinishedStatus == ProcessFinishedStatus.ProcessFinishedStatusSuccess {
                            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
                        }
                    })
                    
                }
            }
        }
    }
    
    
    
    //MARK: Server Requests
    
    func callGetUsageInformation(dictParams: [String: Any], requestFinishedDelegate :RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetUsageInformationRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callSetUserCustomerProgram(dictParams: [String: Any], requestFinishedDelegate :RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = SetUserCustomerProgramRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callUpdateFuelingDevice(dictParams: [String: Any], requestFinishedDelegate :RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = UpdateFuelingDeviceRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callRemovePowerCard(requestFinishedDelegate :RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = RemovePowerCardRequest().initWithDictParams(dictParams: nil, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callAddPowerCard(dictParams: [String: Any], requestFinishedDelegate :RequestFinishedProtocol?)  {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = AddPowerCardRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callAddUserWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = AddUserRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callEditUserInformationWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = EditUserInformationRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    
    func callEditUserNotificationWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = EditUserNotificationRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callLoginUserWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = LoginUserRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        if userAccountProcessObj.isSilentRequest {
            request.showHUD = false
            request.showResponseMessages = false
        }
        if userAccountProcessObj.dontShowAlertMessage {
            request.showResponseMessages = !userAccountProcessObj.dontShowAlertMessage
        }
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callLogoutWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = LogoutRequest().initWithDictParams(dictParams: userAccountProcessObj?.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callChangePasswordWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = ChangePasswordRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callRestorePasswordWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = RestorePasswordRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callStartRestorePasswordWithUserAccountProcessObj(userAccountProcessObj: UserAccountProcessObj, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        self.processObj = userAccountProcessObj
        
        let request = StartRestorePasswordRequest().initWithDictParams(dictParams: userAccountProcessObj.createRequestDictParamsFromProperties(), andRequestFinishDelegate: delegate)
        
        request.showResponseMessageForSuccess = true
        request.showResponseMessageForFailure = false
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callGetTransactionsHistory(dictParams: [String:Any], requestFinishedDelegate :RequestFinishedProtocol? , vc: UIViewController? = nil ) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetTransactionsHistoryRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callRemoveStorePaymentMethod(dictParams: [String:Any], requestFinishedDelegate :RequestFinishedProtocol? , vc: UIViewController? = nil ) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = RemoveStorePaymentMethodRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callAddCreditCard(requestFinishedDelegate :RequestFinishedProtocol? , vc: UIViewController? = nil ) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = AddCreditCardRequest().initWithDictParams(dictParams: nil, andRequestFinishDelegate: requestFinishedDelegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    
    func callGetUserFavoritesWithRequestFinishedDelegate(requestFinishedDelegate :RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetUserFavoritesRequest().initWithDictParams(dictParams: nil, andRequestFinishDelegate: delegate)
        
        request.showResponseMessages = false;
        request.showHUD = true;
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callRemoveFuelingDevice(dictParams: [String: Any], requestFinishedDelegate :RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = RemoveFuelingDeviceRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    
    func callAddToFavorites(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = AddToFavoritesRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        request.showResponseMessages = true
        request.showHUD = true
        request.showResponseMessages = true
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    func callRemoveFromFavorites(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = RemoveFromFavoritesRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        request.showResponseMessages = true
        request.showHUD = true
        request.showResponseMessages = true
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callGetUserSettings(dictParams: [String:Any]?, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        //        let request = GetUserSettingsRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        //
        //        request.showResponseMessages = true
        //        request.showHUD = true
        //        request.showResponseMessages = true
        //
        //        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
        
    }
    
    func callSetUserSettings(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        //        let request = SetUserSettingsRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        //
        //        request.showResponseMessages = true
        //        request.showHUD = false
        //        request.showResponseMessages = true
        //
        //        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    //MARK: - Login Additions for MINDSPACE
    
    func callSilentLogin(requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = SilentLoginRequest().initWithDictParams(dictParams: SilentLoginRequest().getInitialDictParams(), andRequestFinishDelegate: delegate)
        request.showHUD = false
        request.showResponseMessages = false
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callCheckSmsToken(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = CheckSmsTokenRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        request.showResponseMessages = false
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callStarsNewFuelingDeviceProcess(requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = StartNewFuelingDeviceProcessRequest().initWithDictParams(dictParams: SilentLoginRequest().getInitialDictParams(), andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    func callGetSmsToken(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?, showHud: Bool = true) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetSmsTokenRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        request.showHUD = showHud
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
        
    }
    
    func callUpdateRegistrationData(dictParams: [String:Any], screenName: String, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        var newDictParams = dictParams
        newDictParams.updateValue(self.registrationToken, forKey: UpdateRegistrationDataCallsParams.registrationToken)
        newDictParams.updateValue(screenName, forKey: UpdateRegistrationDataCallsParams.screen)
        
        let request = UpdateRegistrationDataRequest().initWithDictParams(dictParams: newDictParams, andRequestFinishDelegate: delegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callUpdateNewFuelingDeviceProcessData(dictParams: [String:Any], screenName: String, andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        var newDictParams = dictParams
        newDictParams.updateValue(self.tokenNewFuilingDevice, forKey: UpdateNewFuelingDeviceProcessDataParams.token)
        newDictParams.updateValue(screenName, forKey: UpdateNewFuelingDeviceProcessDataParams.screen)
        
        let request = UpdateNewFuelingDeviceProcessDataRequest().initWithDictParams(dictParams: newDictParams, andRequestFinishDelegate: delegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
    }
    
    
    func callverifyPinCode(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        var newDictParams = dictParams
        newDictParams.updateValue(self.registrationToken, forKey: UpdateRegistrationDataCallsParams.registrationToken)
        
        let request = VerifyPinCodeRequests().initWithDictParams(dictParams: newDictParams, andRequestFinishDelegate: delegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    func callEditUserInformation (dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = EditUserInformationRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
        
    }
    
    //not in use in this app
    func callConnectSocialAccount(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
        var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        //        let request = ConnectSocialAccountRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        //        request.showHUD = false
        //        request.showResponseMessages = true
        //        request.showResponseMessageForFailure = true
        //        request.alertDisplayInViewTypeForFailureMessage = .alertCustomView
        //
        //        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request)
    }
    
    //MARK: General
    
    func setStrPicture(imageView: UIImageView) -> Bool {
        if !self.user.strPicture.isEmpty && !self.user.isBase64UserImage {
            imageView.setImageWithStrURL(strURL: self.user.strPicture, withAddUnderscoreIphone: false)
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius =  imageView.height() / 2
            return true
        } else if !self.user.strPicture.isEmpty && self.user.isBase64UserImage {
            if let bgImage : UIImage = ApplicationManager.sharedInstance.gUIManager.getImageFromBase64String(strEncodeData: self.user.strPicture) {
                imageView.image = bgImage
                imageView.layer.masksToBounds = true
                imageView.layer.cornerRadius =  imageView.height() / 2
                return true
            }
        } else {
            return false
        }
        return false
    }
    
    func canAttemptLoginOfType(loginOrSignupAttemptType: LoginOrSignupAttemptType) -> (Bool) {
        
        let strFBAccessToken = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.FBaccessToken)
        let strFBId = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.fbid)
        
        let strEmail = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.email)
        let strPassword = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: PersonalDetailsKeys.password)
        
        let lastLoggedInWithFacebook = ApplicationManager.sharedInstance.keychainManager.retrieveBoolFromKeychain(key: PersonalDetailsKeys.lastLoginWithFB)
        
        switch loginOrSignupAttemptType {
            
        case .loginWithEmail:
            
            if !lastLoggedInWithFacebook && strEmail != nil && strPassword != nil {
                return true
            }
            
        case .loginWithFacebook:
            
            if lastLoggedInWithFacebook && strFBAccessToken != nil && strFBId != nil {
                return true
            }
            
        case .loginAny:
            
            if ((!lastLoggedInWithFacebook && (strEmail != nil && strPassword != nil)) || (lastLoggedInWithFacebook && (strFBAccessToken != nil && strFBId != nil)))  {
                return true
            }
            
        default:
            break
            
        }
        
        return false
    }
    
    func finishLogoutUser() {
        
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: DiskKeys.loginHash)
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: PersonalDetailsKeys.FBaccessToken)
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: PersonalDetailsKeys.fbid)
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: PersonalDetailsKeys.email)
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: PersonalDetailsKeys.password)
        ApplicationManager.sharedInstance.keychainManager.removeFromKeychain(forKey: PersonalDetailsKeys.lastLoginWithFB)
        
        //ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment = false
        
        ApplicationManager.sharedInstance.restartAppWithBlockToExecute {}
        
    }
    
    func updateAdditionalUserInfoFromRequest(request: BaseRequest) {
        
        //let userAccountProcessObj = self.processObj as! UserAccountProcessObj
        
        if request.requestName == ServerUserRequests.addUser || request.requestName == ServerUserRequests.loginUser || request.requestName == ServerUserRequests.checkSmsToken {
            
            self.loggedInStatus = .userLoggedIn
            
            if ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: Constans.kDeviceToken) != nil {
                ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.callRegisterPushNotification()
            }
        }
    }
    
    typealias Completion = () -> Void
    
    func startLoginProcess(completion : Completion? = nil) {
        
        let userAccountProcessObj = UserAccountProcessObj()
        
        userAccountProcessObj.loginOrSignupAttemptType = .loginAny
        userAccountProcessObj.pushLoginAndSignupTabVC = true
        userAccountProcessObj.animate = false
        
        ApplicationManager.sharedInstance.userAccountManager.startProcess(processType: .login, processObj: userAccountProcessObj, processFinishedDelegate: self) { (processManager, processFinishedStatus) in
            
            if  processFinishedStatus == ProcessFinishedStatus.ProcessFinishedStatusSuccess {
                if let comp = completion {
                    comp()
                } else {
                    ApplicationManager.sharedInstance.mainViewController.sideMenuTableViewController.moveToHome()
                    ApplicationManager.sharedInstance.mainViewController.popToHomeVC(resetAllTabsToRoot: true)
                }
                
            }
        }
    }
    
    func startRegisterProcess() {
        
        let userAccountProcessObj = UserAccountProcessObj()
        
        userAccountProcessObj.loginOrSignupAttemptType = .signupAny;
        userAccountProcessObj.pushLoginAndSignupTabVC = true;
        userAccountProcessObj.animate = false;
        
        ApplicationManager.sharedInstance.userAccountManager.startProcess(processType: .signup, processObj: userAccountProcessObj, processFinishedDelegate: self) { (processManager, processFinishedStatus) in
            
            if  processFinishedStatus == ProcessFinishedStatus.ProcessFinishedStatusSuccess {
                ApplicationManager.sharedInstance.mainViewController.sideMenuTableViewController.moveToHome()
                
                ApplicationManager.sharedInstance.mainViewController.popToHomeVC(resetAllTabsToRoot: true)
                
            }
        }
    }
    
    func createSmsAuthPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.popupType = .smsAuth
        //        popupInfoObj.strTitle = Translation(SmsAuthenticationTranslations.lblTitle, SmsAuthenticationTranslations.lblTitleDefault)
        //        popupInfoObj.strFirstButtonTitle = Translation(SmsAuthenticationTranslations.btnConfirm, SmsAuthenticationTranslations.btnConfirmDefault)
        //        popupInfoObj.strSecondButtonTitle = Translation(SmsAuthenticationTranslations.btnClose, SmsAuthenticationTranslations.btnCloseDefault)
        //
        //        popupInfoObj.strTxtFldPlaceholder = Translation(SmsAuthenticationTranslations.lblTxtFieldPlaceholder, SmsAuthenticationTranslations.lblTxtFieldPlaceholderDefault)
        //        popupInfoObj.strTxtFldError = Translation(SmsAuthenticationTranslations.lblTokenError, SmsAuthenticationTranslations.lblTokenErrorDefault)
        //
        //
        popupInfoObj.firstButtonActionWithObj = { (_ dataObject :Any) -> () in
            
            let strCode = dataObject as! String
            
            //method login
            ApplicationManager.sharedInstance.userAccountManager.callCheckSmsToken(dictParams: [PersonalDetailsKeys.token: strCode], andRequestFinishedDelegate: self)
            
        }
        
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
    
    func moveToHomePage() {
        
        if let MainVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: MainViewController.className) as? MainViewController {
            ApplicationManager.sharedInstance.navigationController.setViewControllers([MainVc], animated: true)
        }
        
    }
    
    func isScreenInStack(screenName: ScreenName) -> Bool {
        
        _ = arrScreens.filter({(item: ScreenName) in
            
            let stringMatch = item.screenName == screenName.screenName
            return stringMatch
            
        })
        return false
    }
    
    func updateScreensAndRegistrationToken(registrationToken: String?, screens: [ScreenName]?, data: Any? = nil) {
        
        if let screens = screens {
            screens.forEach { (screen) in
                
                if self.isScreenInStack(screenName: screen) == false {
                    self.arrScreens.append(screen)
                }
            }
        }
        if let registrationToken = registrationToken {
            self.registrationToken = registrationToken
        }
        
        self.moveToNextScreen()
    }
    
//    func pushViewController(StoryboardName: UIStoryboard) {
//        StoryboardName.instantiateViewController(withIdentifier: UIViewController.className)
//         ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
//    }
//    
    private func moveToNextScreen(data: Any? = nil) -> Bool {
        
        if let nextScreen = self.arrScreens.first {
            
            switch nextScreen.screenName {
            case ScreensNames.termsOfUse.rawValue:
                if let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: SignUpConfrimTermsOfServiceViewController.className) as? SignUpConfrimTermsOfServiceViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    signUpVC.viewModel.strHTML = nextScreen.contentHtml
                    signUpVC.viewModel.strUrl = nextScreen.strUrl
                    signUpVC.viewModel.strTitle = nextScreen.strTitle
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.personalInformation.rawValue:
                if let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: SignUpFullNameViewController.className) as? SignUpFullNameViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.customerType.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpChooseCustomerTypeViewController.className) as? SignUpChooseCustomerTypeViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.fuelingCard.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: EnterTheCarDetailsViewController.className) as? EnterTheCarDetailsViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    signUpVC.viewModel.strAdditionalCard = nextScreen.strIsAdditionalCard
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.carInformationFcBusiness.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpTenClientViewController.className) as? SignUpTenClientViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.carInformationFcPrivate.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpCarDetailsViewController.className) as? SignUpCarDetailsViewController {
                    signUpVC.viewModel.readOnly = false
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.carInformationClub.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpCarDetailsDelekTypeViewController.className) as? SignUpCarDetailsDelekTypeViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.carInformationDalkan.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpTenClientViewController.className) as? SignUpTenClientViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.additionalFuelingCard.rawValue:
                
                let popupInfoObj = PopupInfoObj()
                
                let carNumber = nextScreen.intLicensePlate
                var fuelType = String(nextScreen.intFuelTypeCode)
                let fuelsArr = ApplicationManager.sharedInstance.appGD.fuelTypesArr
                
                for fuel in fuelsArr {
                    fuelType = String(fuel.strTitle)
                }
                
                popupInfoObj.popupType = .tenGeneralPopup
                popupInfoObj.strImageName = "addTenCard"
                popupInfoObj.strTitle = Translation(Translations.Titles.pointsHowItWork, Translations.Titles.pointsHowItWorkDefault)
                popupInfoObj.strSubtitle = StringManager.sharedInstance.replaceString(originalString: Translation(Translations.SubTitles.haveAnotherCreditcard, Translations.SubTitles.haveAnotherCreditcardDefault), replacement: String(carNumber), String(fuelType))
                popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.haveAnotherBtnAdd, Translations.AlertButtonsKeys.haveAnotherBtnAddDefault)
                popupInfoObj.strSecondButtonTitle = Translation(Translations.AlertButtonsKeys.onboardingSkip, Translations.AlertButtonsKeys.onboardingSkipDefault)
                
                popupInfoObj.firstButtonAction = {
                    let dict = [TenParamsNames.add: "1"]
                    self.fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
                    let myScreen = nextScreen.screenName
                    ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: self.fieldsArr, screenName: myScreen, andRequestFinishedDelegate: nil)
                    
                }
                
                popupInfoObj.secondButtonAction = {
                    let dict = [TenParamsNames.add: "0"]
                    self.fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
                    let myScreen = nextScreen.screenName
                    ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: self.fieldsArr, screenName: myScreen , andRequestFinishedDelegate: nil)
                    
                }
                ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
                
            case ScreensNames.creditCard.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpCreditCardDetailsViewController.className) as? SignUpCreditCardDetailsViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    signUpVC.viewModel.strWebViewUrl = nextScreen.strWebViewUrl
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            case ScreensNames.fuelingCardPrivate.rawValue:
                print("fuelingCardPrivate")
                //                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CarInformationFcPrivateViewController.className) as? CarInformationFcPrivateViewController {
                //                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(vc, animated: true)
            //                }
            case ScreensNames.fuelingCardBusiness.rawValue:
                print("fuelingCardBusiness")
                //                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CarInformationFcPrivateViewController.className) as? CarInformationFcPrivateViewController {
                //                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(vc, animated: true)
            //                }
            case ScreensNames.extraSecurity.rawValue:
                print("extraSecurity")
                //                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CarInformationFcPrivateViewController.className) as? CarInformationFcPrivateViewController {
                //                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(vc, animated: true)
            //                }
            case ScreensNames.carInformationFcPrivateReadonly.rawValue:
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpCarDetailsViewController.className) as? SignUpCarDetailsViewController {
                    signUpVC.viewModel.screenName = nextScreen.screenName
                    signUpVC.viewModel.strLicensePlateRO = nextScreen.strLincensePlate
                    signUpVC.viewModel.strIdNumberRO = nextScreen.strIdNumber
                    signUpVC.viewModel.strCode = nextScreen.strFuelTypeCode
                    signUpVC.viewModel.readOnly = true
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
                
            case ScreensNames.carInformationFcBusinessReadonly.rawValue:
                print("carInformationFcBusinessReadonly")
                
                //TODO: send to businessreadonly
                
            case ScreensNames.completeProcess.rawValue:
                
                if ApplicationManager.sharedInstance.userAccountManager.registrationToken.isEmpty {
                    
                    let dict = [String: Any]()
                    self.fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
                    self.callUpdateNewFuelingDeviceProcessData(dictParams: dict, screenName: nextScreen.screenName, andRequestFinishedDelegate: self)
                    
                } else {
                    
                    let dict = [String: Any]()
                    self.fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
                    self.callUpdateRegistrationData(dictParams: self.fieldsArr, screenName: nextScreen.screenName, andRequestFinishedDelegate: self)
                    
                }
                
            case ScreensNames.pinCode.rawValue:
                print("pinCode")
                
            case ScreensNames.chooseCreditCard.rawValue:
                if let AddCar = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: AddNewCarViewController.className) as? AddNewCarViewController {
                    AddCar.viewModel.screenName = nextScreen.screenName
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(AddCar, animated: true)
                }
                
            default:
                print("none")
            }
            
            self.arrScreens.removeFirst()
            return true
        } else {
            if self.registrationToken.isEmpty {
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: CarManagmentViewControoler.className) as? CarManagmentViewControoler {
                    personalZone.isShowPopup = true
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
            } else {
                if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpAddAnotherCarViewController.className) as? SignUpAddAnotherCarViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            }
            self.registrationToken = ""
        }
        return false
    }
    
    func validateUserPayment(storePamentMathods: [StorePaymentMethodsItem]) {
        
        var storePamentMathods = [StorePaymentMethodsItem]()
        if !ApplicationManager.sharedInstance.userAccountManager.user.storePaymentMethods.isEmpty {
            for storePaymante in ApplicationManager.sharedInstance.userAccountManager.user.storePaymentMethods {
                if storePaymante.isActiveInStore {
                    storePamentMathods.append(storePaymante)
                }
            }
            if !storePamentMathods.isEmpty {
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: StorePaymentActiveViewController.className) as? StorePaymentActiveViewController {
                    personalZone.storePamentMathods = storePamentMathods
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
            } else {
                if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: StorePaymentViewController.className) as? StorePaymentViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                }
            }
        } else {
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: StorePaymentViewController.className) as? StorePaymentViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
            }
        }
    }
    
    //MARK: RequestFinishedProtocol
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
    
        if request.requestName == TenRequestNames.getRemovePowerCard {
            if let signUpVC = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PowerCardViewController.className) as? PowerCardViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
            }
        }
        if  request.requestName == TenRequestNames.getAddPowerCard {
            let popupInfoObj = PopupInfoObj()
            popupInfoObj.popupType = .tenGeneralPopup
            popupInfoObj.strImageName = "powerCardDone"
            popupInfoObj.strTitle = Translation(Translations.Titles.popupConnectSuccessfulPowercard, Translations.Titles.popupConnectSuccessfulPowercardDefault)
            popupInfoObj.strSubtitle = Translation(Translations.SubTitles.popupConnectSuccessfulPowercard, Translations.SubTitles.popupConnectSuccessfulPowercardDefault)
            popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.popupConnectSuccessfulPowercard, Translations.AlertButtonsKeys.popupConnectSuccessfulPowercardDefault)
            popupInfoObj.firstButtonAction = {
                if let signUpVC = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PowerCardViewController.className) as? PowerCardViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                }
            }
            ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        }
        
        if request.requestName == TenRequestNames.getStarsNewFuelingDeviceProcess {
            if let innerResponse = innerResponse as? StartNewFuelingDeviceProcessResponse {

                self.tokenNewFuilingDevice = innerResponse.token
                self.arrScreens = innerResponse.arrNextScreens
                self.updateScreensAndRegistrationToken(registrationToken: nil, screens:self.arrScreens)
            }
        }
        
        if request.requestName == TenRequestNames.getUpdateNewFuelingDeviceProcessData {
            if let innerResponse = innerResponse as? UpdateNewFuelingDeviceProcessDataResponse {
                self.arrScreens.removeAll()
                self.updateScreensAndRegistrationToken(registrationToken: nil, screens: innerResponse.arrNextScreens)
            }
        }
        
        if request.requestName == ServerUserRequests.addUser {
            
            self.user = (innerResponse as! AddUserResponse).user as! TenUser
            
            if (innerResponse as! AddUserResponse).registerWithSmsAuth {
                createSmsAuthPopup()
            } else {
                self.updateAdditionalUserInfoFromRequest(request: request)
                self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
            }
        } else if request.requestName == ServerUserRequests.loginUser {
            
            self.user = (innerResponse as! LoginUserResponse).user as! TenUser
            
            if (innerResponse as! LoginUserResponse).registerWithSmsAuth {
                createSmsAuthPopup()
            } else {
                self.updateAdditionalUserInfoFromRequest(request: request)
                self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
            }
            
        } else if request.requestName == ServerUserRequests.logout {
            self.finishLogoutUser()
            
        } else if request.requestName == ServerUserRequests.editUserInformation {
            
            self.user = (innerResponse as! EditUserInformationResponse).user as! TenUser
            updateSideMenu()
            
        } else if request.requestName == ServerUserRequests.addToFavorites {
            
            
        } else if request.requestName == ServerUserRequests.removeFromFavorites {
            
        } else if request.requestName == ServerUserRequests.getUserFavorites {
            
        } else if request.requestName == ServerLoginCalls.getSmsToken {
            
        } else if request.requestName == ServerLoginCalls.loginWithSmsToken {
            
        } else if request.requestName == ServerLoginCalls.connectSocialAccount {
            ApplicationManager.sharedInstance.userAccountManager.user = (innerResponse as! ConnectSocialAccountResponse).user as! TenUser
            
        } else if request.requestName == ServerLoginCalls.silentLogin {
            
            self.loggedInStatus = .loggedInWithEmail
            
            self.user = (innerResponse as! SilentLoginResponse).user as! TenUser
            
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
            
        } else if request.requestName == ServerUserRequests.getUserSettings {
            
            
        } else if request.requestName == ServerUserRequests.setUserSettings {
            //self.user = (innerResponse as! SetUserSettingsResponse).user
            
        } else if request.requestName == ServerUserRequests.checkSmsToken {
            self.user = (innerResponse as! CheckSmsTokenResponse).user as! TenUser
            self.updateAdditionalUserInfoFromRequest(request: request)
            
            if let checkSmsTokenResponse = innerResponse as? CheckSmsTokenResponse {
                if checkSmsTokenResponse.isUserExist {
                    self.moveToHomePage()
                } else {
                    ApplicationManager.sharedInstance.userAccountManager.moveToNextScreen()
                }
            }
            //self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
            
        } else if request.requestName == ServerUserRequests.restorePassword {
            ApplicationManager.sharedInstance.popupManager.dismissAllPopups()
        } else if request.requestName == UpdateRegistrationDataCalls.updateRegistrationData {
            if let innerResponse = innerResponse as? UpdateRegistrationDataResponse {
                self.updateScreensAndRegistrationToken(registrationToken: self.registrationToken, screens: innerResponse.arrNextScreens)
                if innerResponse.isUserExists {
                    self.registrationToken = ""
                }
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
        if request.requestName == ServerUserRequests.loginUser {
            ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment = false
            
            self.loggedInStatus = .notLoggedIn
            // i.e. from startup
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
            
        } else if request.requestName == ServerLoginCalls.silentLogin {
            self.loggedInStatus = .notLoggedIn
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
            
        } else if request.requestName == ServerUserRequests.checkSmsToken {
            self.loggedInStatus = .notLoggedIn
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
            
        } else if request.requestName == ServerUserRequests.addUser {
            self.loggedInStatus = .notLoggedIn
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
            
        }
    }
    
    func processFinished(processManager: BaseProcessManager, processFinishedStatus: ProcessFinishedStatus, processCompletion: (BaseProcessManager, ProcessFinishedStatus) -> ()) {
        
    }
    
    override func reset() {
        UserAccountManager.sharedInstance = UserAccountManager()
    }
    
    func buildJsonAndSendUpdateRegistrationDataAdd(strScreenName: String, vc: UIViewController? = nil) {
        
        let dict = [TenParamsNames.add: 1]
        
        fieldsArr.updateValue(dict, forKey: TenParamsNames.fieldsArr)
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateRegistrationData(dictParams: fieldsArr, screenName: strScreenName, andRequestFinishedDelegate: vc as? RequestFinishedProtocol)
    }
}


