//
//  StorePaymentActiveViewModel.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StorePaymentActiveViewModel: BaseViewModel {
    
    
    var type = 0
    var id = 0
    
    
    func buildJsonAndSendGetTransactionsHistory(vc: UIViewController?) {
        
        let dict = [TenParamsNames.type: self.type, TenParamsNames.id: self.id]
        
        ApplicationManager.sharedInstance.userAccountManager.callRemoveStorePaymentMethod(dictParams: dict, requestFinishedDelegate: vc as! RequestFinishedProtocol)
        
    }
}
