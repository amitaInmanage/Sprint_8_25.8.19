//
//  UIImage+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func imageWithColor(color: UIColor) -> (UIImage) {
        
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()!;
        
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return image;
        
    }
    
    
        /// Extension to fix orientation of an UIImage without EXIF
        func fixOrientation() -> UIImage {
            
            guard let cgImage = cgImage else { return self }
            
            if imageOrientation == .up { return self }
            
            var transform = CGAffineTransform.identity
            
            switch imageOrientation {
                
            case .down, .downMirrored:
                transform = transform.translatedBy(x: size.width, y: size.height)
                transform = transform.rotated(by: CGFloat(Double.pi))
                
            case .left, .leftMirrored:
                transform = transform.translatedBy(x: size.width, y: 0)
                transform = transform.rotated(by: CGFloat(Double.pi))
                
            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0, y: size.height)
                transform = transform.rotated(by: CGFloat(-Double.pi))
                
            case .up, .upMirrored:
                break
            }
            
            switch imageOrientation {
                
            case .upMirrored, .downMirrored:
                transform.translatedBy(x: size.width, y: 0)
                transform.scaledBy(x: -1, y: 1)
                
            case .leftMirrored, .rightMirrored:
                transform.translatedBy(x: size.height, y: 0)
                transform.scaledBy(x: -1, y: 1)
                
            case .up, .down, .left, .right:
                break
            }
            
            if let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
                
                ctx.concatenate(transform)
                
                switch imageOrientation {
                    
                case .left, .leftMirrored, .right, .rightMirrored:
                    ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
                    
                default:
                    ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                }
                
                if let finalImage = ctx.makeImage() {
                    return (UIImage(cgImage: finalImage))
                }
            }
            
            // something failed -- return original
            return self
        }
}
