//
//  IMTextView.swift
//  WelcomeInSwift
//
//  Created by inmanage on 15/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

let kTextViewDefaultHorizontalInset = 3
let kTextViewDefaultVerticalInset = 5

class IMTextView: UITextView {

    var textFieldInputType : TextFieldInputType = .none
    var textValidationStatus : TextValidationStatus = .none
    
    // Used to limit allowed input characters (i.e. for phone prefix - limit allowed input chars to 3)
    var maxCharacters : Int = Int(INT_MAX)
    
    // Hides blinking cursor - used mainly when a UIPickerView is the textField's input accessory (instead of the regular keyboard)
    var hideCaret = false
    
    var rightInset : CGFloat = 8
    var leftInset : CGFloat = CGFloat(kTextViewDefaultHorizontalInset)
    var topAndBottomInset : CGFloat = CGFloat(kTextViewDefaultVerticalInset)
    
    var strError : String?
    
    var indexPath = IndexPath()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    
    func initialize() {
        self.maxCharacters = Int(INT_MAX)
        self.leftInset = 8
        self.rightInset = 0
        
        // Just because this app uses scaling (i.e launch images) and textField have a border
        self.textContainerInset = UIEdgeInsetsMake(self.topAndBottomInset , self.leftInset, self.topAndBottomInset , self.rightInset)
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        
    }
    
}

class AdjustableFontTextView : IMTextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.adjustFont()
        
    }
    
    override public var text: String? {
        didSet {
            if let text = text {
                super.text = text
                self.adjustFont()
            } else {
                super.text = ""
            }
        }
    }
    
    override public var attributedText: NSAttributedString? {
        didSet {
            
            if let attributedText = attributedText {
                
                let attString = NSMutableAttributedString(attributedString: attributedText)
                
                let descriptor = self.font?.fontDescriptor
                
                let fontSize = descriptor?.pointSize
                
                let font = type(of: self).adjustableFontWithSize(size: fontSize!)

//                let font = self.classForCoder.adjustableFontWithSize(size: fontSize!)
                
                attString.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, attributedText.length))
                
                super.attributedText = attString
                
            } else {
                super.text = ""
            }
        }
    }
    
    func adjustFont() {
        
        let descriptor = self.font?.fontDescriptor
        
        let fontSize = descriptor?.pointSize
        
        self.font = type(of: self).adjustableFontWithSize(size: fontSize!)

        //self.font = self.classForCoder.adjustableFontWithSize(size: fontSize!)
        
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
    
    class func fontName() -> (String?) {
        return ""
    }
    
}

class UltraLightTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kUltraLightFontName } }
class UltraLightItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kUltraLightItalicFontName } }
class LightTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kLightFontName } }
//class LightItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kLightItalicFontName } }
class RegularTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kRegularFontName } }
//class RegularItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kRegularItalicFontName } }
class MediumTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kMediumFontName } }
class MediumItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kMediumItalicFontName } }
class SemiBoldTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kSemiBoldFontName } }
//class SemiBoldItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kSemiBoldItalicFontName } }
class BoldTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kBoldFontName } }
//class BoldItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kBoldItalicFontName } }
class ExtraBoldTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kExtraBoldFontName } }
class ExtraBoldItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kExtraBoldItalicFontName } }
class HeavyTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kHeavyFontName } }
class HeavyItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kHeavyItalicFontName } }
class BlackTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kBlackFontName } }
class BlackItalicTextView : AdjustableFontTextView { override class func fontName() -> (String?) { return kBlackItalicFontName } }
