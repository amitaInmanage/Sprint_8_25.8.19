//
//  SignUpWithPhoneNumberViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpWithPhoneNumberViewController: BaseFormViewController {
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblInvalidNumber: UILabel!
    @IBOutlet weak var txtFldPhoneNumber: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    @IBOutlet weak var btnContinueWithOutSignUp: IMButton!
    @IBOutlet weak var consteintSignUpBtn: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    
    var viewModel = SignUpWithPhoneNumberViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let navigation = parent as? TenStyleViewController {
            navigation.hideBackBtn()
        }
    }
    
    func initUI() {
        self.moveBtns()
        self.initializeTextFields()
        self.btnContinue.Disabled()
        self.lblInvalidNumber.isHidden = true
        self.txtFldPhoneNumber.txtFldInput.keyboardType = UIKeyboardType.numberPad
        
    }
    
    fileprivate func initializeTextFields() {
        self.mDCTextSetUp(mDCText: self.txtFldPhoneNumber.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.loginGetPhone, Translations.Placeholders.loginGetPhoneDefault), withIndex: self.txtFldPhoneNumber.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        txtFldPhoneNumber.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.loginTitle, Translations.Titles.loginTitleDefault)
        self.lblInvalidNumber.text = Translation(Translations.ValidationFormErros.errorPhoneNumber,Translations.ValidationFormErros.errorPhoneNumberDefault)
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.btnConfirm, Translations.AlertButtonsKeys.btnConfirmDefault), for: .normal)
        self.btnContinueWithOutSignUp.addUnderline(title: Translation(Translations.AlertButtonsKeys.loginUnderlineText, Translations.AlertButtonsKeys.loginUnderlineTextDefault))
    }
  
    fileprivate func moveBtns() {
       NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow),
                                          name: Notification.Name.UIKeyboardWillShow, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide),
                                               name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: KeyboardNotification
    @objc func handleKeyboardHide(_ notification: Notification) {
        consteintSignUpBtn.constant = consteintSignUpBtn.constant - self.viewModel.keyboardH + self.viewModel.navigationH + self.viewModel.statusBarH
        UIView.animate(withDuration: 0.3) {
             self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardShow (_ notification: Notification) {
        if self.viewModel.keyboardH == 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                self.viewModel.keyboardH = keyboardRectangle.height
            }
        }
        if self.consteintSignUpBtn.constant < self.viewModel.keyboardH {
            
            UIView.animate(withDuration: 0.3) {
                
                self.consteintSignUpBtn.constant = self.consteintSignUpBtn.constant + self.viewModel.keyboardH - self.viewModel.navigationH - self.viewModel.statusBarH
                
                 self.view.layoutIfNeeded()
            }
        } else if self.consteintSignUpBtn.constant > 190 {
            
            UIView.animate(withDuration: 0.3) {
                
                self.consteintSignUpBtn.constant = self.consteintSignUpBtn.constant - self.viewModel.keyboardH + self.viewModel.navigationH + self.viewModel.statusBarH
                
                self.view.layoutIfNeeded()
        
            }
        }
    }
    
    //MARK: TextFieldDelegate
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        //Max length UITextField:
        if let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) {
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 10
            
        }else {
            return false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.lblInvalidNumber.isHidden == false  {
            self.lblInvalidNumber.isHidden = true
        }
        self.viewModel.strPhoneNumber = textField.text ?? ""
            self.btnContinue.Enabled()
    }
    
    //MARK: IBAction
    @IBAction func didTapContinueBtn(_ sender: Any) {
        ApplicationManager.sharedInstance.loginAndSignupManager.callGetSmsToken(dictParams: [TenParamsNames.cellPhone: self.viewModel.strPhoneNumber], andRequestFinishedDelegate: self)
    }
    
    @IBAction func didTapContinueWithOutSignUp(_ sender: Any) {
        
       self.viewModel.moveToTenGanrelPopup()
    }
}

extension SignUpWithPhoneNumberViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getSmsToken {
            if let innerResponse = innerResponse as? GetSmsTokenResponse {
                if let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: SignUpEnterSecretSmsCodeViewController.className) as? SignUpEnterSecretSmsCodeViewController {
                    signUpVC.viewModel.strPhoneNumber = self.viewModel.strPhoneNumber
                    signUpVC.viewModel.strToken = innerResponse.token
                    
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
                 
                }
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        if request.requestName == TenRequestNames.getSmsToken {
            self.lblInvalidNumber.isHidden = false
        }
    }
}

