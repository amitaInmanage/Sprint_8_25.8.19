//
//  InputPopupViewController.swift
//  Ten
//
//  Created by shani daniel on 11/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class InputPopupViewController: BasePopupViewController ,BaseFormViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var arrResponderViews : [UIView]!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnConfirm: TenButtonStyle!
    @IBOutlet weak var vwCustonInput: InputCustomView!
    
    var allTextFieldControllers = [MDCTextInputControllerUnderline]()
    var subtitleAlignment = SubtitleAlignment.center
    var firstResponderViewInLineTag: Int = 0
    var lastResponderViewInLineTag: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
  
    //MARK: - General
    func setupUI() {
    
        if let aPopupInfo = self.popupInfoObj {
            
            let aStrEmailPlaceHolder = aPopupInfo.strEmailPlaceHolder!
            
            let aStrErrorEmail = aPopupInfo.strErrorEmail!
            
            self.mDCTextSetUp(mDCText: self.vwCustonInput.txtFldInput, withPlaceholderText: aStrEmailPlaceHolder, withIndex: self.vwCustonInput.txtFldInput.tag, withKeyboardType: .emailAddress , withKeyType: .done, txtFldInputType: .email , errorText: aStrErrorEmail, addToolbar: true)
            
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblTitle.text = aStrTitle
            } else {
                self.lblTitle.isHidden = true
            }
            
            if let strConfirmBtn = aPopupInfo.strConfirmButtonTitle {
                
                if let aBtnConfirmColor = aPopupInfo.btnConfirmColor {
                    
                    self.btnConfirm.setTitle(strConfirmBtn, for: .normal)
                    
                    switch aBtnConfirmColor {
                        
                    case BtnConfirmColors.Green:
                        
                        self.btnConfirm.backgroundColor = UIColor.getAppGreenButtonColor()
                        
                    case BtnConfirmColors.Blue:
                        
                        self.btnConfirm.backgroundColor = UIColor.getApplicationTenButtonColor()
                    }
                }
                
                self.btnConfirm.isHidden = false
            } else {
                self.btnConfirm.isHidden = true
            }
        }
        
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aConfirmButtonAction = aPopupInfo.confirmButtonAction {
                aConfirmButtonAction()
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
    //MARK: -BaseFormViewControllerDelegate
    
    func mDCTextSetUp(mDCText: MDCTextField, withPlaceholderText Placeholder: String, withIndex index: Int ,withKeyboardType keyboardType: UIKeyboardType, withKeyType keyType: UIReturnKeyType,txtFldInputType: TextFieldInputType, errorText: String, addToolbar: Bool = false) {
        
        if addToolbar {
            let addNext = keyType == .next
            self.addToolBarToResponderView(responderView: mDCText, withAddNext: addNext)
        }else{
            mDCText.returnKeyType = keyType
        }
        
        //txtFldInputType
        let txtFldController = CustomMDCTextInputControllerUnderline(textInput: mDCText)
        mDCText.delegate = self
        txtFldController.placeholderText = Placeholder
        mDCText.tag = index;
        txtFldController.setErrorText(nil, errorAccessibilityValue: nil)
        mDCText.keyboardType = keyboardType
        
        mDCText.textAlignment = .right
        
        txtFldController.textFieldInputType = txtFldInputType
        txtFldController.strError = errorText
        
        
        self.setupTxtFldControllerFont(txtFldController: txtFldController)
        
        allTextFieldControllers.append(txtFldController)
        
    }
    
    func addToolBarToResponderView(responderView: Any, withAddNext addNext: Bool) {
        
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let nextBarButtonItem = IMBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapNextBarButtonItem(sender:)))
        nextBarButtonItem.responderView = responderView
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBarButtonItem = IMBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneBarButtonItem(sender:)))
        if addNext {
            toolBar.items = [fixedSpace,doneBarButtonItem,flexibleSpace,nextBarButtonItem,fixedSpace]
        } else {
            toolBar.items = [flexibleSpace, doneBarButtonItem, fixedSpace];
        }
        
        if responderView is UITextField {
            (responderView as! UITextField).inputAccessoryView = toolBar
        } else if responderView is UITextView {
            (responderView as! UITextView).inputAccessoryView = toolBar
        }
    }
    
    func setupTxtFldControllerFont(txtFldController: CustomMDCTextInputControllerUnderline) {
        txtFldController.textInputFont = UIFont(name: LightLabel.getFontName(), size: 16)
        txtFldController.inlinePlaceholderFont = UIFont(name: LightLabel.getFontName(), size: 16)
        txtFldController.leadingUnderlineLabelFont = UIFont(name: LightLabel.getFontName(), size: 14)
        txtFldController.trailingUnderlineLabelFont = UIFont(name: LightLabel.getFontName(), size: 14)
    }
    
    @objc func didTapNextBarButtonItem(sender: IMBarButtonItem) {
        self.moveToNextResponderView(currentResponderView: sender.responderView)
    }
    
    @objc func didTapDoneBarButtonItem(sender: IMBarButtonItem) {
        self.view.endEditing(true)
    }
    
    func moveToNextResponderView(currentResponderView: Any) {
        
        let nextResponderView = self.getNextResponderView(currentResponderView: currentResponderView)
        
        if let nextResponderView = nextResponderView {
            nextResponderView.perform(#selector(becomeFirstResponder), with: nil, afterDelay: 0.05)
        } else {
            self.view.endEditing(true)
        }
        
    }
    
    func getNextResponderView(currentResponderView: Any) -> (UIView?) {
        
        var nextResponderView : UIView?
        var indexOfNextResponderView = 0
        
        if let aCurrentResponderView = currentResponderView as? UITextField {
            let index = aCurrentResponderView.tag
            if index + 1 < allTextFieldControllers.count,
                let nextField = allTextFieldControllers[index + 1].textInput {
                indexOfNextResponderView = nextField.tag
            }
            else if aCurrentResponderView.tag < self.lastResponderViewInLineTag {
                indexOfNextResponderView = self.arrResponderViews.index(after: aCurrentResponderView.tag)
            }
            else if let aCurrentResponderView = currentResponderView as? UITextView {
                if aCurrentResponderView.tag < self.lastResponderViewInLineTag {
                    indexOfNextResponderView = self.arrResponderViews.index(after: aCurrentResponderView.tag)
                }
            }
        }
        
        if indexOfNextResponderView != NSNotFound {
            nextResponderView = self.view.viewWithTag(indexOfNextResponderView)
        }
        
        return nextResponderView
        
    }
}





