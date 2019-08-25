//
//  Button.swift
//  Ten
//
//  Created by Amit on 21/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation

class Button: UIButton {
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    func initialize() {
        self.titleLabel?.minimumScaleFactor = 0.5
    }
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading(strStopTitle: String?) {
        
        if let aStrStopTitle = strStopTitle {
            if !aStrStopTitle.isEmpty {
                self.setTitle(strStopTitle, for: .normal)
            }
        } else {
            
            self.setTitle(originalButtonText, for: .normal)
        }
        
        activityIndicator.stopAnimating()
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.lightGray
        return activityIndicator
    }
    
    func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    func addUnderline(title: String? = nil) {
        var text = ""
        
        if let title = title {
            text = title
        } else {
            text =  self.titleLabel?.text ?? ""
        }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func designbtnOpenCamera() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        let color = UIColor.getApplicationIMLabelColor()
        self.layer.borderColor = color.cgColor
    }
    
    private func centerActivityIndicatorInButton() {
        //        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        //        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
        
        
        //if let aLabel = self.titleLabel {
        let trallingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: activityIndicator, attribute: .leading, multiplier: 1.0, constant: 0)
        self.addConstraint(trallingConstraint)
        //}
        
    }
}

class MediumBtn: Button {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.titleLabel?.font = UIFont.init(name: "Heebo-Medium", size: 16)
        self.setTitleColor(UIColor.getApplicationTextColor(), for: .normal)
        self.tintColor = UIColor.getApplicationTextColor()
    }
}

class RegularBtn: Button {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.titleLabel?.font = UIFont.init(name: "Heebo-Regular", size: 16)
        self.setTitleColor(UIColor.getApplicationTextColor(), for: .normal)
        self.tintColor = UIColor.getApplicationTextColor()
    }
}

class SmallBtn: Button {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.titleLabel?.font = UIFont.init(name: "Heebo-Regular", size: 14)
        self.setTitleColor(UIColor.getApplicationTextColor(), for: .normal)
        self.tintColor = UIColor.getApplicationTextColor()
    }
}
