//
//  PinCodePopupViewController.swift
//  Ten
//
//  Created by shani daniel on 09/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

enum PopupCodeDigitsOrder: Int {
    case first = 1, second, third, fourth
}

class IdentificationPinCodePopupViewController: BasePopupViewController, IMTextFieldDeleteDeleteBackward ,UITextFieldDelegate, InputCustomViewProtocol{
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: LightLabel!
    @IBOutlet weak var btnSkip: UIStackView!
    
    @IBOutlet weak var vwFirstDigit: UIView!
    @IBOutlet weak var vwSecondDigit: UIView!
    @IBOutlet weak var vwThirdDigit: UIView!
    @IBOutlet weak var vwFourthDigit: UIView!
    
    @IBOutlet weak var txtFldFirstDigit: IMTextField!
    @IBOutlet weak var txtFldSecondDigit: IMTextField!
    @IBOutlet weak var txtFldThirdDigit: IMTextField!
    @IBOutlet weak var txtFldFourthDigit: IMTextField!
    
    var subtitleAlignment = SubtitleAlignment.center
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
    }
  
    func setupTextFields() {
        
        self.vwFirstDigit.tag = PopupCodeDigitsOrder.first.rawValue
        self.vwSecondDigit.tag = PopupCodeDigitsOrder.second.rawValue
        self.vwThirdDigit.tag = PopupCodeDigitsOrder.third.rawValue
        self.vwFourthDigit.tag = PopupCodeDigitsOrder.fourth.rawValue
        
        self.txtFldFirstDigit.tag = PopupCodeDigitsOrder.first.rawValue
        self.txtFldSecondDigit.tag = PopupCodeDigitsOrder.second.rawValue
        self.txtFldThirdDigit.tag = PopupCodeDigitsOrder.third.rawValue
        self.txtFldFourthDigit.tag = PopupCodeDigitsOrder.fourth.rawValue
        
        self.txtFldFirstDigit.maxCharacters = 1
        self.txtFldSecondDigit.maxCharacters = 1
        self.txtFldThirdDigit.maxCharacters = 1
        self.txtFldFourthDigit.maxCharacters = 1
        
        self.txtFldFirstDigit.delegate = self
        self.txtFldSecondDigit.delegate = self
        self.txtFldThirdDigit.delegate = self
        self.txtFldFourthDigit.delegate = self
        
        self.txtFldFirstDigit.delegateDeleteBackward = self
        self.txtFldSecondDigit.delegateDeleteBackward = self
        self.txtFldThirdDigit.delegateDeleteBackward = self
        self.txtFldFourthDigit.delegateDeleteBackward = self
        
        self.txtFldFirstDigit.hideCaret = true
        self.txtFldSecondDigit.hideCaret = true
        self.txtFldThirdDigit.hideCaret = true
        self.txtFldFourthDigit.hideCaret = true
        
        self.txtFldFirstDigit.leftInset = 0
        self.txtFldSecondDigit.leftInset = 0
        self.txtFldThirdDigit.leftInset = 0
        self.txtFldFourthDigit.leftInset = 0
        
        self.txtFldFirstDigit.keyboardType = .numberPad
        self.txtFldSecondDigit.keyboardType = .numberPad
        self.txtFldThirdDigit.keyboardType = .numberPad
        self.txtFldFourthDigit.keyboardType = .numberPad
        
        self.txtFldFirstDigit.becomeFirstResponder()
    }
    
    //MARK: - General
    func setupUI() {
        
        self.setupTextFields()
        
        if let aPopupInfo = self.popupInfoObj {
            
            
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblTitle.text = aStrTitle
            } else {
                self.lblTitle.isHidden = true
            }
            
            if let aStrSubitle = aPopupInfo.strSubtitle {
                self.lblSubTitle.text = aStrSubitle
                switch subtitleAlignment {
                case .left:
                    self.lblSubTitle.textAlignment = .left
                    break
                case .right:
                    self.lblSubTitle.textAlignment = .right
                    break
                case.center:
                    self.lblSubTitle.textAlignment = .center
                    break
                }
            } else {
                self.lblSubTitle.isHidden = true
            }
            
            
            if let strSkipBtn = aPopupInfo.strSkipButtonTitle {
                
//                let font = UIFont.getBtnFontWithFontName(fontClass: MediumButton(), fontSize: 14)
//                self.btnSkip.setAttributedTitle(ApplicationManager.sharedInstance.stringManager.attributeStringWithUnderline(string: strSkipBtn, font: font), for: .normal)
                
                self.btnSkip.isHidden = false
            } else {
                self.btnSkip.isHidden = true
            }
        }
        
    }
    
    @IBAction func didTapSkip(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aSkipButtonAction = aPopupInfo.skipButtonAction {
                aSkipButtonAction()
            }
            
            if let aDelegate = self.popupViewControllerDelegate {
                if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                    
                    aDelegate.closePopupVC!(popupVC: self)
                }
                
            }
        }
        
    }
    
    
    @IBAction func didTapCancel(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aSecondButtonAction = aPopupInfo.secondButtonAction {
                aSecondButtonAction()
            }
            
            if let aDelegate = self.popupViewControllerDelegate {
                if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                    
                    aDelegate.closePopupVC!(popupVC: self)
                }
                
            }
        }
        
    }
/*
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)) {
            
            let newString = ((textField.text)! as NSString).replacingCharacters(in: range, with: string)
            textField.text = string
            
            let newLength = 1 //newString.count
            
            if newLength > 0 {
                
                if let nextVw = textField.superview?.superview?.viewWithTag(textField.tag+1) {
                    for vw in nextVw.subviews {
                        if vw.tag == textField.tag+1 {
                            vw.becomeFirstResponder()
                            break
                        }
                    }
                } else {
                    textField.resignFirstResponder()
                    
                    if self.isAllDigitsTextFieldsFull() {
                        
                        // Go to the next vc
                    }
                    
                }
                return false
                
            } else if (string.count == 0) {
                
                // on deleting value from Textfield
                let previousTag = textField.tag - 1
                
                // get next responder
                
                var previousResponder = textField.superview?.superview?.viewWithTag(previousTag)?.viewWithTag(previousTag)
                
                
                if (previousResponder == nil){
                    var previousResponder = textField.superview?.superview?.viewWithTag(1)?.viewWithTag(1)
                }
                
                textField.text = ""
                previousResponder?.becomeFirstResponder()
                
                return false
            }
            
            return true
        }
        
        return false
    }
 
 */

    
    // MARK: - IMTextFieldDeleteDeleteBackward
    
    func didDeleteBackward(textField: IMTextField) {
        
        if (textField.text?.isEmpty)! {
            
            // on deleting value from Textfield
            let previousTag = textField.tag - 1
            
            // get next responder
            var previousResponder = textField.superview?.superview?.viewWithTag(previousTag)?.viewWithTag(previousTag)
            
            if (previousResponder == nil){
                previousResponder = textField.superview?.superview?.viewWithTag(1)?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
        }
    }
    
    //MARK: - Handlers
    
    func isAllDigitsTextFieldsFull() -> (Bool) {
        if self.txtFldFirstDigit.hasText && self.txtFldSecondDigit.hasText && self.txtFldThirdDigit.hasText && self.txtFldFourthDigit.hasText {
            return true
        }
        return false
    }
    
    func clearAllTextFields() {
        self.txtFldFirstDigit.text = ""
        self.txtFldSecondDigit.text = ""
        self.txtFldThirdDigit.text = ""
        self.txtFldFourthDigit.text = ""
    }
    
}
