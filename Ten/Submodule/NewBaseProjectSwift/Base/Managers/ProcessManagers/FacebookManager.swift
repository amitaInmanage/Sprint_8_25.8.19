//
//  FacebookManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//


import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import MBProgressHUD

struct FacebookPaths {
    static let profile = "fb://profile/"
}

class FacebookManager: BaseProcessManager {
    
    override init(){
        // init all properties
        super.init()
        
    }
    
    static var sharedInstance = FacebookManager()
    
    override func startProcess(processType: ProcessType, processObj:BaseProcessObj?, processFinishedDelegate: ProcessFinishedProtocol?, processCompletion:@escaping ProcessCompletion ){
        
        super.startProcess(processType: processType, processObj: processObj, processFinishedDelegate: processFinishedDelegate
            , processCompletion: processCompletion)
        
        if processType == .loginOrSignupFacebook {
            self.facebookLogin()
            //self.loginFacebookAndGetAccessToken()
        }
        
    }
    
    private func facebookLogin() {
        
        let fbLoginManager = FBSDKLoginManager()
        
        //logout - if user change his facebook user (from user x to user y) in the fb app
        if FBSDKAccessToken.current() != nil{
            fbLoginManager.logOut()
        }
        
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email","user_birthday", "user_friends"], from: nil) { (result, error) in
            if error != nil {
                LogMsg("Facebook logInWithReadPermissions process error")
            }
            else if (result?.isCancelled)! {
                LogMsg("Facebook logInWithReadPermissions cancelled")
            } else {
                
                LogMsg("Facebook logInWithReadPermissions succeeded")
                
                if UIApplication.shared.keyWindow != nil {
                    
                    MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
                }
                
                if let aAccessToken = FBSDKAccessToken.current() {
                    
                    let userAccountProcessObj = UserAccountProcessObj()
                    
                    userAccountProcessObj.isSilentRequest = false;
                    userAccountProcessObj.dontShowAlertMessage = true;
                    userAccountProcessObj.strFBId = aAccessToken.userID;
                    userAccountProcessObj.strFBAccessToken = aAccessToken.tokenString;
                    
                    userAccountProcessObj.loginOrSignupAttemptType = .loginWithFacebook;
                    
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, first_name, last_name, email, picture"]).start(completionHandler: { (connection, result, error) in
                        
                        if error == nil {
                            
                            if let data = result as? [String:Any] {
                                
                                userAccountProcessObj.strFBId =  ParseValidator.getStringForKey(key: "id", JSONDict: data, defaultValue: "")
                                userAccountProcessObj.strFirstName =  ParseValidator.getStringForKey(key: "first_name", JSONDict: data, defaultValue: "")
                                userAccountProcessObj.strLastName =  ParseValidator.getStringForKey(key: "last_name", JSONDict: data, defaultValue: "")
                                userAccountProcessObj.strEmail =  ParseValidator.getStringForKey(key: "email", JSONDict: data, defaultValue: "")
                                
                                
                                if let fbId = userAccountProcessObj.strFBId, (userAccountProcessObj.strFBId != nil) {
                                    
                                    let strPictureUrl = "https://graph.facebook.com/" + fbId + "/picture?type=large"
                                    
                                    userAccountProcessObj.strPicture = strPictureUrl
                                    userAccountProcessObj.isBase64UserImage = false
                                    
                                }
                                
                                userAccountProcessObj.encryptEmailAndPassword = true;
                                
                                MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
                                
                                ApplicationManager.sharedInstance.userAccountManager.callLoginUserWithUserAccountProcessObj(userAccountProcessObj: userAccountProcessObj, andRequestFinishedDelegate: nil)
                            }
                            
                        } else {
                            
                            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
                            
                        }
                        
                    })
                    
                }
                
            }
        }
    }
    
    func loginFacebookAndGetAccessToken()  {
        
        let fbLoginManager = FBSDKLoginManager()
        
        //,"user_work_history‎" needed review from facebook
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email","user_birthday", "user_friends"], from: nil) { (result, error) in
            if error != nil {
                LogMsg("Facebook logInWithReadPermissions process error")
                self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
                
            }
            else if (result?.isCancelled)! {
                LogMsg("Facebook logInWithReadPermissions cancelled")
                self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
                
            } else {
                
                LogMsg("Facebook logInWithReadPermissions succeeded")
                
                let accessToken = FBSDKAccessToken.current()
                
                if let aAccessToken = accessToken {
                    
                    let dictParams: [String: Any] = [ServerLoginCallsParams.type: ServerLoginCallsParams.facebook, ServerLoginCallsParams.accessToken: aAccessToken.tokenString]
                    
                    ApplicationManager.sharedInstance.userAccountManager.callConnectSocialAccount(dictParams: dictParams, andRequestFinishedDelegate: self)
                    
                }
                
                
            }
        }
        
    }
    
    func openFacebookProfile(contact: ContactInformation) {
        let innerLinkFacebook = FacebookPaths.profile + contact.strSocialID
        
        if let urlFullPath = URL(string: innerLinkFacebook) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(urlFullPath, options: [:],completionHandler: { (success) in
                    
                    if !success {
                        
                        if let siteURL = URL(string: contact.strContent) {
                            UIApplication.shared.open(siteURL, options: [:], completionHandler: nil)
                        }
                        
                    }
                    
                })
                
            } else {
                let open = UIApplication.shared.openURL(urlFullPath)
                
                if !open {
                    
                    if let siteURL = URL(string: contact.strContent) {
                        UIApplication.shared.openURL(siteURL)
                    }
                }
                
            }
        }
        
        
    }
    
    typealias success = (_ : Bool) -> ()
    
    func facebookLoginWithReadPermissions(arrReadPermissions: [String], callBack: @escaping success) {
        
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: arrReadPermissions, from: nil) { (result, error) in
            if error != nil {
                LogMsg("Facebook logInWithReadPermissions process error")
                callBack(false)
            }
            else if (result?.isCancelled)! {
                LogMsg("Facebook logInWithReadPermissions cancelled")
                callBack(false)
            } else {
                
                LogMsg("Facebook logInWithReadPermissions succeeded")
                callBack(true)
                
            }
        }
    }
    
    //MARK: - RequestFinishDelegate
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == ServerLoginCalls.connectSocialAccount {
            ApplicationManager.sharedInstance.userAccountManager.user = (innerResponse as! ConnectSocialAccountResponse).user as! TenUser
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusSuccess)
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        if request.requestName == ServerLoginCalls.connectSocialAccount {
            self.finishProcessWithStatus(processFinishedStatus: .ProcessFinishedStatusFailure)
        }
    }
    
    
    override func reset() {
        FacebookManager.sharedInstance = FacebookManager()
    }
    
}
