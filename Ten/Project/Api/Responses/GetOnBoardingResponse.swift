//
//  GetOnBoardingResponse.swift
//  Ten
//
//  Created by inmanage on 15/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class GetOnBoardingResponse: BaseInnerResponse {
    
    var slidesArr = [SlidItem]()
    
    override func buildFromJSONDict(JSONDict: [String : Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
        
    let tempslidesArr = ParseValidator.getArrayForKey(key: "slidesArr", JSONDict: JSONDict, defaultValue: [Any]())
    self.slidesArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: tempslidesArr, innerResponse: SlidItem(), shouldReverseOrder: false) as! [SlidItem]
   
        return self
    }
}
