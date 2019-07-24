//
//  BaseUser.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 20/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseUser: BaseInnerResponse {
    
    
    // Personal info
    var strFirstName = ""
    var strLastName = ""
    var strFullName = ""
    var strPhoneNumberPrefix = ""
    var strPhoneNumberSuffix = ""
    var strPhoneNumber = ""
    var strEmail = ""
    
    // Address
    var strCountryName = ""
    var strStateName = ""
    var strCityName = ""
    var strStreetName = ""
    var strStreetNumber = ""
    var strApartmentNumber = ""
    var strZipCode = ""
    
    var intRegisterTS = 0
    var intLastLoginTS = 0
    
    // Developer options
    var showCallToasts = false
    //didnt work...
//    var _showDeveloperOptions: Bool = false
//    var showDeveloperOptions: Bool {
//        get {
//            if _showDeveloperOptions || Constans.debugMode {
//                return true
//            }
//            return false
//        }
//        set {
//            _showDeveloperOptions = newValue
//            self.showDeveloperOptions = newValue
//        }
//    }
    
    override var showDeveloperOptions: Bool {
        get {
            if super.showDeveloperOptions || Constans.debugMode {
                super.showDeveloperOptions = true
                return super.showDeveloperOptions
            }
            super.showDeveloperOptions = false
            return super.showDeveloperOptions
        }
        set {
            super.showDeveloperOptions = newValue
        }
    }
    
    var showSendCallLogOption = false
    
    var strSecondEmail = ""
    var strGender = ""
    var gender: UserGender = .na
    var strPicture = ""
    var strBirthday = ""
    
    var strFullAddress = ""
    
    var strFBAccessToken = ""
    var strFBId = ""
    var isFacebookUser = false

    var isBase64UserImage = false
    
    var strHouseNumber = ""
    var streetId = 0
    var cityId = 0
    
    var notificationOptionsDict = [String: Any]()
    
    var birthdayTs: TimeInterval!
    
    @discardableResult override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let intUserId = ParseValidator.getIntForKey(key: "user_id", JSONDict: JSONDict, defaultValue: 0)
        
        if intUserId > 0 {
            self.numID = intUserId
        }
        
        self.strGender = ParseValidator.getStringForKey(key: "gender", JSONDict: JSONDict, defaultValue: "")
        self.strFirstName = ParseValidator.getStringForKey(key: "first_name", JSONDict: JSONDict, defaultValue: "")
        self.strLastName = ParseValidator.getStringForKey(key: "last_name", JSONDict: JSONDict, defaultValue: "")
        self.strFullName = "\(self.strFirstName) \(self.strLastName)"
        
        if !self.strFullName.isEmpty {
            let upperCaseFullName = self.strFullName.uppercased()
            self.strFullName = upperCaseFullName
            
        }
        
        self.isFacebookUser = ParseValidator.getBoolForKey(key: "is_facebook_user", JSONDict: JSONDict, defaultValue: false)
        
        self.strPhoneNumberPrefix = ParseValidator.getStringForKey(key: "phone_prefix", JSONDict: JSONDict, defaultValue: "")
        self.strPhoneNumberSuffix = ParseValidator.getStringForKey(key: "phone", JSONDict: JSONDict, defaultValue: "")
        self.strPhoneNumber = ParseValidator.getStringForKey(key: "cell_phone", JSONDict: JSONDict, defaultValue: "")
        
        if self.strPhoneNumber.isEmpty {
            self.strPhoneNumber = "\(self.strPhoneNumberPrefix)\(self.strPhoneNumberSuffix)"
        }
        
        self.strEmail = ParseValidator.getStringForKey(key: "email", JSONDict: JSONDict, defaultValue: "")
        self.strCountryName = ParseValidator.getStringForKey(key: "country", JSONDict: JSONDict, defaultValue: "")
        self.strStateName = ParseValidator.getStringForKey(key: "state", JSONDict: JSONDict, defaultValue: "")
        self.strCityName = ParseValidator.getStringForKey(key: "city", JSONDict: JSONDict, defaultValue: "")
        self.strStreetName = ParseValidator.getStringForKey(key: "street", JSONDict: JSONDict, defaultValue: "")
        self.strStreetNumber = ParseValidator.getStringForKey(key: "street_num", JSONDict: JSONDict, defaultValue: "")
        self.strApartmentNumber = ParseValidator.getStringForKey(key: "apartment", JSONDict: JSONDict, defaultValue: "")
        self.strZipCode = ParseValidator.getStringForKey(key: "zip_code", JSONDict: JSONDict, defaultValue: "")
        self.strFullAddress = ParseValidator.getStringForKey(key: "full_address", JSONDict: JSONDict, defaultValue: "")
        self.strHouseNumber = ParseValidator.getStringForKey(key: "house_number", JSONDict: JSONDict, defaultValue: "")
        self.streetId = ParseValidator.getIntForKey(key: "street_id", JSONDict: JSONDict, defaultValue: 0)
        self.cityId = ParseValidator.getIntForKey(key: "city_id", JSONDict: JSONDict, defaultValue: 0)
        
        
        self.intRegisterTS = ParseValidator.getIntForKey(key: "register_ts", JSONDict: JSONDict, defaultValue: 0)
        self.intLastLoginTS = ParseValidator.getIntForKey(key: "last_login", JSONDict: JSONDict, defaultValue: 0)
        
        self.strSecondEmail = ParseValidator.getStringForKey(key: "second_mail", JSONDict: JSONDict, defaultValue: "")
        
        if self.strGender == "1" {
            self.gender = .male
        } else if self.strGender == "2" {
            self.gender = .female
        }
        
        self.strPicture = ParseValidator.getStringForKey(key: "picture", JSONDict: JSONDict, defaultValue: "")
        self.strBirthday = ParseValidator.getStringForKey(key: "birthday", JSONDict: JSONDict, defaultValue: "")
        
        self.isBase64UserImage = ParseValidator.getBoolForKey(key: "is_base64_image", JSONDict: JSONDict, defaultValue: false)
        
        self.showCallToasts = ParseValidator.getBoolForKey(key: "show_toast", JSONDict: JSONDict, defaultValue: false)
        self.showDeveloperOptions = ParseValidator.getBoolForKey(key: "development_enviroment", JSONDict: JSONDict, defaultValue: false)
        self.showSendCallLogOption = ParseValidator.getBoolForKey(key: "show_option_to_send_call_log", JSONDict: JSONDict, defaultValue: false)
        
        ApplicationManager.sharedInstance.debugAndDevEnviromentManager.strDevEnviromentUrl = ParseValidator.getStringForKey(key: "development_enviroment_url", JSONDict: JSONDict, defaultValue: "")
        
        if ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment && !ApplicationManager.sharedInstance.debugAndDevEnviromentManager.canAppBeInDevEnviromentWithShowDeveloperOptions(showDeveloperOptions: self.showDeveloperOptions) {
            ApplicationManager.sharedInstance.debugAndDevEnviromentManager.isAppInDevEnviroment = false
            
        }
        
        self.notificationOptionsDict = ParseValidator.getDictionaryForKey(key: "notification_optionsArr", JSONDict: JSONDict, defaultValue: [String :Any]())
        
        self.birthdayTs = ParseValidator.getDoubleForKey(key: "birthday_ts", JSONDict: JSONDict, defaultValue: 0)
        
//        let arrTempAddress = ParseValidator.getArrayForKey(key: "addressArr", JSONDict: JSONDict, defaultValue: Array())
        
        
        return self
        
    }
    
    
    
    
    
}
