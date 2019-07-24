//
//  BaseManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 06/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseManager: NSObject,RequestFinishedProtocol {
    
    @objc func reset() {}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
