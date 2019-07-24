//
//  UIColor+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func colorWithRGB(r: CGFloat, g: CGFloat,b: CGFloat) -> (UIColor) {
        return UIColor(red: r/255.0, green:  g/255.0, blue: b/255.0, alpha:  1.0)
    }
    
    
    static func colorWithRGBAlpha(r: CGFloat, g: CGFloat,b: CGFloat,a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green:  g/255.0, blue: b/255.0, alpha: a)
        
    }
    
    //MARK: need to implement getColorFromRGBDictionary method when ParseValidator is finished.
    
    static func getColorFromRGBDictionary(dictRGB: [String:Any]) -> (UIColor) {
        
        var red,green,blue : CGFloat
        
        red = CGFloat(ParseValidator.getFloatForKey(key: "r", JSONDict: dictRGB, defaultValue: 0))
        green = CGFloat(ParseValidator.getFloatForKey(key: "g", JSONDict: dictRGB, defaultValue: 0))
        blue = CGFloat(ParseValidator.getFloatForKey(key: "b", JSONDict: dictRGB, defaultValue: 0))
        
        let color = colorWithRGB(r: red, g: green, b: blue)
        
        return color
        
    }
    
   
    
    func saveColorInNSUserDefaultsWithKey(key: String) {
        let devEnviromentColorData : Data = NSKeyedArchiver.archivedData(withRootObject: self)
        ApplicationManager.sharedInstance.keychainManager.saveDataToKeychain(devEnviromentColorData, forKey: key)
    }
    
    
    static func retrieveColorFromNSUserDefaultsWithKey(key :String, defaultValue: UIColor) -> (UIColor) {
        
        if let data = ApplicationManager.sharedInstance.keychainManager.retrieveDataFromKeychain(key: key) {
            let devEnviromentColor = NSKeyedUnarchiver.unarchiveObject(with: data)
            return devEnviromentColor as! (UIColor)
        } else {
            return defaultValue
        }
    }
    
    static func getApllicationErrorColor() -> (UIColor) {
        return colorWithRGB(r: 228, g: 60, b: 83)
    }
    
    static func getApplicationPrimaryColor() -> (UIColor) {
        return colorWithRGB(r: 0, g: 118, b: 57)
    }
    
    static func getApplicationbackgroundColor() -> (UIColor) {
        return colorWithRGB(r: 232, g: 232, b: 232)
    }
    
    
    static func getApplicationGrayColor() -> (UIColor) {
        return colorWithRGB(r: 166, g: 166, b: 168)
    }
    //
    
    static func getApplicationTabBarBackgroundColor() -> (UIColor) {
        return colorWithRGB(r: 64, g: 64, b: 65)
    }
    
    static func getApplicationNavBarBackgroundColor() -> (UIColor) {
        return colorWithRGB(r: 83, g: 163, b: 24)
    }
    
    static func getApplicationScreenBackgroundColor() -> (UIColor) {
        return UIColor.white
    }
    
    static func getApplicationTextFieldPlaceholderFontColor() -> (UIColor) {
        return colorWithRGB(r: 150, g: 150, b: 152)
    }
    
    static func getApplicationLightColor() -> (UIColor) {
        return colorWithRGB(r: 0, g: 0, b: 0)
    }
    
    static func getApplicationDarkColor() -> (UIColor) {
        return colorWithRGB(r: 57, g: 57, b: 57)
    }
    
    static func getApplicationDisabledColor() -> (UIColor) {
        return colorWithRGB(r: 204, g: 204, b: 204)
    }
    
    static func getApplicationUserInteractionDisabledColor() -> (UIColor) {
        return colorWithRGB(r: 0, g: 0, b: 0)
    }
    
    static func getApplicationErrorColor() -> (UIColor) {
        return colorWithRGB(r: 251, g: 34, b: 5)
    }
    
    static func getApplicationThemeColor() -> (UIColor) {
        return colorWithRGB(r: 0, g: 113, b: 206)
    }
    
    static func getApplicationHighLightTextColor() -> (UIColor) {
        return colorWithRGB(r: 83, g: 163, b: 24)
    }
    
    static func getApplicationLightGrayColor() -> (UIColor) {
        return colorWithRGBAlpha(r: 97, g: 97, b: 97, a: 0.35)
    }
    
    static func getApplicationTextColor() -> (UIColor) {
        return colorWithRGB(r: 0, g: 113, b: 206)
    }
    
    static func getApplicationGrouponItemCellBorderColor() -> (UIColor) {
        return colorWithRGBAlpha(r: 139, g: 139, b: 139, a: 0.5)
    }
    
    static func getApplicationBackgroundDarkColor() -> (UIColor) {
        return colorWithRGBAlpha(r: 0, g: 0, b: 0, a: 0.7)
    }
    
    static func getApplicationBorderColor() -> (UIColor) {
        return colorWithRGB(r: 169, g: 169, b: 169)
    }
    
    static func getApplicationSecondaryLightColor() -> (UIColor) {
        return colorWithRGB(r: 182, g: 144, b: 94)
    }
    
    static func getPressedButtonColor() -> (UIColor) {
        return colorWithRGB(r: 51, g: 51, b: 51)
    }
    
    static func getApplicationClickAbleColor() -> UIColor {
        return colorWithRGB(r: 182, g: 144, b: 94)
    }
    
    static func getApplicationTenButtonColor() -> UIColor { //TenButton color
        return colorWithRGB(r: 0, g: 113, b: 206)
    }
    
    static func getApplicationIMLabelColor() -> UIColor { //Label color
        return colorWithRGB(r: 48, g: 53, b: 79)
    }
    
    static func getApplicationUnderlineColor() -> UIColor { //Underline color
        return self.getLightGrayColor()
    }

    static func getLightGrayColor() -> UIColor {
        return colorWithRGB(r: 151, g: 151, b: 151)
    }
    
    static func getHighlightedTextColor() -> UIColor {
        return colorWithRGB(r: 0, g: 113, b: 206)
    }
    
    static func getAppGreenButtonColor() -> UIColor {
        return colorWithRGB(r: 0, g: 140, b: 47)
    }
    
    static func getHighlightedCellColor() -> UIColor {
        return colorWithRGB(r: 0, g: 104, b: 183)
    }
    
    
    
}

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
