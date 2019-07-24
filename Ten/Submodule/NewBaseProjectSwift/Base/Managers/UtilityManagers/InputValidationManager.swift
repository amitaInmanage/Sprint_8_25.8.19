//
//  InputValidationManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class InputValidationManager: BaseManager {
    
    static var sharedInstance = InputValidationManager()
    
    func isValidMobilePhoneNumber(phoneStr: String) -> (Bool) {
        
        let phoneRegex = "[0-9]{9,10}"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phoneTest.evaluate(with: phoneStr)
    }
    
    func isValidCarNumber(carStr: String) -> (Bool) {
        
        let numberCarRegex = "[0-9]{6,8}"
        let numberCarTest = NSPredicate(format: "SELF MATCHES %@", numberCarRegex)
        
        return numberCarTest.evaluate(with: carStr)
    }
    
    func isValidEmail(emailStr: String) -> (Bool) {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: emailStr)
        
    }
    
    
    func isHebrewValidSingleName(name:String) -> (Bool) {
        
        var aName = name
        aName = name.trimmingCharacters(in: .whitespaces)
        
        let hebrewRegex = "([\u{0590}-\u{05FF}])+"
        let hebrewTest  = NSPredicate(format: "SELF MATCHES %@", hebrewRegex)
        let isHebrewValid = hebrewTest.evaluate(with: aName)
        
        if ((isHebrewValid) && aName.count >= 2) {
            return true
        } else {
            return false
        }
    }
    
    func isValidSingleName(name: String) -> (Bool) {
        
        var aName = name
        
        // Delete spaces after the name
        aName = name.trimmingCharacters(in: .whitespaces)
        
        let englishRegex = "[a-zA-z]+([ '-][a-zA-Z])?[']*$"
        let englishTest  = NSPredicate(format: "SELF MATCHES %@", englishRegex)
        let isEnglishValid = englishTest.evaluate(with: aName)
        
        let hebrewRegex = "([\u{0590}-\u{05FF}])+"
        let hebrewTest  = NSPredicate(format: "SELF MATCHES %@", hebrewRegex)
        let isHebrewValid = hebrewTest.evaluate(with: aName)
        
        if ((isEnglishValid || isHebrewValid) && aName.count >= 2) {
            return true
        } else {
            return false
        }
        
    }
    
    func isValidFullName(fullName: String) -> (Bool) {
        
        var aFullName = fullName
        
        // Delete spaces after the name
        aFullName = fullName.trimmingCharacters(in: .whitespaces)
        
        let arrNames = aFullName.components(separatedBy: .whitespaces)
        
        var numberOfValidNames = 0
        
        for name in arrNames {
            
            if self.isValidSingleName(name: name) {
                numberOfValidNames += 1
            }
        }
        
        return numberOfValidNames >= 2
        
    }
    
    
    func isValidCarNumber(carNumber: String) -> (Bool) {
        
        if carNumber.count == 7 || carNumber.count == 8 {
            return true
        }
        
        return false
    }
    
    func isValidBusinessNumber(businessNumber: String) -> (Bool) {
        
        if businessNumber.count == 8 || businessNumber.count == 9 {
            return true
        }
        
        return false
    }
    
    
    func isValidPassword(password: String) -> (Bool) {
        if password.count < 6 {
            return false
        } else {
            return true
        }
    }
    
    func isValidSuffixNumbeer(number: String) -> (Bool) {
        
        if number.count == 9 || number.count == 10 {
            return true
        }
        
        return false
        
    }
    
    func textField(textField: IMTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> (Bool) {
        
        let fullText = textField.text?.appending(string)
        
        if textField.textFieldInputType == .generalNumbericNumber || textField.textFieldInputType == .generalDecimalNumber {
            
            var charactersSetString = "0123456789"
            
            // For decimal keyboard, allow "dot" character
            if textField.textFieldInputType == .generalDecimalNumber {
                charactersSetString = charactersSetString.appending(".")
            }
            
            let numbersOnly : NSCharacterSet = NSCharacterSet(charactersIn: charactersSetString)
            let characterSetFromTextField : NSCharacterSet = NSCharacterSet(charactersIn: fullText!)
            
            // If typed character is out of Set, ignore it.
            let stringIsValid = numbersOnly.isSuperset(of: characterSetFromTextField as CharacterSet)
            
            if !stringIsValid {
                return false
            }
            
            if textField.textFieldInputType == .generalDecimalNumber {
                
                var currentText = textField.text?.trimmingCharacters(in: .whitespaces)
                
                // Change the "," (appears in other locale keyboards, such as russian) key ot "."
                currentText = currentText?.replacingOccurrences(of: ",", with: ".")
                
                // Check the statements of decimal value.
                if fullText == "." {
                    textField.text = "0."
                    return false
                }
                
                if ((fullText?.range(of: "..")) != nil) {
                    textField.text = fullText?.replacingOccurrences(of: "..", with: ".")
                    return false
                }
                
                // If second dot is typed, ignore it.
                let dots = fullText?.components(separatedBy: ".")
                
                if (dots?.count)! > 2 {
                    textField.text = currentText
                    return false
                }
                
                // If first character is zero and second character is > 0, replace first with second. 05 => 5;
                if fullText?.count == 2 {
                    
                    //                    if fullText?.substring(to: (fullText?.index((fullText?.startIndex)!, offsetBy: 1))!) == "0" && fullText != "0." {
                    //                        textField.text = fullText?[(fullText?.startIndex)!..<(fullText?.index((fullText?.startIndex)!, offsetBy: 2))!]
                    //                        return false
                    //
                    //                    }
                    
                }
                
                // Custom addition to limit the number of chars after dot to 2
                if (dots?.count)! == 2 && (dots?[1].count)! > 2 {
                    return false
                }
                
            }
            
        }
        
        
        var oldLength = textField.text?.count
        let replacementLength = string.count
        let rangeLength = range.length
        
        if oldLength == nil {
            oldLength = 0
        }
        
        let newLength = oldLength! - rangeLength + replacementLength
        let returnKey = string.range(of: "\n")
        
        return newLength <= textField.maxCharacters || (returnKey != nil)
    }
    
    // Same as above for textView (usually only used to limit max characters in textView)
    
    func textView(textView: IMTextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> (Bool) {
        
        // Check the max characters typed.
        let oldLength = textView.text.count
        let replacementLength = text.count
        let rangeLength = range.length
        
        let newLength = oldLength - rangeLength + replacementLength
        
        let returnKey = text.range(of: "\n")
        
        return newLength <= textView.maxCharacters || (returnKey != nil)
        
    }
    
    //MARK: General
    func getArrInvalidResponderViewsFromArrResponderViews(arrResponderViews: [Any]) -> [Any] {
        
        var arrInvalidResponderViews = [Any]()
        
        for responderView in arrResponderViews {
            
            if let aResponderView = responderView as? UIView {
                
                for responderSubView in aResponderView.subviews {
                    
                    if responderSubView is UITextField {
                        (responderSubView as! UITextField).text = (responderSubView as! UITextField).text?.trimmingCharacters(in: .whitespaces)
                        
                    } else if responderSubView is UITextView {
                        (responderSubView as! UITextView).text = (responderSubView as! UITextView).text?.trimmingCharacters(in: .whitespaces)
                    }
                    
                    
                     arrInvalidResponderViews += self.setValidationStatus(responderSubView: responderSubView, arrResponderViews: arrResponderViews as! [UIView])
                    
                }
            } else {
                arrInvalidResponderViews += self.setValidationStatus(responderSubView: responderView, arrResponderViews: [UIView]())
                
            }
            
        }
        
        return arrInvalidResponderViews
    }
    
    func setValidationStatus(responderSubView: Any, arrResponderViews: [UIView]) -> [Any] {
        
        var arrInvalidResponderViews = [Any]()
        
        if responderSubView is IMTextField || responderSubView is CustomMDCTextInputControllerUnderline {
            
            if let textField = responderSubView as? IMTextField {
                
                if ((!textField.hasText || textField.text?.count == 0) && textField.textFieldInputType != .mobilePhoneNumberPrefix && textField.textFieldInputType != .mobilePhoneNumberSuffix && textField.textFieldInputType != .none) {
                    
                    textField.textValidationStatus = .empty
                    
                    arrInvalidResponderViews.append(textField)
                    
                    return arrInvalidResponderViews
                }
                textField.textValidationStatus = self.isTxtFldValid(textFieldInputType: textField.textFieldInputType, text: textField.text!, arrResponderViews: arrResponderViews)
                
                if textField.textValidationStatus != .valid {
                    arrInvalidResponderViews.append(textField)
                }
                
            } else if let textInputController = responderSubView as? CustomMDCTextInputControllerUnderline {
                
                if let textField = textInputController.textInput {
                    
                    if ((textField.text?.count == 0) && textInputController.textFieldInputType != .mobilePhoneNumberPrefix && textInputController.textFieldInputType != .mobilePhoneNumberSuffix && textInputController.textFieldInputType != .none) {
                        
                        textInputController.textValidationStatus = .empty
                        
                        arrInvalidResponderViews.append(textInputController)
                        
                        return arrInvalidResponderViews
                    }
                    
                    textInputController.textValidationStatus = self.isTxtFldValid(textFieldInputType: textInputController.textFieldInputType, text: textField.text!, arrResponderViews: arrResponderViews)
                    
                    if textInputController.textValidationStatus != .valid {
                        arrInvalidResponderViews.append(textInputController)
                    }
                }
            }
            
            
        } else if responderSubView is IMTextView {
            
            let textView = responderSubView as! IMTextView
            
            if ((!textView.hasText || textView.text.count == 0) && textView.textFieldInputType != .none) {
                
                if textView.textFieldInputType == .generalString {
                    textView.textValidationStatus = .invalid
                } else {
                    textView.textValidationStatus = .valid
                }
                
                arrInvalidResponderViews.append(textView)
                
                return arrInvalidResponderViews
            }
            
            if textView.text.count <= textView.maxCharacters {
                textView.textValidationStatus = .valid
            } else {
                textView.textValidationStatus = .invalid
            }
            
            if textView.textValidationStatus != .valid {
                arrInvalidResponderViews.append(textView)
            }
        }
        
        return arrInvalidResponderViews
    }
    
    func isTxtFldValid(textFieldInputType: TextFieldInputType, text: String, arrResponderViews: [Any]) -> TextValidationStatus {
        switch textFieldInputType {
            
        case .none:
            return .valid
            
        //////////////// carNumber BusinessNumber
        case .carNumber:
            
            if self.isValidCarNumber(carNumber: text) {
                return .valid
            } else {
                return .invalid
            }
            
        case .BusinessNumber:
            
            if self.isValidBusinessNumber(businessNumber: text) {
                return .valid
            } else {
                return .invalid
            }
            
            ///////////////////
            
        case .generalString:
            return .valid
            
        case .email:
            
            if self.isValidEmail(emailStr: text) {
                return .valid
            } else {
                return .invalid
            }
            
        case .password:
            
            if self.isValidPassword(password: text) {
                return .valid
            } else {
                return .invalid
            }
            
        case .rewritePassword:
            
            print("TODOOOO - FIX rewritePassword")
            let passwordTxtFld = self.getFirstIMTextFieldOfTextFieldInputType(textFieldInputType: .password, fromArrResponderViews: arrResponderViews)
            
            if text == passwordTxtFld?.text {
                return .valid
            } else {
                return .invalid
            }
            
        case .name:
            
            if self.isValidSingleName(name: text) {
                return .valid
            } else {
                return .invalid
            }
            
        case .fullName:
            
            if self.isValidFullName(fullName: text) {
                return .valid
            } else {
                return .invalid
            }
            
        case .mobilePhoneNumberPrefix:
            
            let mobilePhoneNumberPrefixTxtFld = self.getFirstIMTextFieldOfTextFieldInputType(textFieldInputType: .mobilePhoneNumberSuffix, fromArrResponderViews: arrResponderViews)
            
            if let mobilePhoneNumberPrefixTxtFld = mobilePhoneNumberPrefixTxtFld {
                
                let strCombinedMobilePhoneNumberFields = "\(text)\(mobilePhoneNumberPrefixTxtFld.text!)"
                
                if strCombinedMobilePhoneNumberFields.isEmpty {
                    return .empty
                } else {
                    
                    if self.isValidFullName(fullName: strCombinedMobilePhoneNumberFields) {
                        return .valid
                    } else {
                        return .invalid
                    }
                    
                }
                
            } else {
                return .invalid
            }
            
        case .mobilePhoneNumberSuffix:
            
            let mobilePhoneNumberSuffixTxtFld = self.getFirstIMTextFieldOfTextFieldInputType(textFieldInputType: .mobilePhoneNumberPrefix, fromArrResponderViews: arrResponderViews)
            
            if let mobilePhoneNumberSuffixTxtFld = mobilePhoneNumberSuffixTxtFld {
                
                let strCombinedMobilePhoneNumberFields = "\(mobilePhoneNumberSuffixTxtFld.text!)\(text)"
                
                if strCombinedMobilePhoneNumberFields.isEmpty {
                    return .empty
                } else {
                    
                    if self.isValidSuffixNumbeer(number: text) {
                        return .valid
                    } else {
                        return .invalid
                    }
                    
                }
                
            } else {
                return .invalid
            }
            
        case .mobilePhoneNumber:
            
            if isValidMobilePhoneNumber(phoneStr: text) {
                return .valid
            } else {
                return .invalid
            }
            
        case .generalNumbericNumber:
            return .valid
            
        case .generalDecimalNumber:
            return .valid
            
        }
    }
    
    // Convenience method to get the first textField of a certain TextFieldInputType from an array
    func getFirstIMTextFieldOfTextFieldInputType(textFieldInputType :TextFieldInputType, fromArrResponderViews arrResponderViews: [Any]) -> (IMTextField?) {
        
        for responderView in arrResponderViews {
            
            if responderView is IMTextField && (responderView as! IMTextField).textFieldInputType == textFieldInputType {
                return (responderView as! IMTextField)
            } else {
                
                if responderView is UIView {
                    
                    for responderSubView in (responderView as! UIView).subviews {
                        
                        if responderSubView is IMTextField && (responderSubView as! IMTextField).textFieldInputType == textFieldInputType {
                            
                            return (responderSubView as! IMTextField)
                            
                        }
                    }
                }
                
            }
            
            
        }
        
        return nil
    }
    
    // GUI handling for invalid responder views (and their error labels)
    func validateAndHandleGUIForArrResponderViews(arrResponderViews: [UIView]?, andRequiredFieldsErrorLabel requiredFieldsErrorLabel: UILabel?, allTextFieldControllers: [MDCTextInputControllerUnderline]?) -> (Bool) {
        
        if let aArrResponderViews = arrResponderViews {
            
            let arrInvalidResponderViews = self.getArrInvalidResponderViewsFromArrResponderViews(arrResponderViews: aArrResponderViews)
            
            if arrInvalidResponderViews.count > 0 {
                
                for responderView in arrInvalidResponderViews {
                    
                    if responderView is IMTextField {
                        
                        let textField = responderView as! IMTextField
                        
                        ApplicationManager.sharedInstance.gUIManager.setErrorBorderColorForView(view: textField)
                        
                        if textField.textValidationStatus == .invalid {
                            
                            let errorLabel = textField.superview?.viewWithTag(Tags.errorLabelTag) as! UILabel
                            
                            errorLabel.isHidden = false
                            errorLabel.text = textField.strError
                            errorLabel.textColor = UIColor.getApplicationErrorColor()
                            
                        }
                        
                        if textField.textValidationStatus == .empty {
                            
                            for lblError in (textField.superview?.subviews)! {
                                
                                if lblError is UILabel && (lblError.viewWithTag(Tags.errorLabelTag) != nil) {
                                    
                                    (lblError as! UILabel).isHidden = false
                                    (lblError as! UILabel).text = Translation(Translations.ValidationFormErros.requiredFieldError, Translations.ValidationFormErros.requiredFieldErrorDefault)
                                    (lblError as! UILabel).textColor = UIColor.getApplicationErrorColor()
                                    
                                    break
                                }
                            }
                        }
                        
                        if textField.textValidationStatus == .valid &&  requiredFieldsErrorLabel != nil {
                            requiredFieldsErrorLabel!.isHidden = false
                        }
                        
                    } else if responderView is IMTextView {
                        
                        let textView = responderView as! IMTextView
                        
                        if textView.textValidationStatus == .invalid && textView.superview?.viewWithTag(Tags.errorLabelTag) is UILabel {
                            
                            ApplicationManager.sharedInstance.gUIManager .setErrorBorderColorForView(view: textView)
                            
                            let errorLabel = textView.superview?.viewWithTag(Tags.errorLabelTag) as! UILabel
                            errorLabel.isHidden = false
                            errorLabel.textColor = UIColor.getApplicationErrorColor()
                            
                        }
                        
                        if textView.textValidationStatus != .valid &&  requiredFieldsErrorLabel != nil {
                            requiredFieldsErrorLabel!.isHidden = false
                        }
                    }
                }
                
                return false
            }
        }
        
        if let aAllTextFieldControllers = allTextFieldControllers {
            let arrInvalidResponderViews = self.getArrInvalidResponderViewsFromArrResponderViews(arrResponderViews: aAllTextFieldControllers)
            
            if !arrInvalidResponderViews.isEmpty {
                for textInputController in arrInvalidResponderViews {
                    
                    // set error
                    if let aTextInputController = textInputController as? CustomMDCTextInputControllerUnderline {
                        
                        if aTextInputController.textValidationStatus == .invalid {
                            aTextInputController.setErrorText(aTextInputController.strError, errorAccessibilityValue: nil)
                            aTextInputController.errorColor = UIColor.getApplicationErrorColor()
                        }
                        
                        if aTextInputController.textValidationStatus == .empty {
                            
                            aTextInputController.setErrorText(Translation(Translations.ValidationFormErros.requiredFieldError, Translations.ValidationFormErros.requiredFieldErrorDefault), errorAccessibilityValue: nil)
                            aTextInputController.errorColor = UIColor.getApplicationErrorColor()
                        }
                        
                        if aTextInputController.textValidationStatus == .valid &&  requiredFieldsErrorLabel != nil {
                            requiredFieldsErrorLabel!.isHidden = false
                        }
                        
                    }
                    
                }
                return false
            }
        }
        return true
    }
    
    override func reset() {
        InputValidationManager.sharedInstance = InputValidationManager()
    }
    
}

