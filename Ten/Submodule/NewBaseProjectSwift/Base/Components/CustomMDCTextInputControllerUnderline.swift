//
//  CustomMDCTextInputControllerUnderline.swift
//  Ten
//
//  Created by Shani on 13/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class CustomMDCTextInputControllerUnderline: MDCTextInputControllerUnderline {

    var textFieldInputType : TextFieldInputType = .none {
        
        didSet {
            switch textFieldInputType {
                
            case .mobilePhoneNumberPrefix:
                self.maxCharacters = 3
                
            case .mobilePhoneNumberSuffix:
                self.maxCharacters = 10 //7
                
            default:
                break
                
            }
        }
    }
    
    var maxCharacters : Int = Int(INT_MAX)
    var textValidationStatus : TextValidationStatus = .none
    var strError = ""

}
