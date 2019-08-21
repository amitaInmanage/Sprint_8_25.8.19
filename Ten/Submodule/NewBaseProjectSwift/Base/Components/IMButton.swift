//
//  IMButton.swift
//  WelcomeInSwift
//
//  Created by inmanage on 15/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation
import UIKit

class IMButton: UIButton {
    
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

class AdjustableFontButton : IMButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.adjustFont()
        
    }
    
    func adjustFont() {
        
        let descriptor = self.titleLabel?.font.fontDescriptor
        
        let fontSize = descriptor?.pointSize
        
        self.titleLabel?.font = type(of: self).adjustableFontWithSize(size: fontSize!)
        //self.titleLabel?.font = self.classForCoder.adjustableFontWithSize(size: fontSize!)
        
    }
    
    static func adjustableFontWithSize(size: CGFloat) -> (UIFont) {
        
        var fontName = ""
        
        if let aFontName = self.fontName() {
            
            fontName = aFontName
            fontName = fontName.replacingOccurrences(of: ".otf", with: "")
            fontName = fontName.replacingOccurrences(of: "_", with: "-")
            
        }
        
        var font = UIFont(name: fontName, size: size)
        
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        
        return font!
    }
    
    class func fontName() -> String? {
        return "Heebo"
    }
    
    class func getFontName() -> String! {
        if let fontName = self.fontName() {
            return fontName.stringByReplacingFirstOccurrenceOfString(target: ".ttf", withString: "")
        }
        return ""
    }
}





class UltraLightButton : AdjustableFontButton { override class func fontName() -> (String?) { return kUltraLightFontName } }
class UltraLightItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kUltraLightItalicFontName } }
class LightButton : AdjustableFontButton { override class func fontName() -> (String?) { return kLightFontName } }
//class LightItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kLightItalicFontName } }
class RegularButton : AdjustableFontButton { override class func fontName() -> (String?) { return kRegularFontName } }
//class RegularItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kRegularItalicFontName } }


class MediumButton : AdjustableFontButton {

    override class func fontName() -> (String?) {
        return kMediumFontName

    }

}


class MediumItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kMediumItalicFontName } }
class SemiBoldButton : AdjustableFontButton { override class func fontName() -> (String?) { return kSemiBoldFontName } }
//class SemiBoldItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kSemiBoldItalicFontName } }
class BoldButton : AdjustableFontButton { override class func fontName() -> (String?) { return kBoldFontName } }
//class BoldItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kBoldItalicFontName } }
class ExtraBoldButton : AdjustableFontButton { override class func fontName() -> (String?) { return kExtraBoldFontName } }
class ExtraBoldItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kExtraBoldItalicFontName } }
class HeavyButton : AdjustableFontButton { override class func fontName() -> (String?) { return kHeavyFontName } }
class HeavyItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kHeavyItalicFontName } }
class BlackButton : AdjustableFontButton { override class func fontName() -> (String?) { return kBlackFontName } }
class BlackItalicButton : AdjustableFontButton { override class func fontName() -> (String?) { return kBlackItalicFontName } }


