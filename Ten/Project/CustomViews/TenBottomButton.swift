//
//  TenBottomButton.swift
//  Ten
//
//  Created by inmanage on 27/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TenBottomButton: IMButton {

    let tenButtonColor = UIColor.getApplicationTenButtonColor().cgColor
    
    func setReverseColor(textColor: UIColor, borderColor: CGColor = UIColor.getApplicationTenButtonColor().cgColor) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        self.layer.backgroundColor = self.tenButtonColor
        self.setTitleColor(textColor, for: .normal)
    }
}
