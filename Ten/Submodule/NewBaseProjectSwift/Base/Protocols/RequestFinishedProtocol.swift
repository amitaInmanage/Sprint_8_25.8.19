//
//  RequestFinishedProtocol.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 06/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

@objc protocol RequestFinishedProtocol : NSObjectProtocol {
    
 @objc optional func requestSucceeded(request:BaseRequest, withOuterResponse outerResponse:BaseOuterResponse, andInnerResponse innerResponse:BaseInnerResponse)

 @objc optional func requestFailed(request:BaseRequest, withOuterResponse outerResponse:BaseOuterResponse)
    
}
