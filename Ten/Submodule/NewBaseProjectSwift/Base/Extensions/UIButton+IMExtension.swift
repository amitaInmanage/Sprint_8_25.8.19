//
//  UIButton+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit
import SDWebImage

extension UIButton {
    
    func centerImageAndTitleVerticallyWithSpacing(spacing :CGFloat) {
        
        // get the size of the elements here for readability
        let imageSize = self.imageView?.frame.size
        let titleSize = self.titleLabel?.frame.size
        
        // get the width they will take up as a unit
        var imageInset = (titleSize?.width)! + spacing;
        imageInset *= 2;
        var titleInset = (imageSize?.width)! + spacing;
        titleInset *= 2;
        
        // raise the image and push it right to center it
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -imageInset);
        
        // lower the text and push it left to center it
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, titleInset);
        
    }
    
    func centerImageAndTitleHorizontallyWithSpacing(spacing: CGFloat) {
        
        self.titleLabel?.lineBreakMode = .byTruncatingTail;
        
        // get the size of the elements here for readability
        let imageSize = self.imageView?.frame.size
        let titleSize = self.titleLabel?.frame.size
        
        // get the width they will take up as a unit
        let imageInset = (titleSize?.width)! + spacing
        let titleInset = imageSize?.width
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageInset, 0, -imageInset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleInset!, 0, titleInset!);
        
    }
    
    func centerImageAndTitleWithSpacing(spacing: CGFloat) {
        
        let insetAmount = spacing / 2.0;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
        self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);

    }
    
    
    // MARK: - Images For Buttons
    
    // Image - simple method
    func setImageForState(state: UIControlState, withStrURL strURL: String, andAddUnderscoreIphone addUnderscoreIphone: Bool) {
        ApplicationManager.sharedInstance.imageCacheManager.setImageForButton(button: self, forforState: state, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: addUnderscoreIphone, andPlaceholderImage: nil) { (image, error, cacheType, imageURL) in
        }
    }
    
    // Image - extended method
    func setImageForState(state: UIControlState, withStrURL strURL: String, andAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage?, andCompletionBlock completionBlock: @escaping SDWebImageCompletionBlock) {
        
        ApplicationManager.sharedInstance.imageCacheManager.setImageForButton(button: self, forforState: state, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: addUnderscoreIphone, andPlaceholderImage: placeholderImage) { (image, error, cacheType, imageURL) in
            completionBlock(image,error,cacheType,imageURL)
        }
    }
    
    // MARK: - Background Image
    
    // BackgroundImage - simple method
    func setBackgroundImageForState(state: UIControlState, withStrURL strURL: String, andAddUnderscoreIphone addUnderscoreIphone: Bool) {
        
        ApplicationManager.sharedInstance.imageCacheManager.setBackgroundImageForButton(button: self, forState: state, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: addUnderscoreIphone, andPlaceholderImage: nil) { (image, error, cacheType, imageURL) in
        }
    }
    
    // BackgroundImage - extended method
    func setBackgroundImageForState(state: UIControlState, withStrURL strURL: String, andAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage?, andCompletionBlock completionBlock: @escaping SDWebImageCompletionBlock) {
        
        ApplicationManager.sharedInstance.imageCacheManager.setBackgroundImageForButton(button: self, forState: state, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: addUnderscoreIphone, andPlaceholderImage: placeholderImage) { (image, error, cacheType, imageURL) in
            
            completionBlock(image,error,cacheType,imageURL)
        }
        
        
        
    }
    

    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }

    
    
    
    
}
