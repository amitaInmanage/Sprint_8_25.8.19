//
//  ConstansBase.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 07/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import Foundation
import UIKit

//MARK: General Structs


struct PushNotifications {
    static let useFIRPushNotification = true
    static let usePushwooshPushNotification = true
}

struct iPhoneIOSVersion {
    
    static var IS_IOS_5_OR_LATER  = (UIDevice.current.systemVersion as NSString).floatValue >= 5
    static var IS_IOS_6_OR_LATER  = (UIDevice.current.systemVersion as NSString).floatValue >= 6
    static var IS_IOS_7_OR_LATER  = (UIDevice.current.systemVersion as NSString).floatValue >= 7
    static var IS_IOS_8_OR_LATER  = (UIDevice.current.systemVersion as NSString).floatValue >= 8
    static var IS_IOS_9_OR_LATER  = (UIDevice.current.systemVersion as NSString).floatValue >= 9
    static var IS_IOS_10_OR_LATER = (UIDevice.current.systemVersion as NSString).floatValue >= 10
    
}

struct ScreenSize {
    
    static let SCREEN_WIDTH      = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT     = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}

struct DeviceType {
    
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_WIDTH == 768.0
    static let IS_IPADPro10 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_WIDTH == 834.0
    static let IS_IPADPro12 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_WIDTH == 1024.0
    static let IS_IPHONE_XR = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0 
    }
    
}

struct AppUrlScheme {
    static let urlScheme = "iten"
    static let urlSchemeSplit = "iten://?"
}

//NARK: Server Request Structs

struct ServerStartupRequests {
    
    static let getHostUrl               = "getHostUrl"
    static let clearSeesion             = "clearSession"
    static let registerPushNotification = "registerPushNotification"
    static let setSettings              = "setSettings"
    static let validateVersion          = "validateVersion"
    static let generalDeclaration       = "generalDeclaration"
    static let getStartUpImages         = "getStartUpImages"
    static let getStartupMessage        = "getStartupMessage"
    static let getApplicationToken      = "applicationToken"
    
}

struct ServerUserRequests {
    
    static let addUser              = "addUser"
    static let editUserInformation  = "editUserInformation"
    static let editUserNotification = "editUserNotification"
    static let loginUser            = "loginUser"
    static let logout               = "logout"
    static let changePassword       = "changePassword"
    static let restorePassword      = "restorePassword"
    static let getUserFavorites     = "getUserFavorites"
    static let addToFavorites       = "addToFavorites"
    static let removeFromFavorites  = "removeFromFavorites"
    static let startRestorePassword = "startRestorePassword"
    static let getUserSettings      = "getUserSettings"
    static let setUserSettings      = "setUserSettings"
    static let checkSmsToken        = "verifySmsToken"

}

struct ServerGeneralRequests {
    
    static let errorReport     = "errorReport"
    static let getCities       = "getCities"
    static let getStreets      = "getStreets"
    static let sendContact     = "sendContact"
    static let getContentPage  = "getContentPage"
    static let addNewCard      = "addNewCard"
    static let getToken        = "getToken"
    static let getFaq          = "getFaq"
    static let getAboutUs      = "getAboutUs"
    static let setNotificationSettings = "setNotificationSettings"
}

struct ServerGeneralParams {
    
    static let pageId = "pageId"

}

struct ServerPaymentRequests {
    
    static let doPayment = "doPayment"
    
}

struct ServerLogRequests {
    
    static let bannerLog  = "bannerLog"
    static let messageLog = "messageLog"
    static let pushLog    = "pushLog"
    static let shareLog   = "shareLog"
    static let userLog    = "userLog"

}

//MARK: Params/Keys Structs

