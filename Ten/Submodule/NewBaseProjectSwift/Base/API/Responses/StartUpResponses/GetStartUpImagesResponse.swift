//
//  GetStartUpImagesResponse.swift
//  
//
//  Created by Idan Dreispiel on 23/02/2017.
//
//

import UIKit

class GetStartUpImagesResponse: BaseInnerResponse {

    var imagesDict = [String:Any]()
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
    
        /*
        for key in JSONDict.keys {
            
            let dict = ParseValidator.getDictionaryForKey(key: key, JSONDict: JSONDict, defaultValue: [String:Any]())
            
//            let getStartUpImage = GetStartUpImagesRequest()
            
            
            
        }
 */
        
        return self
        
    }
    
}
