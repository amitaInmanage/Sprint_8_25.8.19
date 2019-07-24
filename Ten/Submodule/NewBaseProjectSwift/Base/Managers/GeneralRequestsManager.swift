//
//  GeneralRequestsManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class GeneralRequestsManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = GeneralRequestsManager()

    override func reset() {
        GeneralRequestsManager.sharedInstance = GeneralRequestsManager()
    }
    
}
