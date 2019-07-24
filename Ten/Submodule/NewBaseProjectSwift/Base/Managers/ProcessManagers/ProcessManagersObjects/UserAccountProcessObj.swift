//
//  UserAccountProcessObj.swift
//  WelcomeInSwift
//
//  Created by inmanage on 12/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation
import AdSupport
enum LoginOrSignupAttemptType {
    case none, loginWithEmail, loginWithFacebook, loginAny, signupWithEmail, signupWithFacebook, signupAny
}

class UserAccountProcessObj: BaseProcessObj {
    
    var isSilentRequest = false
    var dontShowAlertMessage = false
    var loginOrSignupAttemptType: LoginOrSignupAttemptType = .none
    var pushLoginAndSignupTabVC = false
    var animate = false
    var encryptEmailAndPassword = false
    var terms = false
    var newsletter = false
    var advertisement = false
    var isBase64UserImage = false
    var showTagsTour = false
    
    
    // Login - Email
    var strEmail: String?
    var strPassword: String?
    
    // Login - Facebook
    var strFBId: String?
    var strFBAccessToken: String?
    var strUrl:String?
    
    // Signup - Personal details
    var strFirstName: String?
    var strLastName: String?
    var strMobilePhoneNumber: String?
    var strMobilePhoneNumberPrefix: String?
    var strMobilePhoneNumberSuffix: String?
    var strPicture: String?
    var birthdayTS: Double?
    
    // Signup - Address
    var strAddressId: String?
    var strStateName: String?
    var strCountryName: String?
    var strCityName: String?
    var strStreetName: String?
    var strStreetNumber: String?
    var strApartmentNumber: String?
    var strEntrance: String?
    var strZipCode: String?
    var strNote: String?
    var strPoBox: String?
    var urlString: URL?
    var strCellphone: String?
    var strJobTitle: String?
    var strResetPassToken: String?
    
    
    //MARK: General Functions
    
