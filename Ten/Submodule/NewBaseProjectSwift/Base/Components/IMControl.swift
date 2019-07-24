//
//  IMControl.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

class IMControl: UIControl {
    
    var label : UILabel?
    var imageView : UIImageView?
    var backgroundImageButton : UIButton?
    
    var highlightedImage : UIImage?
    var highlightedTextColor : UIColor?
    
    var selectedImage : UIImage?
    var selectedTextColor : UIColor?
    var selectedBackgroundColor : UIColor?
    
    var originalImage : UIImage?
    var originalTextColor : UIColor?
    var originalBackgroundColor : UIColor?
    
    var originalTextTitle : String?
    var selectedTextTitle : String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for aSubView in self.subviews {
            
            if aSubView is UILabel {
                self.label = aSubView as? UILabel
                
            } else if aSubView is UIImageView {
                self.imageView = aSubView as? UIImageView
                
            } else if aSubView is UIButton {
                self.backgroundImageButton = aSubView as? UIButton
                
            }
        }
        
        self.originalImage = self.imageView?.image
        self.originalTextColor = self.label?.textColor
        self.originalBackgroundColor = self.backgroundColor
        self.originalTextTitle = self.label?.text
        
    }
    
    
    //MARK: Touch Events Delegate
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        if let highlightedImage = self.highlightedImage {
            self.imageView?.image = highlightedImage
        } else {
            self.imageView?.alpha = 0.3
        }
        
        if let highlightedTextColor = self.highlightedTextColor {
            self.label?.textColor = highlightedTextColor
        } else {
            self.label?.alpha = 0.3
        }
        
        if let selectedBackgroundColor = self.selectedBackgroundColor {
            self.backgroundColor = selectedBackgroundColor
        } else {
            self.backgroundColor = self.originalBackgroundColor
        }
        
        return super.beginTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        if self.isSelected {
            
            if let selectedImage = self.selectedImage {
                self.imageView?.image = selectedImage
            } else {
                self.imageView?.image = self.originalImage
            }
            
            if let selectedTextColor = self.selectedTextColor {
                self.label?.textColor = selectedTextColor
            } else {
                self.label?.textColor = originalTextColor
            }
            
            if let selectedBackgrounColor = self.selectedBackgroundColor {
                self.backgroundColor = selectedBackgrounColor
            } else {
                self.backgroundColor = self.originalBackgroundColor
            }
            
        } else {
            
            self.label?.alpha = 1.0
            self.imageView?.alpha = 1.0
            self.imageView?.image = self.originalImage
            self.label?.textColor = self.originalTextColor
            self.backgroundColor = self.originalBackgroundColor
            
            super.endTracking(touch, with: event)
            
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        
        self.label?.alpha = 1.0
        self.imageView?.alpha = 1.0
        
        if self.isSelected {
            
            if let selectedImage = self.selectedImage {
                self.imageView?.image = selectedImage
            } else {
                self.imageView?.image = self.originalImage
            }
            
            if let selectedTextColor = self.selectedTextColor {
                self.label?.textColor = selectedTextColor
            } else {
                self.label?.textColor = originalTextColor
            }
            
            if let selectedBackgrounColor = self.selectedBackgroundColor {
                self.backgroundColor = selectedBackgrounColor
            } else {
                self.backgroundColor = self.originalBackgroundColor
            }
            
        } else {
            
            self.imageView?.image = self.originalImage
            self.label?.textColor = self.originalTextColor
            self.backgroundColor = self.originalBackgroundColor
            
        }
        
        super.cancelTracking(with: event)
        
    }
        
    override var isSelected: Bool {
        willSet(newValue) {
            super.isSelected = newValue;
            
            self.label?.alpha = 1
            self.imageView?.alpha = 1
            
            if newValue {
                
                if let selectedImage = self.selectedImage {
                    self.imageView?.image = selectedImage
                } else {
                    self.imageView?.image = self.originalImage
                }
                
                if let selectedTextColor = self.selectedTextColor {
                    self.label?.textColor = selectedTextColor
                } else {
                    self.label?.textColor = originalTextColor
                }
                
                if let selectedBackgrounColor = self.selectedBackgroundColor {
                    self.backgroundColor = selectedBackgrounColor
                } else {
                    self.backgroundColor = self.originalBackgroundColor
                }
                
                if let _ = self.backgroundImageButton {
                    self.backgroundImageButton?.isHidden = false
                } else {
                    self.backgroundColor = self.originalBackgroundColor
                    self.backgroundImageButton?.isHidden = true
                }
                
                self.label?.alpha = 1
                self.imageView?.alpha = 1
            
            } else {
                
                self.imageView?.image = self.originalImage
                self.label?.textColor = self.originalTextColor
                self.label?.text = self.originalTextTitle
                self.backgroundColor = self.originalBackgroundColor
                self.backgroundImageButton?.isHidden = true
                
            }
            
        }
    }
    
    
    
}
