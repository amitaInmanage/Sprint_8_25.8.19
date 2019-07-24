//
//  NSObject+IMExtension.swift
//  WelcomeInSwift
//
//  Created by inmanage on 30/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
