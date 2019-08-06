//
//  UIView+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

enum UIViewConstans : Int {
    case bottomBorderTag = 00
}

extension UIView {
    
    func setupWithBorderColor(borderColor: UIColor?, andBorderWidth borderWidth: CGFloat?, andCornerRadius cornerRadius: CGFloat?) {
        
        if borderColor != nil {
            self.layer.borderColor = borderColor!.cgColor
        }
        
        if borderWidth != nil {
            self.layer.borderWidth = borderWidth!
        }
        
        if cornerRadius != nil {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius!
        }
        
        self.clipsToBounds = true
        
    }
    
    func setupWithBorderColor(borderColor: UIColor?, andBorderWidth borderWidth: CGFloat?, addCornerRadius: Bool) {
        
        if borderColor != nil {
            self.layer.borderColor = borderColor!.cgColor
        }
        
        if borderWidth != nil {
            self.layer.borderWidth = borderWidth!
        }
        
        if addCornerRadius {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.bounds.size.height / 4.16
        }
        
        self.clipsToBounds = true
        
    }
    
    func addTopBorderWithColor(color: UIColor, andBorderWidth borderWidth: CGFloat) {
        
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: borderWidth)
        self.addSubview(border)
        
    }
    
    func addBottomBorderWithColor(color: UIColor, andBorderWidth borderWidth: CGFloat) {
        
        let border = UIView()
        border.backgroundColor = color
        border.tag = UIViewConstans.bottomBorderTag.rawValue
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        self.addSubview(border)
        
    }
    
    func addLeftBorderWithColor(color: UIColor, andBorderWidtht borderWidth: CGFloat) {
        
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height)
        self.addSubview(border)
        
    }
    
    func addRightBorderWithColor(color: UIColor, andBorderWidtht borderWidth: CGFloat) {
        
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height)
        self.addSubview(border)
        
    }
    
    func addShadowAndCorner() {
        
        let shdowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        let shadowOffset = CGSize(width: -1, height: 1)
        
        self.layer.shadowColor = shdowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
    
    func addShadow() {
        
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        let shadowOffset = CGSize(width: -1, height: 1)
        
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 2.0
        
    }
    
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }
    
    func removeBottomBorder() {
        
        (self.subviews as NSArray).enumerateObjects({ (object, idx, stop) in
            let subVw = object as! UIView
            
            if subVw.tag == UIViewConstans.bottomBorderTag.rawValue {
                subVw .removeFromSuperview()
            }
            
        })
        
    }
    
    func setSelectedBackgroundViewWithColor(color: UIColor) -> (UIView) {
        
        let bgColorView = UIView()
        
        let colorRef = color.cgColor.copy(alpha: 0.5)
        let newColor = UIColor.init(cgColor: colorRef!)
        
        bgColorView.backgroundColor = newColor
        bgColorView.layer.masksToBounds = true
        
        return bgColorView
        
    }
    
    func setConstraintsToZero() {
        
        if let superview = self.superview {
            (superview.constraints as NSArray).enumerateObjects({ (object, idx, stop) in
                let constraint = object as! NSLayoutConstraint
                if constraint.firstItem as! NSObject == self || constraint.secondItem as! NSObject == self {
                    constraint.constant = 0
                }
                
            })
            
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.6, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
    
    func animatePulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.75
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
//    func animateFlash() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.2
//        flash.fromValue = 1
//        flash.toValue = 0.1
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        flash.repeatCount = 3
//        
//        layer.add(flash, forKey: nil)
//    }
    
    
    func animateShake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func disableShadow(color: UIColor, opacity: Float = 0.0, offSet: CGSize, radius: CGFloat = 0, scale: Bool = false) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
}
