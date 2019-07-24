//
//  BaseFormViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 12/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

let kResponderScrollView = "responderScrollView"
let kResponderScrollViewBottomConstraint = "responderScrollViewBottomConstraint"

class BaseFormViewController: BaseViewController, UITextViewDelegate, UITextFieldDelegate, InputCustomViewProtocol, BaseFormViewControllerDelegate {
    
    @IBOutlet weak var responderScrollView: IMScrollView!
    @IBOutlet weak var constraintScrollViewBottomSpaceToSuperview: NSLayoutConstraint!
    
    var aResponderScrollView : UIScrollView!
    var aResponderScrollViewBottomConstraint : NSLayoutConstraint!
    var responderScrollViewOriginalBottomConstraintConstant = CGFloat()
    var responderScrollViewOriginalFrame = CGRect()
    var responderScrollViewRelativeKeyboardEndFrame = CGRect()
    var isKeyboardRaised = false
    var allTextFieldControllers = [MDCTextInputControllerUnderline]()
    
//    // Tags of first and last responders (i.e textFields) in a viewController. Only needed if VC wants textField jumping (i.e. pressing next on keyboard moves focus to next responder in line). Tags must be set in IB (interface builder - storyBoard or xib) or code for this to work.
//    var firstResponderViewInLineTag: NSInteger!
//    var lastResponderViewInLineTag: NSInteger!
    
//    // Used for textField/textViews jumping and error state handling
//    var arrResponderViews = [UIView]()
//    var arrResponderTextViews = [UIView]()
//    
    
    // Tags of first and last responders (i.e textFields) in a viewController. Only needed if VC wants textField jumping (i.e. pressing next on keyboard moves focus to next responder in line). Tags must be set in IB (interface builder - storyBoard or xib) or code for this to work.
    var firstResponderViewInLineTag: Int = 0
    var lastResponderViewInLineTag: Int = 0
    
