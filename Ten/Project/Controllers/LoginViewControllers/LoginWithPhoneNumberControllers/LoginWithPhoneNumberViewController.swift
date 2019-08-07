//
//  LoginWithPhoneNumberViewController.swift
//  Ten
//
//  Created by inmanage on 27/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class LoginWithPhoneNumberViewController: BaseFormViewController {
    
    @IBOutlet weak var phoneNumber: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    @IBOutlet weak var lblInvalidNumber: UILabel!
    @IBOutlet weak var btnContinueWithoutRegistering: IMButton!
    @IBOutlet weak var btnSignUpConstreint: NSLayoutConstraint!
    
    var viewModel = LoginWithPhoneNemberViewModel()
    var keyboardH: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.viewModel.baseViewModelDataFetchProtocolToController = self
        self.initializeTextFields()
        self.initializeStatusButtonAndLable()
        
        
      
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideBackBtn()
        self.moveBtns()
    }
    
    private func moveBtns() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        btnSignUpConstreint.constant = btnSignUpConstreint.constant - keyboardH
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillShow (_ notification: Notification) {
        if self.keyboardH == 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                self.keyboardH = keyboardRectangle.height
            }
        }
        if btnSignUpConstreint.constant < keyboardH {
            btnSignUpConstreint.constant = btnSignUpConstreint.constant + keyboardH
            self.view.layoutIfNeeded()
        }
    }

    fileprivate func initializeStatusButtonAndLable() {
        self.btnContinue.Disabled()
        self.lblInvalidNumber.isHidden = true
        self.btnContinueWithoutRegistering.addUnderline()
    }
    
    fileprivate func initializeTextFields() {
        self.phoneNumber.txtFldInput.keyboardType = UIKeyboardType.numberPad
        self.mDCTextSetUp(mDCText: self.phoneNumber.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carInforamtionClubeLicense, Translations.Placeholders.carInforamtionClubeLicenseDefault), withIndex: self.phoneNumber.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        phoneNumber.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func btnContinue(_ sender: Any) {
  
    }

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
        self.viewModel.strPhoneNumber = textField.text ?? ""
        
        if self.viewModel.validatePhoneNumber() {
            self.lblInvalidNumber.isHidden = true
            self.btnContinue.Enabled()
        } else {
            self.btnContinue.Disabled()
        }
    }
    
    //IBACtion:
    @IBAction func didTapContinueWithoutRegitering(_ sender: Any) {
        //push to homepage without regitering
    }
    
    @IBAction func didTapContinueBtn(_ sender: Any) {
        if self.viewModel.validatePhoneNumber() {
            self.lblInvalidNumber.isHidden = true
        }else {
            self.lblInvalidNumber.isHidden = false
            return
        }
        //validate phone number
        //if no validate show lblInvalidNumber
        //if validate and exists in the system - puse to next signUp screen
    }
}

extension LoginWithPhoneNumberViewController {
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
