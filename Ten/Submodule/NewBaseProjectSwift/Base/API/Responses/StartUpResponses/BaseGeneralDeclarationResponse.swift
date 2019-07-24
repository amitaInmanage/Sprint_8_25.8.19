//
//  BaseGeneralDeclarationResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseGeneralDeclarationResponse: BaseInnerResponse {
    
    var results = [Any]()
    var arrLanguages = [Language]()
    var arrCachedMethods = [Any]()
    var homePageImages = [Any]()
    var dictFaqs = [String: Any]()
    var strMediaURL = ""
    var arrThrowErrors = [Int]()
    var arrToMenuErrors = [Int]()
    var arrToRegistrationErrors = [Int]()
    var arrToLoginErrors = [Int]()
    var arrFAQs = [Any]()
    var strAppStoreUrl = ""
    var intServerTimeTS = 0
    var strTimeZone = ""
    var boolShowErrorID: Bool = false
    var intHomePageSlideInterval = 0
    var dictTranslations = [String: Any]()
    var intTranslationsLastUpdateTS = 0
    var intGpsTimeout = 0
    var intLoaderSpeed = 0
    var intRestartOnIdle = 0
    var intToastDuration = 0
    var strCurrentRecievedLanguage = ""
    var methodAttempts: Int = 0
    var methodTimeout = Float(0.0)
    var homePageAnimationInterval = 0
    var menuButtonAnimationDuration = 0
    var intUserImageWidth = 0
    var intUserImageHeight = 0
    var limitPrice = ""
    var dictApplicationImages = [String: Any]()
    var strWebViewFontStyle = ""
    var mediaZipFile = MediaZipFile()
    
    
    @discardableResult override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        let dictTranslationsDisk :Dictionary<String,Any> = ApplicationManager.sharedInstance.translationManager.loadTranslationsFromDisk()
        
        self.dictTranslations = ParseValidator.getDictionaryForKey(key: "translationsArr", JSONDict: JSONDict, defaultValue: dictTranslationsDisk)
        
        ApplicationManager.sharedInstance.translationManager.saveTranslationsToDisk(dictTranslation: self.dictTranslations)
        
        self.strAppStoreUrl = ParseValidator.getStringForKey(key: "app_store_url", JSONDict: JSONDict, defaultValue:"")
        
        self.intServerTimeTS = ParseValidator.getIntForKey(key: "server_time", JSONDict: JSONDict, defaultValue:
            0)
        
        ApplicationManager.sharedInstance.timeManager.intServerTimeTS = Double(self.intServerTimeTS)
        
        self.strTimeZone = ParseValidator.getStringForKey(key: "time_zone", JSONDict: JSONDict, defaultValue: "")
        
        ApplicationManager.sharedInstance.timeManager.strTimeZone = self.strTimeZone
        
        self.strMediaURL = ParseValidator.getStringForKey(key: "media_server", JSONDict: JSONDict, defaultValue: "")
        
        self.boolShowErrorID = ParseValidator.getBoolForKey(key: "show_error_id", JSONDict: JSONDict, defaultValue:false)
        
        self.intTranslationsLastUpdateTS = ParseValidator.getIntForKey(key: "translations_last_update", JSONDict: JSONDict, defaultValue: 0)
        
        self.strCurrentRecievedLanguage = ParseValidator.getStringForKey(key: "language", JSONDict: JSONDict, defaultValue: "")
        self.intHomePageSlideInterval = ParseValidator.getIntForKey(key: "home_page_slide_interval", JSONDict: JSONDict, defaultValue: 0)
        self.intRestartOnIdle = ParseValidator.getIntForKey(key: "restart_on_idle", JSONDict: JSONDict, defaultValue: 25)
        self.intUserImageWidth = ParseValidator.getIntForKey(key: "user_image_width", JSONDict: JSONDict, defaultValue: 250)
        self.intUserImageHeight = ParseValidator.getIntForKey(key: "user_image_height", JSONDict: JSONDict, defaultValue: 250)
        self.methodAttempts = ParseValidator.getIntForKey(key: "method_attempts", JSONDict: JSONDict, defaultValue: 3)
        self.methodTimeout = ParseValidator.getFloatForKey(key: "method_timeout", JSONDict: JSONDict, defaultValue: 40.0)
        self.strWebViewFontStyle = ParseValidator.getStringForKey(key: "font_iphone", JSONDict: JSONDict, defaultValue: "")
        
        // LANGUAGES
        let arrForLanguages = ParseValidator.getArrayForKey(key: "languagesArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.arrLanguages = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: arrForLanguages, innerResponse: Language(), shouldReverseOrder: false) as! [Language]
        
        
        // APPLICATION IMAGES
        let dictApplicationImages = ParseValidator.getDictionaryForKey(key: "applicationImageArr", JSONDict: JSONDict, defaultValue: [String:Any]())
        self.dictApplicationImages = ParseValidator.createDictionaryOfInnerResponsesFromJSONDict(JSONDict: dictApplicationImages, innerResponse: ApplicationImage())
        
        
        
        // Side menu and content pages - handle by SideMenuAndContentPageManager
//        let arrContentPages = ParseValidator.getArrayForKey(key: "contentArr", JSONDict: JSONDict, defaultValue: Array())
//        ApplicationManager.sharedInstance.sideMenuAndContentPageManager.arrContentPages = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: arrContentPages, innerResponse: ContentPage(), shouldReverseOrder: false) as! [ContentPage]
        
        let arrMenuItems = ParseValidator.getArrayForKey(key: "menuArr", JSONDict: JSONDict, defaultValue: [Any]())
        
        ApplicationManager.sharedInstance.sideMenuAndContentPageManager.arrAllMenuItems = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: arrMenuItems, innerResponse: BaseMenuItem(), shouldReverseOrder: false)
        
        // Errors
         self.arrThrowErrors = ParseValidator.getArrayForKey(key: "throw_errorArr", JSONDict: JSONDict, defaultValue: [Int]()) as! [Int]
        self.arrToMenuErrors = ParseValidator.getArrayForKey(key: "throw_to_menu_errorArr", JSONDict: JSONDict, defaultValue: [Int]()) as! [Int]
        self.arrToRegistrationErrors = ParseValidator.getArrayForKey(key: "throw_to_registrationArr", JSONDict: JSONDict, defaultValue: [Int]()) as! [Int]
        self.arrToLoginErrors = ParseValidator.getArrayForKey(key: "throw_to_loginArr", JSONDict: JSONDict, defaultValue: [Int]()) as! [Int]

        return self
        
    }
    
}
