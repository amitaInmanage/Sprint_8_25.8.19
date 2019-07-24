//
//  SetSettingsRequest.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import AdSupport
class SetSettingsRequest: BaseRequest {
    
    static func createInitialDictParams() -> ([String:Any]) {
        
        var initialDictParams = [String:Any]()
        
        var strResolution = ""
        
//        let screenScale = UIScreen.main.scale
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            strResolution = "1x"
        } else if DeviceType.IS_IPHONE_5 {
            strResolution = "1x"
        } else if DeviceType.IS_IPHONE_6 {
            strResolution = "2x"
        } else if DeviceType.IS_IPHONE_6P {
            strResolution = "3x"
        } else if DeviceType.IS_IPHONE_X {
            strResolution = "3xX"
        } else if DeviceType.IS_IPAD {
            strResolution = "ipad"
        } else if DeviceType.IS_IPADPro10 {
            strResolution = "ipadPro_10"
        } else if DeviceType.IS_IPADPro12 {
            strResolution = "ipadPro_12"
        }
        
//        if screenScale == 1 {
//            strResolution = "1x"
//        } else if screenScale == 2 {
//            strResolution = "2x"
//        } else {
//            if DeviceType.IS_IPHONE_X {
//                strResolution = "3xX"
//            } else {
//                strResolution = "3x"
//            }
//        }
        
        initialDictParams.updateValue(strResolution, forKey: "resolution")
        initialDictParams.updateValue("he", forKey: "lang")
        initialDictParams.updateValue(UIDevice.current.systemVersion, forKey: "OS_Version")
        
        if let tempInfoDictionary = Bundle.main.infoDictionary {
            if let strAppVersion = tempInfoDictionary["CFBundleShortVersionString"] as? String {
                initialDictParams.updateValue(strAppVersion, forKey: "application_version")
            }
        }
        
        if let vendor = UIDevice.current.identifierForVendor {
            initialDictParams.updateValue(vendor.uuidString, forKey: "udid")
        }
        
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        
        if !idfa.isEmpty {
            initialDictParams.updateValue(idfa, forKey: "idfa")
        }
        
        return initialDictParams
    }
    
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        
        let response = SetSettingsResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
        
    }
    
    override var requestName: String {
        get {
            return ServerStartupRequests.setSettings
        }
    }
    
}