struct PersonalDetailsKeys {
    static let silentLogin     = "silentLogin"
    static let email           = "email"
    static let password        = "password"
    static let fbid            = "fbid"
    static let FBaccessToken   = "accessToken"
    static let firstName       = "firstName"
    static let lastName        = "lastName"
    static let fullName        = "fullName"
    static let phone           = "cellphone"
    static let phonePrefix     = "phonePrefix"
    static let phoneSuffix     = "phone"
    static let terms           = "terms"
    static let gender          = "gender"
    static let state           = "state"
    static let country         = "country"
    static let city            = "cityId"
    static let street          = "streetId"
    static let houseNumber     = "houseNum"
    static let apartmentNum    = "apartmentNumber"
    static let enterNumber     = "enterNumber"
    static let zipCode         = "zipCode"
    static let addressId       = "addressId"
    static let notes           = "notes"
    static let poBox           = "poBox"
    static let lastLoginWithFB = "lastLoggedInWithFacebook"
    static let newsletter      = "agreeGetAdvertisement"
    static let cellphone       = "cellphone"
    static let jobTitle        = "jobTitle"
    static let birthday        = "birthday"
    static let token           = "token"
    static let picture = "imageData"
}

struct ServerParamsGeneral {
    
    static let faqId  = "faqId"
    static let pageId = "pageId"
    
}

struct Tags {
    
    static let errorLabelTag = 102
    static let requiredFieldsErrorLabelTag = 103
    
}

struct ApisKeys {
    
    static let GANTAccountID = "UA-85981718-3"
}

struct Priority {
    static let high: Float    = 999
    static let midHigh: Float = 998
    static let low: Float     = 250
    
}


//MARK: Genearl Enums

enum UserGender: Int {
    case na = 0, male, female
}

enum LanguageDirection: Int {
    case ltr = 1, rtl
}

enum ErrorType: Int {
    case none = 0, homePage, login, register, restart
}

enum ErrorAlertImpactType: Int {
    case none = 0, disableAlertActions, disableAlert
}

enum TextValidationStatus: Int {
    case none = 0, empty, invalid, valid
}

enum ProcessType: Int {
    case none = 0, startup, login, signup, loginOrSignupFacebook, signupAddress, loginWithPhoneNumber, loginOrSignupLinkedin
}

enum AlertDisplayInViewType  {
    case alertControllerAlert, alertControllerActionSheet, alertView,alertCustomView
}

enum TwoButtonAlertType {
    case okCancel, yesOrNo
}

enum PopupType: Int {
    case none = 0, tenGeneralPopup, requestFailure, requestSuccess, general, loginOrSignup, smsAuth, restorePassword, resetPassword, secondaryGeneral, buttonSwitchColor, input, pickObligo, table, pin, changeStation, toolTips, invocingNumber, exit, identifying
}


enum BaseMenuItemType: Int {
    case none = 0, language, sendFeedback, share
}

enum SideMenuItemID: Int {
    case myCompany = -200, location,refer,communityManager, activity
}

enum DeepLinkPageStrings: String {
    
    case transactionsHistory = "transactions_history"
    case personalInformation = "personal_information"
    case fuelingDevices = "fueling_devices"
    case myClubs = "my_clubs"
    case usageInformation = "usage_information"
    case storePaymentMethods = "store_payment_methods"
    case personalArea = "personalArea"
    case stations = "stations"
    case payment = "payment"
    case sales = "sales"
    case contact = "contact"
    case logout = "logout"
    case content = "content"
    case order = "order"
    case paymentRequest = "payment_request"
}

enum DeepLinkParamStrings: String {
    case pageId = "page_id"
    case stationsId = "stations_id"
    case saleId = "sale_id"
    case orderId = "order_id"
}

// Server Calls and Params

struct ServerLoginCalls {
    static let getSmsToken     = "getSmsToken"
    static let loginWithSmsToken    = "loginWithSmsToken"
    static let connectSocialAccount = "connectSocialAccount"
    static let silentLogin          = "silentLogin"
    
}

struct ServerLoginCallsParams {
    static let type        = "type"
    static let accessToken = "accessToken"
    static let linkdein    = "linkedin"
    static let facebook    = "facebook"
    static let loginHash   = "loginHash"
    static let cellphone   = "cellphone"

    
}


