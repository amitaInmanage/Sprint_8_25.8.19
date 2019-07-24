//
//  RemoveFromFavoritesResponse.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class RemoveFromFavoritesResponse: BaseInnerResponse {
    
    var strFavoriteId = ""
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
        self.strFavoriteId = ParseValidator.getStringForKey(key: "favorite_id", JSONDict: JSONDict, defaultValue: "")
        
        return self
    }
    
}