    func createRequestDictParamsFromProperties() -> ([String:Any]) {
        
        var requestParamsDict = [String:Any]()
        
        if let deviceToken = ApplicationManager.sharedInstance.keychainManager.retrieveStringFromKeychain(key: Constans.kDeviceToken) {
            requestParamsDict.updateValue(deviceToken, forKey: Constans.kDeviceToken)
        }
        
        if let vendor = UIDevice.current.identifierForVendor {
            requestParamsDict.updateValue(vendor.uuidString, forKey: "udid")
        }
        
        requestParamsDict.updateValue(ApplicationManager.sharedInstance.requestManager.strApplicationToken, forKey: "applicationToken")
        
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        
        if idfa.count > 0 {
            requestParamsDict.updateValue(idfa, forKey: "idfa")
        }
        
        
        if self.isSilentRequest {
            requestParamsDict.updateValue("1", forKey: PersonalDetailsKeys.silentLogin)
        }
        
        if var email = self.strEmail {
            
            if self.encryptEmailAndPassword {
                email = ApplicationManager.sharedInstance.stringManager.encryptedStringForString(str: email)
            }
            
            requestParamsDict.updateValue(email, forKey: PersonalDetailsKeys.email)
            
        }
        
        if var password = self.strPassword {
            
            if self.encryptEmailAndPassword {
                password = ApplicationManager.sharedInstance.stringManager.encryptedStringForString(str: password)
            }
            
            requestParamsDict.updateValue(password, forKey: PersonalDetailsKeys.password)
            
        }
        
        if let token = self.strResetPassToken {
            requestParamsDict.updateValue(token, forKey: PersonalDetailsKeys.token)
        }
        
        if let fbid = self.strFBId {
            requestParamsDict.updateValue(fbid, forKey: PersonalDetailsKeys.fbid)
        }
        
        if let accessToken = self.strFBAccessToken {
            requestParamsDict.updateValue(accessToken, forKey: PersonalDetailsKeys.FBaccessToken)
        }
        
        if let firstName = self.strFirstName {
            requestParamsDict.updateValue(firstName, forKey: PersonalDetailsKeys.firstName)
        }
        
        if let lastName = self.strLastName {
            requestParamsDict.updateValue(lastName, forKey: PersonalDetailsKeys.lastName)
        }
        
        if let mobilePhoneNumber = self.strMobilePhoneNumber {
            requestParamsDict.updateValue(mobilePhoneNumber, forKey: PersonalDetailsKeys.phone)
        }
        
        if let phoneNumberPrefix = self.strMobilePhoneNumberPrefix {
            requestParamsDict.updateValue(phoneNumberPrefix, forKey: PersonalDetailsKeys.phonePrefix)
        }
        
        if let phoneNumberSuffix = self.strMobilePhoneNumberSuffix {
            requestParamsDict.updateValue(phoneNumberSuffix, forKey: PersonalDetailsKeys.phoneSuffix)
        }
        
        if let stateName = self.strStateName {
            requestParamsDict.updateValue(stateName, forKey: PersonalDetailsKeys.state)
        }
        
        if let countryName = self.strCountryName {
            requestParamsDict.updateValue(countryName, forKey: PersonalDetailsKeys.country)
        }
        
        if let cityName = self.strCityName {
            requestParamsDict.updateValue(cityName, forKey: PersonalDetailsKeys.city)
        }
        
        if let streetName = self.strStreetName {
            requestParamsDict.updateValue(streetName, forKey: PersonalDetailsKeys.street)
        }
        
        if let streetNumber = self.strStreetNumber {
            requestParamsDict.updateValue(streetNumber, forKey: PersonalDetailsKeys.houseNumber)
        }
        
        if let appNumber = self.strApartmentNumber {
            requestParamsDict.updateValue(appNumber, forKey: PersonalDetailsKeys.apartmentNum)
        }
        
        if let entrance = self.strEntrance {
            requestParamsDict.updateValue(entrance, forKey: PersonalDetailsKeys.enterNumber)
        }
        
        if let zipCode = self.strZipCode {
            requestParamsDict.updateValue(zipCode, forKey: PersonalDetailsKeys.zipCode)
        }
        
        if let addressID = self.strAddressId {
            requestParamsDict.updateValue(addressID, forKey: PersonalDetailsKeys.addressId)
        }
        
        if let notes = self.strNote {
            requestParamsDict.updateValue(notes, forKey: PersonalDetailsKeys.notes)
        }
        
        if let poBox = self.strPoBox {
            requestParamsDict.updateValue(poBox, forKey: PersonalDetailsKeys.poBox)
        }
        
        if let aCellphone = strCellphone {
            requestParamsDict.updateValue(aCellphone, forKey: PersonalDetailsKeys.cellphone)
        }
        
        if let aJobTitle = strJobTitle {
            requestParamsDict.updateValue(aJobTitle, forKey: PersonalDetailsKeys.jobTitle)
        }
        
        if let aBirthday = birthdayTS {
            requestParamsDict.updateValue(aBirthday, forKey: PersonalDetailsKeys.birthday)
            
        }
        if let aPicture = strPicture {
            requestParamsDict.updateValue(aPicture, forKey: PersonalDetailsKeys.picture)
            
        }
        if self.loginOrSignupAttemptType == .signupWithEmail || self.loginOrSignupAttemptType == .signupWithFacebook {
            requestParamsDict.updateValue(NSNumber(value: self.terms), forKey: PersonalDetailsKeys.terms)
            
        }
        if ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn {
            if self.newsletter != ApplicationManager.sharedInstance.userAccountManager.user.newsletterAvailable {
                requestParamsDict.updateValue(NSNumber(value: self.newsletter), forKey: PersonalDetailsKeys.newsletter)
            } else {
                requestParamsDict.updateValue(NSNumber(value: self.newsletter), forKey: PersonalDetailsKeys.newsletter)
            }
        }
        return requestParamsDict
        
    }
    
    
    
    
}
