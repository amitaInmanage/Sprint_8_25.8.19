//
//  TenInputValidation.swift
//  Ten
//
//  Created by inmanage on 27/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TenInputValidation: UIViewController {

  static var sharedInstance = TenInputValidation()
    
    func isHebrewValidLastName(name:String) -> (Bool) {
        
        var aFullName = name
        
        // Delete spaces after the name
        aFullName = aFullName.trimmingCharacters(in: .whitespaces)
        let arrNames = aFullName.components(separatedBy: .whitespaces)
        var numberOfValidNames = 0
        for name in arrNames {
            if ApplicationManager.sharedInstance.inputValidationManager.isHebrewValidSingleName(name: name) {
                numberOfValidNames += 1
            }
        }
        return arrNames.count == numberOfValidNames
    }
}
