//
//  UILabel+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

extension UILabel {
    

    func boundingRectForCharacterRange(range :NSRange) -> (CGRect) {
        
        let textStorage = NSTextStorage.init(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer.init(size: self.bounds.size)
        textContainer.lineFragmentPadding = 0
        
        layoutManager .addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        
    }
    
    
//    public var kerning:CGFloat {
//        set{
//            if let currentAttibutedText = self.attributedText {
//                let attribString = NSMutableAttributedString(attributedString: currentAttibutedText)
//                attribString.addAttributes([NSKernAttributeName:newValue], range:NSMakeRange(0, currentAttibutedText.length))
//                self.attributedText = attribString
//            }
//        } get {
//            var kerning:CGFloat = 0
//            if let attributedText = self.attributedText {
//                attributedText.enumerateAttribute(NSKernAttributeName,
//                                                  in: NSMakeRange(0, attributedText.length),
//                                                  options: .init(rawValue: 0)) { (value, range, stop) in
//                                                    kerning = value as? CGFloat ?? 0
//                }
//            }
//            return kerning
//        }
//    }
    
    public var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
    
    public func isTruncated() -> Bool {
        
        if let string = self.text {
            
            let size: CGSize = (string as NSString).boundingRect(
                with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: [.font: self.font],
                context: nil).size
            
            return (size.height > self.bounds.size.height)
        }
        
        return false
    }

}
