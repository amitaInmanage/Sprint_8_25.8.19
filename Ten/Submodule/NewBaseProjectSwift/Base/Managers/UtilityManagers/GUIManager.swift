//
//  GUIManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import MaterialComponents.MaterialTextFields

class GUIManager: BaseManager {
    
    static var sharedInstance = GUIManager()
    
    
    // TextField UI setup - i.e border, textColor, placeHolder color...
    func setupTextFieldsInArray(arrTextFields: [Any]) {
        
        for uiView in arrTextFields {
            
            if uiView is UIView {
                
                for textField in (uiView as! UIView).subviews {
                    
                    if textField is UITextField {
                        
                        let txtFld = textField as! UITextField
                        
                        txtFld.borderStyle = .none
                        txtFld.setupWithBorderColor(borderColor: UIColor.getApplicationDisabledColor(), andBorderWidth: 1.0, andCornerRadius: nil)
                        
                        if let _ = txtFld.placeholder {
                            
                            txtFld.attributedPlaceholder = NSAttributedString(string: txtFld.placeholder!, attributes: [.foregroundColor: UIColor.getApplicationDisabledColor()])
                            
//                            txtFld.attributedPlaceholder = NSAttributedString(string: txtFld.placeholder!, attributes: [NSForegroundColorAttributeName:UIColor.getApplicationDisabledColor()])
                        }
                        
                        txtFld.textColor = UIColor.getApplicationLightColor()
                        
                    } else if textField is UITextView {
                        
                        let txtVw = textField as! UITextView
                        
                        txtVw.setupWithBorderColor(borderColor: UIColor.getApplicationDisabledColor(), andBorderWidth: 1.0, andCornerRadius: nil)
                        txtVw.textColor = UIColor.getApplicationLightColor()
                        
                    }
                }
            }
        }
    }
    
    
    // UIControl/UIButton UI setup - border, corner radius, background image from color...
    func setupControlsInArray(arrControls: [Any], withShouldAddBorder shouldAddBorder: Bool, andCornerRadius cornerRadius: CGFloat, andShouldCreateBackgroundImage shouldCreateBackgroundImage: Bool) {
        
        for control in arrControls {
            
            if control is UIControl {
                
                let cntrl = control as! UIControl
                
                var borderColor = UIColor()
                var borderWidth = CGFloat()
                
                if shouldAddBorder {
                    
                    borderColor = UIColor.getApplicationThemeColor()
                    borderWidth = 1.0
                    
                }
                
                cntrl.setupWithBorderColor(borderColor: borderColor, andBorderWidth: borderWidth, andCornerRadius: cornerRadius)
                
                if cntrl is UIButton && shouldCreateBackgroundImage {
                    
                    let btn = cntrl as! UIButton
                    
                    let backgroundImage = UIImage.imageWithColor(color: btn.backgroundColor!)
                    
                    btn.setBackgroundImage(backgroundImage, for: .normal)
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
                    btn.titleLabel?.textAlignment = .center
                    
                }
            }
        }
    }
    
    func setErrorBorderColorForView(view: UIView) {
        view.layer.borderColor = UIColor.getApplicationErrorColor().cgColor
    }
    
    func resetBorderColorForView(view: UIView, allTextFieldControllers: [MDCTextInputControllerUnderline]? = nil) {
        
        if let textInput = view as? MDCTextField {
            if let aAllTextFieldControllers = allTextFieldControllers {
                for textInputController in aAllTextFieldControllers {
                    if textInputController.textInput == textInput {
                        textInputController.setErrorText(nil, errorAccessibilityValue: nil)
                        
                    }
                }

            }
        }
        
        if view.isUserInteractionEnabled {
            
            view.layer.borderColor = UIColor.getApplicationDisabledColor().cgColor
            
            if view is UITextField {
                (view as! UITextField).textColor = UIColor.getApplicationLightColor()
            } else if view is UITextView {
                (view as! UITextView).textColor = UIColor.getApplicationLightColor()
            }
            
        } else {
            
            view.layer.borderColor = UIColor.getApplicationUserInteractionDisabledColor().cgColor
            
            if view is UITextField {
                (view as! UITextField).textColor = UIColor.getApplicationUserInteractionDisabledColor()
            } else if view is UITextView {
                (view as! UITextView).textColor = UIColor.getApplicationUserInteractionDisabledColor()
            }
            
        }
        
    }
    
    func getImageFromBase64String(strEncodeData: String) -> (UIImage?) {
        if let data = Data(base64Encoded: strEncodeData, options: .ignoreUnknownCharacters) {
            let img = UIImage(data: data)
            return img
        }

        return nil
    }
    
    func scaleImage(image: UIImage, maxWidth: CGFloat, maxHeight: CGFloat) -> (UIImage?) {
        
        var scaledSize = CGSize(width: maxWidth, height: maxHeight)
        var scaleFactor = CGFloat()
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width;
            scaledSize.width = maxWidth;
            scaledSize.height = scaledSize.width * scaleFactor;
        } else {
            scaleFactor = image.size.width / image.size.height;
            scaledSize.height = maxHeight;
            scaledSize.width = scaledSize.height * scaleFactor;
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
        
    }
    
    func createBackgroundImageForControls(arrControls: [UIControl]) {
        
        for contorl in arrControls {
            
            if contorl is UIButton {
                
                let btn = contorl as! UIButton
                
                let backgroundImage = UIImage .imageWithColor(color: btn.backgroundColor!)
                
                btn .setBackgroundImage(backgroundImage, for: btn.state)
                
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
                
                btn.titleLabel?.textAlignment = .center
                
            }
            
        }
        
    }
    
    func createCustomBackgroundImage(color: UIColor, forControls arrControls: [UIControl]) {
        
        for contorl in arrControls {
            
            if contorl is UIButton {
                
                let btn = contorl as! UIButton
                
                let backgroundImage = UIImage.imageWithColor(color: color)
                
                btn .setBackgroundImage(backgroundImage, for: btn.state)
                
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
                
                btn.titleLabel?.textAlignment = .center
                
            }
            
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize.init(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize.init(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
   
    override func reset() {
        GUIManager.sharedInstance = GUIManager()
    }
    
    
}
