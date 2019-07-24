//
//  BaseViewModelDataFetchProtocol.swift
//  viewModelBase
//
//  Created by aviv frenkel on 01/08/2018.
//  Copyright © 2018 aviv frenkel. All rights reserved.
//
// BaseViewModelDataFetchProtocol is a protocol which contains all the functions related to DataFetch
// and should be implemented if the Controller got any dataFetch

import Foundation

@objc protocol BaseViewModelDataFetchProtocol : RequestFinishedProtocol {
    // completion is a function which is called upon finish
    typealias requestViewSucceeded = (_ request:BaseRequest, _ outerResponse:BaseOuterResponse, _ innerResponse:BaseInnerResponse) -> Void
    typealias requestViewFailed = (_ request:BaseRequest, _ outerResponse:BaseOuterResponse) -> Void

    
}

@objc protocol BaseViewModelDataFetchProtocolToController {
    // completion is a function which is called upon finish
    func requestViewSucceeded(_ request:BaseRequest, _ outerResponse:BaseOuterResponse, _ innerResponse:BaseInnerResponse) -> Void
    func requestViewFailed(_ request:BaseRequest, _ outerResponse:BaseOuterResponse) -> Void
    
    
}
