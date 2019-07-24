//
//  GetHostUrlResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class GetHostUrlResponse: BaseInnerResponse {

    var strHostUrl : String!
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
          super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strHostUrl = ParseValidator.getStringForKey(key: "url", JSONDict: JSONDict, defaultValue: "")
        
        let dictColor = ParseValidator.getDictionaryForKey(key: "color", JSONDict: JSONDict, defaultValue: [String:Any]())
        let rgbColor = ParseValidator.getDictionaryForKey(key: "rgb", JSONDict: dictColor, defaultValue: [String : Any]())
        var navEnviromentColor = UIColor.red
        
        if dictColor.count > 0 {
           navEnviromentColor = UIColor.getColorFromRGBDictionary(dictRGB: rgbColor)
            
        }
        
        navEnviromentColor.saveColorInNSUserDefaultsWithKey(key: "devEnviromentColorDataKey")
        
        return self
        
    }
    
}
