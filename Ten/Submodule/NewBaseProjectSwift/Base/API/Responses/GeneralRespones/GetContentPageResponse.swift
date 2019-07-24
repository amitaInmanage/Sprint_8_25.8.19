//
//  GetContentPageResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 21/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class GetContentPageResponse: BaseInnerResponse {
    
    var contentPage = ContentPage()
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.contentPage = ContentPage().buildFromJSONDict(JSONDict: JSONDict) as! ContentPage
        
        return self
    }
    
}