struct DiskKeys {
    static let loginHash = "loginHash"
    static let pushNotification = "pushNotification"
    static let location = "location"
    static let calendar = "calendar"
    static let firstRun = "firstRun"
    
}

//MARK: General Constans
class Constans {
    
//    //Debug change to false when uploading to store (Disable logs when "false")
//    static let debugMode = false
    
    //change this false when uploading to store (Disable logs when "false")
    #if DEBUG
    static let useDevURL = true
    static let debugMode = true
    #else
    static let useDevURL = false
    static let debugMode = false
    #endif
    
   

    // URLs And SERVER Constans
    static var apiVersion = Bundle.main.infoDictionary?["APIVersion"] as! String
    static let defaultPath = String(format: "api/iphone/%@", apiVersion)
    static let hostLiveURLKey = "kHostLiveURL"
    static let hostLiveURLDefault = "https://ten.inmanage.com"
    static let hostDevURLDefault  = "https://ten.inmanage.com"

    static var baseLiveURL : String {
        if useDevURL {
            return hostDevURLDefault
        }
        if let aHostLiveURLKey = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: hostLiveURLKey) {
            return aHostLiveURLKey
        } else {
            return hostLiveURLDefault
        }
        
    }
    static let applicationSecurityToken = "inmanga_secure"
    static let lastCallToServerTimestamp = "lastCallToServerTimestamp"
    
    //General
    static let kDeviceToken = "deviceToken"
    static let kDidRegisterPushwoosh = "didRegisterPushwoosh"
    static let appWindow = UIApplication.shared.keyWindow
    static let encryptionKey = "delekinmanageten"
    static let appVersionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    //Splash constans
    static let createdByInmanage = "created by inManage"
    static let appVersionString = "App Version"

    //social
    static let instagramAppUrl = "instagram://user?username="
    static let instagramUrl = "https://www.instagram.com/"
    static let facebookAppUrl = "fb://page?id="
    static let facebookUrl = "https://www.facebook.com/"
    static let twitterAppUrl = "twitter://user?screen_name="
    static let twitterUrl = "https://twitter.com/"
    static let youtubeAppUrl = "youtube://user/"
    static let youtubeUrl = "https://youtube.com/user/"
    static let whatsappAppUrl = ""
    static let whatsappUrl = ""

}

//MARK: VC's tags

struct CarInformationClubVCTags {
    
    static let tagCarNumber = 0
}

struct RegisterNameVCTags {
    
    static let tagFirstName = 0
    static let tagLastName = 1

}

struct BusinessRefuelingCardRegistrationVCTags {
    
    static let tagBusinessNumber = 0
    static let tagCarNumber = 1
      
}

struct RegisterTenCardVCTags {
    
    static let tagCardNumber = 0
    static let tagSecretCode = 1
    
}

struct RegisterCarVCTags { 
   
    static let tagId = 0
    static let tagCardNumber = 1

}

struct LoginVCTags {
    
    static let tagPhoneTxtFld = 0
    static let tagEmail = 1
    static let tagPassword = 2
}


struct SingupVCTags {
    static let tagFirstName = 10
    static let tagLastName = 11
    static let tagPhone = 12
    static let tagEmail = 13
    static let tagPassword = 14
    static let tagRewritePassword = 15
    static let tagBirthDate = 16
}

struct ContactVCTags {
    
    static let tagFullName = 10
    static let tagPhone = 11
    static let tagEmail = 12
    static let tagSubject = 13
    static let tagMessage = 14

}

struct ResetPasswordPopupVCTags {
    static let tagnewPass = 10
    static let tagPassValidation = 11
}

//MARK: Global functions
func LogMsg(_ logMessage: String, functionName: String = #function) {
    
    if Constans.debugMode {
        print("\(functionName): \(logMessage)")
    } else {
        return
    }
    
}

