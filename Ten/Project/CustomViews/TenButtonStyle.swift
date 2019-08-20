//
//  TenButtonStyle.swift
//  Ten
//
//  Created by shani daniel on 03/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import Foundation

import UIKit

class TenButtonStyle: IMButton {
    
    let tenButtonColor = UIColor.getApplicationTenButtonColor().cgColor
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
        
        self.layer.cornerRadius = self.frame.size.height / 4.16
        self.layer.backgroundColor = self.tenButtonColor
        self.tintColor = .white
    }
    
    func setBoldToTitleLabel() {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel?.font = UIFont.init(name: "Heebo-Medium", size: 18)
    }
    
    func Enabled() {
        self.isEnabled = true
        self.alpha = 1
    }
    
    func Disabled() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func setWhiteBackground() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.getApplicationThemeColor().cgColor
        self.setTitleColor(UIColor.getApplicationThemeColor(), for: .normal)
    }
    
    func setClearBackground() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.getApplicationThemeColor().cgColor
        self.setTitleColor(UIColor.getApplicationThemeColor(), for: .normal)
    }
    
    func setReverseColor() {
        self.layer.borderColor = self.tenButtonColor
        self.layer.borderWidth = 1
        self.setReverseColor(textColor: .white, borderColor: self.tenButtonColor)
    }
    
    func setReverseColor(textColor: UIColor, borderColor: CGColor = UIColor.getApplicationTenButtonColor().cgColor) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        self.layer.backgroundColor = self.tenButtonColor
        self.setTitleColor(textColor, for: .normal)
    }
    
    func setBtnEnable(enable: Bool) {
        self.isUserInteractionEnabled = enable
        self.alpha = enable ? 1.0 : 0.3
    }
    
}


