//
//  UIImageView+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
//// The following methods are used when app uses zip media file caching. If app doesn't use zip media file caching, use regular SDWebImage methods (in conjunction with activity indicator SDWebImage extension)
    
    // Simple method uses small white activity indicator
    func setImageWithStrURL(strURL: String, withAddUnderscoreIphone addUnderscoreIphone: Bool) {
        
        ApplicationManager.sharedInstance.imageCacheManager.setImageForImageView(imageView: self, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: addUnderscoreIphone, andPlaceholderImage: nil, andIMActivityIndicatorStyle: .none) { (image, error, cacheType, imageURL) in
        }
    }
    
    // Extended methods
    
    func setImageWithStrURL(strURL: String, withAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage) {
        
        ApplicationManager.sharedInstance.imageCacheManager.setImageForImageView(imageView: self, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: addUnderscoreIphone, andPlaceholderImage: placeholderImage, andIMActivityIndicatorStyle: .none) { (image, error, cacheType, imageURL) in
        }
    }
    
    func setImageWithStrURL(strURL: String, withAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage, andIMActivityIndicatorStyle: Bool, andCompletionBlock completionBlock: @escaping SDWebImageCompletionBlock) {
        
        ApplicationManager.sharedInstance.imageCacheManager.setImageForImageView(imageView: self, withStrImageURLSuffix: strURL, andAddUnderscoreIphone: false, andPlaceholderImage: placeholderImage, andIMActivityIndicatorStyle: .none) { (image, error, cacheType, imageURL) in
            
             completionBlock(image,error,cacheType,imageURL)
            
        }
        
    }

    
}
