//
//  TransactionsHistoryViewModel.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TransactionsHistoryViewModel: BaseViewModel {
    
    var type = 0
    var currentPage = 0

    
    func buildJsonAndSendGetTransactionsHistory(vc: UIViewController?) {
        
        let dict = [TenParamsNames.type: self.type, TenParamsNames.page: self.currentPage]
        
        ApplicationManager.sharedInstance.userAccountManager.callGetTransactionsHistory(dictParams: dict, requestFinishedDelegate: vc as! RequestFinishedProtocol)
    }
}
