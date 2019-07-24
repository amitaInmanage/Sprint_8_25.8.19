//
//  NumberFormatter.swift
//  WelcomeInSwift
//
//  Created by inmanage on 16/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    func correctedNumberFromString(string: String) -> (NSNumber?) {
        
        self.groupingSeparator = ","
        self.decimalSeparator = "."
        
        return self.number(from: string)
        
    }
    
}
