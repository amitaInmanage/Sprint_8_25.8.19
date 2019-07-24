//
//  BaseFormViewControllerDelegate.swift
//  Ten
//
//  Created by shani daniel on 14/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//
//

import Foundation
import MaterialComponents.MaterialTextFields


 protocol BaseFormViewControllerDelegate : NSObjectProtocol {
    
    
    //note that the phone input is an MDCTextField which you should implement in your interface builder view Controller
    func mDCTextSetUp(mDCText: MDCTextField, withPlaceholderText Placeholder: String, withIndex index: Int ,withKeyboardType keyboardType: UIKeyboardType, withKeyType keyType: UIReturnKeyType,txtFldInputType: TextFieldInputType, errorText: String, addToolbar: Bool)
  
    func addToolBarToResponderView(responderView: Any, withAddNext addNext: Bool)
    
    func setupTxtFldControllerFont(txtFldController: CustomMDCTextInputControllerUnderline)
    
    
    //note that arrResponderViews should be implemented in your interface builder view Controller
    func moveToNextResponderView(currentResponderView: Any)
    
    func getNextResponderView(currentResponderView: Any) -> (UIView?) 
    

    
}
