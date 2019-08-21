//
//  IMTextField.swift
//  WelcomeInSwift
//
//  Created by inmanage on 15/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

enum TextFieldInputType: Int {
    case none = 0, generalString, email, password, rewritePassword, name, fullName, mobilePhoneNumberPrefix, mobilePhoneNumberSuffix, mobilePhoneNumber,
    generalNumbericNumber, generalDecimalNumber, carNumber, BusinessNumber
}

protocol IMTextFieldDeleteDeleteBackward: NSObjectProtocol {
    func didDeleteBackward(textField: IMTextField)
}

import UIKit

class IMTextField: UITextField {
    
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
    
    var textValidationStatus : TextValidationStatus = .none
    var leftViewPadding: CGFloat = 0
    var rightViewPadding: CGFloat = 0
    weak var delegateDeleteBackward: IMTextFieldDeleteDeleteBackward?
    
    
    // Used to limit allowed input characters (i.e. for phone prefix - limit allowed input chars to 3)
    var maxCharacters : Int = Int(INT_MAX)
    
    // Hides blinking cursor - used mainly when a UIPickerView is the textField's input accessory (instead of the regular keyboard)
    var hideCaret = false
    var rightInset : CGFloat = 8
    var leftInset : CGFloat = 0
    var strError = ""
    var indexPath = IndexPath()
    var placeHolderColor: UIColor?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    func initialize() {
        self.maxCharacters = Int(INT_MAX)
        self.leftInset = 8
        self.rightInset = 0
        
        // Just because this app uses scaling (i.e launch images) and textField have a border
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
        
    }
    override func deleteBackward() {
        super.deleteBackward()
        
        if let aDelegate = delegateDeleteBackward {
            aDelegate.didDeleteBackward(textField: self)
        }
        
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        
        if self.hideCaret {
            return CGRect.zero
            
        } else {
            
            let rect = super.caretRect(for: position)
            return rect
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(super.textRect(forBounds: bounds), UIEdgeInsetsMake(0, self.leftInset, 0, self.rightInset))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(super.textRect(forBounds: bounds), UIEdgeInsetsMake(0, self.leftInset, 0, self.rightInset))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(super.textRect(forBounds: bounds), UIEdgeInsetsMake(0, self.leftInset, 0, self.rightInset))
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftViewPadding
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightViewPadding
        return textRect
    }

}

class AdjustableFontTextField : IMTextField {
    
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

                //let font = self.classForCoder.adjustableFontWithSize(size: fontSize!)
                
                attString.addAttribute(.font, value: font, range: NSMakeRange(0, attributedText.length))
                
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

class UltraLightTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kUltraLightFontName } }
class UltraLightItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kUltraLightItalicFontName } }
class LightTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kLightFontName } }
//class LightItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kLightItalicFontName } }
class RegularTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kRegularFontName } }
//class RegularItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kRegularItalicFontName } }
//class MediumTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kMediumFontName } }
class MediumItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kMediumItalicFontName } }
class SemiBoldTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kSemiBoldFontName } }
//class SemiBoldItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kSemiBoldItalicFontName } }
class BoldTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kBoldFontName } }
//class BoldItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kBoldItalicFontName } }
class ExtraBoldTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kExtraBoldFontName } }
class ExtraBoldItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kExtraBoldItalicFontName } }
class HeavyTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kHeavyFontName } }
class HeavyItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kHeavyItalicFontName } }
class BlackTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kBlackFontName } }
class BlackItalicTextField : AdjustableFontTextField { override class func fontName() -> (String?) { return kBlackItalicFontName } }