    // Used for textField jumping and error state handling
    @IBOutlet var arrResponderViews : [UIView]!
    @IBOutlet var arrResponderTextViews : [UIView]!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)) , name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let scrlVw = responderScrollView {
            self.aResponderScrollView = scrlVw
            
            responderScrollViewOriginalFrame = (self.aResponderScrollView != nil) ? self.aResponderScrollView.frame : CGRect.zero
            
        }
        if let scrlVwBottomConstraint = constraintScrollViewBottomSpaceToSuperview {
            self.aResponderScrollViewBottomConstraint = scrlVwBottomConstraint
            
            responderScrollViewOriginalBottomConstraintConstant = (self.aResponderScrollViewBottomConstraint != nil) ? self.aResponderScrollViewBottomConstraint.constant : 0
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let index = textField.tag
        if index + 1 < allTextFieldControllers.count,
            let nextField = allTextFieldControllers[index + 1].textInput {
            nextField.becomeFirstResponder()
        } else  if textField.returnKeyType == .next {
            self.moveToNextResponderView(currentResponderView: textField)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //self.resetArrResponderViewsFromErrorState()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.resetResponderViewFromErrorState(responderView: textField)
        self.handleScrollingToView(view: textField)
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.resetResponderViewFromErrorState(responderView: textField)
        self.handleScrollingToView(view: textField)
        
        // allow backspace
        if string.isEmpty {
            return true
        }
        
        if let imTextField = textField as? IMTextField {
            
            return ApplicationManager.sharedInstance.inputValidationManager.textField(textField: imTextField, shouldChangeCharactersInRange: range, replacementString: string)
            
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Prevent textField's text from jumping (weird animation) when leaving textField and moving to next responder view
        textField.layoutIfNeeded()
    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.resetArrResponderViewsFromErrorState()
        self.handleScrollingToView(view: textView)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // allow backspace
        if text.isEmpty {
            return true
        }
        
        if textView is IMTextView {
            
            let imTextView = textView as! IMTextView
            return ApplicationManager.sharedInstance.inputValidationManager.textView(textView: imTextView, shouldChangeTextInRange: range, replacementText: text)
            
        }
        
        return true
    }
    
    
    //MARK: Responder view initialization and handling
    func addToolBarsToAllResponderViewsBetweenFirstAndLastInLine() {
        
        if self.firstResponderViewInLineTag <= 0 || self.lastResponderViewInLineTag <= 0 || self.firstResponderViewInLineTag > self.lastResponderViewInLineTag {
            return
        }
        
        
        for i in self.firstResponderViewInLineTag ..< self.lastResponderViewInLineTag  {
            
            let view = self.view.viewWithTag(i)
            
            if let view = view {
                
                var addNext = false
                
                if i == self.lastResponderViewInLineTag {
                    addNext = true
                } else {
                    addNext = false
                }
                
                self.addToolBarToResponderView(responderView: view, withAddNext: addNext)
            }
        }
    }
    
    // In general, toolbars should only be added if at least one textField uses a NumberPad keyboard or has a UIPickerView as an input accessory
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
    
    // Attempts to move to next responder view (if exists) or end editing if doesn't
    func moveToNextResponderView(currentResponderView: Any) {
        
        let nextResponderView = self.getNextResponderView(currentResponderView: currentResponderView)
        
        if let nextResponderView = nextResponderView {
            nextResponderView.perform(#selector(becomeFirstResponder), with: nil, afterDelay: 0.05)
        } else {
            self.view.endEditing(true)
        }
        
    }
    
    // Attempts to get next responder view based on tag of current responder view
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
    
    
    //MARK: Keyboard handlers when keyboard appears and disappears
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if self.aResponderScrollViewBottomConstraint == nil || self.aResponderScrollView == nil{
            return
        }
        
        let endFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        responderScrollViewRelativeKeyboardEndFrame = endFrame
        let duration : TimeInterval = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        //let curve: UIViewAnimationCurve = UIViewAnimationCurve(rawValue: notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int)
        
        responderScrollViewRelativeKeyboardEndFrame.size.height -= self.view.height()-(responderScrollViewOriginalFrame.origin.y+responderScrollViewOriginalFrame.size.height)
        
        var newResponderScrollViewBottomConstraintConstant = CGFloat()
        
        let scrollViewRect : CGRect = (self.aResponderScrollView.superview?.convert(self.aResponderScrollView.frame, to: nil))!
        
        //scrollViewRect.size.height -= self.aResponderScrollViewBottomConstraint.constant
        
        // Keyboard will be lowered
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            newResponderScrollViewBottomConstraintConstant = responderScrollViewOriginalBottomConstraintConstant
        } else {
            
            let keyboardToScrollViewVerticalEndPointDifference = scrollViewRect.origin.y+scrollViewRect.size.height-endFrame.origin.y
            
            if (keyboardToScrollViewVerticalEndPointDifference >= 0 || (keyboardToScrollViewVerticalEndPointDifference < 0 && self.isKeyboardRaised)) {
                
                newResponderScrollViewBottomConstraintConstant = self.aResponderScrollViewBottomConstraint.constant+keyboardToScrollViewVerticalEndPointDifference
                
            } else {
                
                newResponderScrollViewBottomConstraintConstant = responderScrollViewOriginalBottomConstraintConstant
                
            }
            
        }
        
        self.view.layoutIfNeeded()
        
        self.aResponderScrollViewBottomConstraint.constant = newResponderScrollViewBottomConstraintConstant
        
        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        self.isKeyboardRaised = true
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        self.isKeyboardRaised = false
    }
    
    func handleScrollingToView(view: UIView) {
        
        if self.aResponderScrollViewBottomConstraint == nil {
            return
        }
        
        let viewRect = view.superview?.convert(view.frame, to: self.aResponderScrollView)
        let currentVisibleRect = CGRect(x: self.aResponderScrollView.contentOffset.x, y: self.aResponderScrollView.contentOffset.y, width: self.responderScrollViewOriginalFrame.size.width, height: self.responderScrollViewOriginalFrame.size.height-self.responderScrollViewRelativeKeyboardEndFrame.size.height)
        
        var offSetY = CGFloat()
        
        if let aViewRect = viewRect {
         
            if aViewRect.origin.y < currentVisibleRect.origin.y {
                offSetY = aViewRect.origin.y
                
            } else if (aViewRect.origin.y + aViewRect.size.height) > (currentVisibleRect.origin.y+currentVisibleRect.size.height) {
                offSetY = aViewRect.origin.y - currentVisibleRect.size.height + aViewRect.size.height
                
            } else {
                return
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
                self.aResponderScrollView.setContentOffset(CGPoint(x: self.aResponderScrollView.contentOffset.x, y: offSetY), animated: false)
            }, completion: nil)
            
        }
        
        
    }
    
    
    //MARK: IMBarButtonItem
    @objc func didTapNextBarButtonItem(sender: IMBarButtonItem) {
         self.moveToNextResponderView(currentResponderView: sender.responderView)
    }
    
    @objc func didTapDoneBarButtonItem(sender: IMBarButtonItem) {
        self.view.endEditing(true)
    }
    
    //MARK: Reset responder views from error state
    // Responder views error state reset - note the reserved tags for responder view error handling (see Constants.h for details)
    func resetArrResponderViewsFromErrorState() {
        
        if let aArrResponderViews = self.arrResponderViews {
            for responderView in aArrResponderViews {
                
                for responderSubView in responderView.subviews {
                    
                    if responderSubView is UITextField || responderSubView is UITextView {
                        ApplicationManager.sharedInstance.gUIManager.resetBorderColorForView(view: responderSubView)
                    }
                    
                    for lblError in responderView.subviews {
                        
                        if lblError is UILabel && (lblError.viewWithTag(Tags.errorLabelTag) != nil) {
                            (lblError as! UILabel).isHidden = true
                            break
                        }
                        
                    }
                }
            }
        }
        
        for txtFld in self.allTextFieldControllers {
            txtFld.setErrorText(nil, errorAccessibilityValue: nil)
        }

        self.view.viewWithTag(Tags.requiredFieldsErrorLabelTag)?.isHidden = true
    }
    
    // reset error for spesific textfield
    func resetResponderViewFromErrorState(responderView: UITextField) {

        ApplicationManager.sharedInstance.gUIManager.resetBorderColorForView(view: responderView, allTextFieldControllers: allTextFieldControllers)
        
        if let subviews = responderView.superview?.subviews {
            
            for lblError in subviews {
                
                if lblError is UILabel && (lblError.viewWithTag(Tags.errorLabelTag) != nil) {
                    (lblError as! UILabel).isHidden = true
                    break
                }
            }
            
        }
     
        self.view.viewWithTag(Tags.requiredFieldsErrorLabelTag)?.isHidden = true
        //self.view.viewWithTag(Tags.errorLabelTag)?.isHidden = true
        
    }

    func mDCTextSetUp(mDCText: MDCTextField, withPlaceholderText Placeholder: String, withIndex index: Int ,withKeyboardType keyboardType: UIKeyboardType, withKeyType keyType: UIReturnKeyType,txtFldInputType: TextFieldInputType, errorText: String, addToolbar: Bool = false) {
        
        if addToolbar {
            let addNext = keyType == .next
            self.addToolBarToResponderView(responderView: mDCText, withAddNext: addNext)
        } else{
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
 
    func setupTxtFldControllerFont(txtFldController: CustomMDCTextInputControllerUnderline) {
        txtFldController.textInputFont = UIFont(name: LightLabel.getFontName(), size: 16)
        txtFldController.inlinePlaceholderFont = UIFont(name: LightLabel.getFontName(), size: 16)
        txtFldController.leadingUnderlineLabelFont = UIFont(name: LightLabel.getFontName(), size: 14)
        txtFldController.trailingUnderlineLabelFont = UIFont(name: LightLabel.getFontName(), size: 14)
    }
    
    //MARK: - inputCustomViewProtocolDelegate
    
    func didTapBtnTrailing(sender: UIButton) {
        
    }
}
