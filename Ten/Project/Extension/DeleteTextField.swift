//
//  DeleteTextField.swift
//  Ten
//
//  Created by inmanage on 19/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol MyTextFieldDelegate {
    func textFieldDidDelete(textField: UITextField)
}

class DeleteTextField: UITextField {

    var myDelegate: MyTextFieldDelegate?
    
    override func deleteBackward() {
        myDelegate?.textFieldDidDelete(textField: self)
        super.deleteBackward()
    }
}
