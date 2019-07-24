//
//  NSString+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit


extension String {
    
    //MARK: AES128 Encrypt/Decrypt
    
    func AES128EncryptWithKey(key :String) -> (String) {
        
        let plainData = self.data(using: .utf8)! as Data as NSData
        let encryptedData : NSData = plainData.aes128Encrypt(withKey: key) as NSData
        
        let encryptedString = encryptedData.base64Encoding(withLineLength: 0)
        
        return encryptedString!
    }
    
    func AES128DecryptWithKey(key: String) -> (String) {
        
        let encryptedData = NSData(base64EncodedString: self)
        let plainData = encryptedData?.aes128Decrypt(withKey: self)
        
        let plainString = String(data: plainData!, encoding: .utf8)
        
        return plainString!
    }
    
    
    
    
    //MARK: General
    
    func replaceString(strReplaceString : String) -> (String) {
        return self .replacingOccurrences(of: "<>", with: strReplaceString)
    }
    
    func isContainsString(strSearchString : String) -> (Bool) {
        return !self.isEmpty
    }
    
    
    func commaSeparatedString() -> (String) {
        
        var isValid = false
        
        let digitsAndDots = NSMutableCharacterSet.decimalDigit()
        digitsAndDots.addCharacters(in: ".")
        digitsAndDots.addCharacters(in: "_")
        
        let inStringSet = NSCharacterSet.init(charactersIn: self)
        
        isValid = digitsAndDots.isSuperset(of: inStringSet as CharacterSet)
        
        if self.isEmpty || !isValid {
            return self
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = NSLocale.current.localizedString(forIdentifier: NSLocale.Key.groupingSeparator.rawValue)
        numberFormatter.groupingSize = 3
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.roundingMode = .down
        
        let doubleNumber = (self as NSString).doubleValue
        
        return numberFormatter.string(from: (doubleNumber as NSNumber))!
        
    }
    
    
    func stringWithNISAndAddSpace(addSpace: Bool) -> (String) {
        
        var strNIS = ""
        
        if addSpace {
            strNIS = "₪ "
        } else {
            strNIS = "₪"
        }
        
        if self.count > 0 {
            
            return String(format: "\u{200e}%@%@" , strNIS , self.commaSeparatedString())
            
        } else {
            
            return ""
            
        }
        
    }
    
    func stringWithNIS() -> (String) {
        return self.stringWithNISAndAddSpace(addSpace: true)
    }
    
    func stringWithNISBackwords() -> (String) {
        
        if self.count > 0 {
            return String(format: "%@ %@" , self.commaSeparatedString() , "₪")
        } else {
            return ""
        }
        
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func myContainsString(other: String) -> (Bool) {
        
        let myRange = (self as NSString).range(of: other, options: .caseInsensitive)
        
        return myRange.length != 0
        
    }
    
    func setHtmlStyleWithStrContent(contentOfUrl: String) -> (String) {
        return String(format: "%@%@", ApplicationManager.sharedInstance.appGD.strWebViewFontStyle, contentOfUrl)
    }
    
    func stringByReplacingFirstOccurrenceOfString(target: String, withString replaceString: String) -> (String) {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
    
    func getWidthSizeForLabel(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    func nsRange(from range: Range<Index>) -> NSRange? {
//        let lower = UTF16View.Index(range.lowerBound, within: utf16)
//        let upper = UTF16View.Index(range.upperBound, within: utf16)
//        return NSRange(location: utf16.startIndex.distance(to: lower), length: lower!.distance(to: upper))
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }

  
}
