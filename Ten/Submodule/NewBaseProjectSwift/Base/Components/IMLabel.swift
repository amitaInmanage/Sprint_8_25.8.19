//
//  IMLabel.swift
//  WelcomeInSwift
//
//  Created by inmanage on 15/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

enum FontType: Int {
    case regular = 0, bold, light, extraBold ,medium ,thin, black
}

import UIKit
//import HTMLString

let arrAppFonts = (Bundle.main.infoDictionary?["UIAppFonts"] as? [Any])

let kUltraLightFontName = ""
let kUltraLightItalicFontName = ""
let kLightFontName = arrAppFonts?[FontType.light.rawValue] as? String
let kRegularFontName = arrAppFonts?[FontType.regular.rawValue] as? String
let kMediumFontName = arrAppFonts?[FontType.medium.rawValue] as? String
let kMediumItalicFontName = ""
let kSemiBoldFontName = ""
let kThinFontName = arrAppFonts?[FontType.thin.rawValue] as? String
let kBoldFontName = arrAppFonts?[FontType.bold.rawValue] as? String
let kExtraBoldFontName = arrAppFonts?[FontType.extraBold.rawValue] as? String
let kExtraBoldItalicFontName = ""
let kHeavyFontName = ""
let kHeavyItalicFontName = ""
let kBlackFontName = arrAppFonts?[FontType.black.rawValue] as? String
let kBlackItalicFontName = ""


class IMLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder)
    {super.init(coder: aDecoder)
        self.initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
        
    }
    
    func initialize() {
        self.minimumScaleFactor = 0.5
        self.textColor = UIColor.getApplicationIMLabelColor()
    
    }

    
    override var text: String? {
        set(newValue) {
            if let aNewValue = newValue {
//                return super.text = aNewValue.removingHTMLEntities
                return super.text = aNewValue
                //TODO: Add HTMLString later
            }
        }
        get {
            return super.text
        }
    }
  
}

class AdjustableFontLabel : IMLabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.adjustFont()
        
    }
    
    func adjustFont() {
        
        let descriptor = self.font.fontDescriptor
        
        let fontSize = descriptor.pointSize
        
        self.font = type(of: self).adjustableFontWithSize(size: fontSize)

        //self.font = self.classForCoder.adjustableFontWithSize(size: fontSize)
        
    }
    
    static func adjustableFontWithSize(size: CGFloat) -> (UIFont) {
        
        var fontName = ""
        
        if let aFontName = self.fontName() {
            
            fontName = aFontName
            fontName = fontName.replacingOccurrences(of: "Italic", with: "It")
            fontName = fontName.replacingOccurrences(of: ".ttf", with: "")
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
    
    class func getFontName() -> String! {
        if let fontName = self.fontName() {
            return fontName.stringByReplacingFirstOccurrenceOfString(target: ".ttf", withString: "")
        }
        return ""
    }
}

class RegularLabel : AdjustableFontLabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Regular", size: 16)
        self.tintColor = UIColor(red: 48, green: 53, blue: 79, alpha: 0)
    }
    
    func fontName() -> (String?) {
     return kBlackFontName
    }
}

class MediumLabel : AdjustableFontLabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tintColor = UIColor(red: 48, green: 53, blue: 79, alpha: 0)
        self.font = UIFont.init(name: "Heebo-Regular", size: 18)
      
    }
}


class BoldLabel : AdjustableFontLabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.font = UIFont.init(name: "Heebo-Regular", size: 16)
        self.tintColor = UIColor(red: 48, green: 53, blue: 79, alpha: 0)
    }
}





class UltraLightLabel : AdjustableFontLabel { override class func fontName() -> (String?) {return kUltraLightFontName }}
class UltraLightItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) {return kUltraLightItalicFontName }}
class LightLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kLightFontName } }
//class LightItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kLightItalicFontName } }
//class RegularItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kRegularItalicFontName } }
class MediumItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kMediumItalicFontName } }
class SemiBoldLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kSemiBoldFontName } }
//class SemiBoldItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kSemiBoldItalicFontName } }
//class BoldItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kBoldItalicFontName } }
class ExtraBoldLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kExtraBoldFontName } }
class ExtraBoldItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kExtraBoldItalicFontName } }
class HeavyLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kHeavyFontName } }
class HeavyItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kHeavyItalicFontName } }
class BlackLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kBlackFontName } }
class BlackItalicLabel : AdjustableFontLabel { override class func fontName() -> (String?) { return kBlackItalicFontName } }

