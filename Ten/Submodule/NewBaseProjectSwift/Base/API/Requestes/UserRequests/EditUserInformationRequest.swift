//
//  EditUserInformationRequest.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class EditUserInformationRequest: BaseRequest {
    
    override func createOuterResponseFromJSONDict(JSONDict: [String: Any]!) -> BaseOuterResponse? {
        let response = EditUserInformationResponse()
        
        return BaseOuterResponse.initFromJSONDict(JSONDict: JSONDict, withInnerResponse: response)
    }
    
    override var requestName: String {
        get {
            return ServerUserRequests.editUserInformation
        }
    }
    
}
