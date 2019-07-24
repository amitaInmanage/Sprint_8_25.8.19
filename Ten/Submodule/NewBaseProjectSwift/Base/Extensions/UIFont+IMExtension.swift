//
//  UIFont+IMExtension.swift
//  Ten
//
//  Created by Shani on 12/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func getLblFontWithFontName(fontClass: AdjustableFontLabel, fontSize: CGFloat) -> UIFont? {
        let fontClass = type(of: fontClass)
        
        guard let fontName = fontClass.getFontName() else {
            return nil
        }
        return UIFont(name: fontName, size: fontSize)
        
    }
    
    class func getBtnFontWithFontName(fontClass: AdjustableFontButton, fontSize: CGFloat) -> UIFont? {
        let fontClass = type(of: fontClass)
        
        guard let fontName = fontClass.getFontName() else {
            return nil
        }
        return UIFont(name: fontName, size: fontSize)
        
    }
    
}
