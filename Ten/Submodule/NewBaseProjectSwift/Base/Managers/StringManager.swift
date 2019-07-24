//
//  StringManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class StringManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = StringManager()
    
    // Encryption/Decryption using encKey in Constants
    func encryptedStringForString(str: String) -> (String) {
        return str.AES128EncryptWithKey(key: Constans.encryptionKey)
    }
    
    func decryptedStringForString(str: String) -> (String) {
        return str.AES128DecryptWithKey(key: Constans.encryptionKey)
    }
    
    func getGenderOrientedStringFromString(strRaw: String) -> (String) {
        
        var strResultString = ""
        var aStrRaw = strRaw
        let replacebale = self.getStringBetweenCharacter(str1: "[", and: "]", fromString: strRaw)
        
        let arrSplitted = replacebale.components(separatedBy: "|")
        
        if arrSplitted.count > 2 {
            
            switch ApplicationManager.sharedInstance.userAccountManager.user.gender {
                
            case .female:
                strResultString = arrSplitted[2]
                
            case .male:
                strResultString = arrSplitted[1]
                
            case .na :
                strResultString = arrSplitted[0]
                
            }
            
        } else {
            
            if arrSplitted.count > 0 {
                strResultString = arrSplitted.first!
            }
        }
        
        aStrRaw = strRaw.replacingOccurrences(of: replacebale, with: strResultString)
        
        aStrRaw = strRaw.replacingOccurrences(of: "]", with: "")
        aStrRaw = strRaw.replacingOccurrences(of: "[", with: "")
        
        return aStrRaw
    }
    
    func getStringBetweenCharacter(str1: String, and str2: String, fromString completeStr: String) -> (String) {
        
        if(!completeStr.myContainsString(other: str1) || !completeStr.myContainsString(other: str2)) {
            return completeStr
        }
        
        let r1 = (completeStr as NSString).range(of: str1) 
        let r2 = (completeStr as NSString).range(of: str2)
        let rSub = NSRange(location: r1.location + r1.length, length: r2.location - r1.location - r1.length)
        
        var sub = ""
        
        if str1 == str2 {
            sub = completeStr.components(separatedBy: str1)[1]
        } else {
            sub = (completeStr as NSString).substring(with: rSub)
        }
        
        return sub
        
    }
    
    func clickableStringWithColor(color: UIColor, fromString strKey:String, forLabel label: TTTAttributedLabel, withDelegate delegate: TTTAttributedLabelDelegate, isUnderLine: Bool, font : UIFont?, andPath path: String?) {
        
        var strResultString = strKey
        
        let linkedString = self.getStringBetweenCharacter(str1: "{", and: "}", fromString: strResultString)
        
        strResultString = strResultString.stringByReplacingFirstOccurrenceOfString(target: "{", withString: "")
        strResultString = strResultString.stringByReplacingFirstOccurrenceOfString(target: "}", withString: "")
        
        let range = (strResultString as NSString).range(of: linkedString)
        
        if range.location != NSNotFound {
            
            let tapplbleRange = range
            
            let linkedRange = tapplbleRange
            
            label.linkAttributes = [:]
            label.activeLinkAttributes = [:]
            
            if(isUnderLine) {
                
                label.linkAttributes.updateValue(NSNumber(value: isUnderLine), forKey: NSAttributedStringKey.underlineStyle)
            }
            
            if let aFont = font {
                label.linkAttributes.updateValue(aFont, forKey: NSAttributedStringKey.font)
            }
            
            label.linkAttributes.updateValue(color, forKey: NSAttributedStringKey.foregroundColor)

            label.delegate = delegate
            
            label.setText(strResultString)
            
            let urlPath = URL(string: linkedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            
            if let aPath = path {
                let aClickablePath = URL(string: aPath)
                
                label.addLink(to: aClickablePath, with: linkedRange)
            } else {
                label.addLink(to: urlPath, with: linkedRange)
            }
            
            label.isUserInteractionEnabled = true
            
        }
        
    }
    
    func clickableStringWithColorByString(arrTexts: [String], color: UIColor, fromString strKey:String, forLabel label: TTTAttributedLabel, withDelegate delegate: TTTAttributedLabelDelegate, isUnderLine: Bool, font : UIFont?) {
        
        label.linkAttributes = [:]
        label.activeLinkAttributes = [:]
        
        label.setText(strKey)
        label.delegate = delegate
        
        for aStringToFind in arrTexts {
            
            let range = (strKey as NSString).range(of: aStringToFind)
            
            if range.location != NSNotFound {
                
                let tapplbleRange = range
                
                let linkedRange = tapplbleRange
                
                if(isUnderLine) {
                    label.linkAttributes.updateValue(NSNumber(value: isUnderLine), forKey: NSAttributedStringKey.underlineStyle)
                }
                
                if let aFont = font {
                    label.linkAttributes.updateValue(aFont, forKey: NSAttributedStringKey.font)
                }
                
                label.addLink(to: URL(string: aStringToFind), with: linkedRange)
                label.isUserInteractionEnabled = true
                
            }
            
        }

    }
    
    func setTwoLanguagesStringIntegrat(originalString: String) -> String {

        return "\u{200E}" + originalString
        
        }
    
    func splitString(originalString: String) -> Array<String> {
        
        var elements: [String] = []
        
        if originalString.contains("<") && originalString.contains(">") {
            let firstStr = self.replaceString(originalString: originalString, replacement: "")
            let secondStr = self.getStringBetweenCharacter(str1: "<", and: ">", fromString: originalString)
            elements.append(firstStr)
            elements.append(secondStr)
        } else {
          elements.append(originalString)
        }
        return elements
    }
    
    func setAttributedStringWithTwoFonts(firstStr: String, firstFont: UIFont, secondStr: String, secondFont: UIFont) -> NSMutableAttributedString {
    
        let attrs1 = [NSAttributedStringKey.font : firstFont] //, NSAttributedStringKey.foregroundColor : UIColor.green]    // -> for tests
        let attrs2 = [NSAttributedStringKey.font : secondFont] //,  NSAttributedStringKey.foregroundColor : UIColor.red]    //  -> for tests

        let attributedString1 = NSMutableAttributedString(string: firstStr, attributes: attrs1)
        let attributedString2 = NSMutableAttributedString(string: secondStr, attributes: attrs2)
        
        attributedString1.append(attributedString2)
        
        return attributedString1
    }

    func clickableAllStringWithColor(color: UIColor, fromString strKey:String, forLabel label: TTTAttributedLabel, withDelegate delegate: TTTAttributedLabelDelegate, isUnderLine: Bool, font : UIFont?, andPath path: String?) {
        
        var strResultString = strKey
        label.setText(strResultString)
        
        if let text = label.text as? String {
            label.text =  text.replacingOccurrences(of: "{", with: "")
            label.text = text.replacingOccurrences(of: "}", with: "")
        }
        
        while strResultString.contains("{") ||  strResultString.contains("}") {
            
            let linkedString = self.getStringBetweenCharacter(str1: "{", and: "}", fromString: strResultString)
            
            strResultString = strResultString.stringByReplacingFirstOccurrenceOfString(target: "{", withString: "")
            strResultString = strResultString.stringByReplacingFirstOccurrenceOfString(target: "}", withString: "")
            
            let range = (strResultString as NSString).range(of: linkedString)
            
            if range.location != NSNotFound {
                
                let tapplbleRange = range
                
                let linkedRange = tapplbleRange
                
                label.linkAttributes = [:]
                label.activeLinkAttributes = [:]

                if(isUnderLine) {
                    label.linkAttributes.updateValue(NSNumber(value: isUnderLine), forKey: NSAttributedStringKey.underlineStyle)
                }
                
                if let aFont = font {
                    label.linkAttributes.updateValue(aFont, forKey: NSAttributedStringKey.font)
                }
                
                label.linkAttributes.updateValue(color, forKey: NSAttributedStringKey.foregroundColor)
                
                label.delegate = delegate
                
                
                let urlPath = URL(string: linkedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                
                if let aPath = path {
                    let aClickablePath = URL(string: aPath)
                    
                    label.addLink(to: aClickablePath, with: linkedRange)
                } else {
                    label.addLink(to: urlPath, with: linkedRange)
                }
                
                label.isUserInteractionEnabled = true
            }
        }
    }
    
    func replaceString(originalString: String, replacement: String) -> String {
        
        let startRange = (originalString as NSString).range(of: "{")
        let endRange = (originalString as NSString).range(of: "}")
        
        if startRange.location != NSNotFound && endRange.location != NSNotFound && startRange.location < endRange.location {
            let replacementRange = NSRange(location: startRange.location, length: endRange.location - startRange.location + 1)
            let strOriginal = originalString as NSString
            return strOriginal.replacingCharacters(in: replacementRange, with: replacement)
        }
        
        return originalString
    }
    
   
    func replaceString(originalString: String, replacement: String...) -> String {
        
        let regexStart = try? NSRegularExpression(pattern: "{", options: .caseInsensitive)
        let numberOfMatchesStart: Int? = regexStart?.numberOfMatches(in: originalString, options: [], range: NSRange(location: 0, length: originalString.count))
        
        let regexEnd = try? NSRegularExpression(pattern: "}", options: .caseInsensitive)
        let numberOfMatchesEnd: Int? = regexEnd?.numberOfMatches(in: originalString, options: [], range: NSRange(location: 0, length: originalString.count))
        
        if let aNumStart = numberOfMatchesStart, let aNumEnd = numberOfMatchesEnd, aNumStart != aNumEnd {
            return originalString;
        }
        

        var newString = originalString
        
        for index in 0..<replacement.count {
            let startRange = (newString as NSString).range(of: "{").location
            let endRange = (newString as NSString).range(of: "}").location
            if (replacement.count == 0 || startRange > endRange ) { // || number fo "<" != ">"  if thet is no "<" & ">"
                return originalString
            }
            let replacementRange = NSRange(location: startRange, length: endRange - startRange + 1)
            newString = (newString as NSString).replacingCharacters(in: replacementRange, with: replacement[index])
        }
        return newString
    }
    
    func subStringToFullName(originalString: String) -> String{
        if originalString.count > 0 {
            let originalStringTrimmed = originalString.trimmingCharacters(in: .whitespacesAndNewlines)
            let char = (originalStringTrimmed as NSString).rangeOfComposedCharacterSequence(at: 1)
            //        let startRange = (self as NSString).range(of: char)
            let endRange = (originalString as NSString).range(of: " ")
            let replacement = "."
            if char.location != NSNotFound && endRange.location != NSNotFound && char.location < endRange.location {
                let replacementRange = NSRange(location: char.location, length: endRange.location )
                let strNewString = originalString
                return (strNewString as NSString).replacingCharacters(in: replacementRange, with: replacement)
                //            return strNewString
            }
        }
        
        return originalString
        
    }
    
    func attributeStringWithUnderline(string: String, font: UIFont?) -> NSAttributedString {
        
        let attributeString = NSMutableAttributedString(string: string, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        if let aFont = font {
            attributeString.addAttributes([.font: aFont], range: NSRange(location: 0, length: attributeString.length))            
        }
        
        return attributeString
    }
    
    func getAttributeStringWithUnderlineWithRange(string: String, font: UIFont?) -> NSAttributedString {
        
        let attributeString = NSMutableAttributedString(string: string)
        if let aFont = font {
            attributeString.addAttributes([.font: aFont], range: NSRange(location: 0, length: attributeString.length))
        }
        
        let startRange = (string as NSString).range(of: "{")
        let endRange = (string as NSString).range(of: "}")
        
        if startRange.location != NSNotFound && endRange.location != NSNotFound && startRange.location < endRange.location {
            let undelineRange = NSRange(location: startRange.location, length: endRange.location - startRange.location + 1)
            attributeString.addAttributes([.underlineStyle: NSUnderlineStyle.styleSingle.rawValue], range: undelineRange)
            attributeString.replaceCharacters(in: endRange, with: NSAttributedString(string: ""))
            attributeString.replaceCharacters(in: startRange, with: NSAttributedString(string: ""))
            return attributeString
            
        }

        return attributeString
    }
    
    override func reset() {
        StringManager.sharedInstance = StringManager()
    }
    
    
     

}
