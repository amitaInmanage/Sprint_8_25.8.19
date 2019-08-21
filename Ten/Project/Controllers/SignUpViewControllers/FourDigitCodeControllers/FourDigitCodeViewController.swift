//
//  FourDigitCodeViewController.swift
//  Ten
//
//  Created by aviv-inmanage on 26/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class FourDigitCodeViewController: BaseViewController, MyTextFieldDelegate {
    
    enum States : Int {
        case createPassword = 1
        case validatePassword = 2
        case sendRequest = 3
        case verify = 4
        case changePassword = 5
        case validateChangePassword = 6
    }
    
    @IBOutlet weak var txtFldOTP4: DeleteTextField!
    @IBOutlet weak var txtFldOTP3: DeleteTextField!
    @IBOutlet weak var txtFldOTP2: DeleteTextField!
    @IBOutlet weak var txtFldOTP1: DeleteTextField!
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var lblSubTitle: RegularText!
    @IBOutlet weak var btnSkip: MediumButton!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    @IBOutlet var textFields: [DeleteTextField]!
    
    var user = TenUser()
    var viewModel = FourDigitCodeViewModel()
    var hesPinCode = true
    var changePassword = true
    var state = Box<States>(States.createPassword)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
    }
    
    fileprivate func initializeUI() {
        self.initializeBindings()
        self.setupTextFields()
        self.btnContinue.Disabled()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.security, Translations.Titles.securityDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.securityPinCode, Translations.SubTitles.securityPinCodeDefault)
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.next, Translations.AlertButtonsKeys.nextDefault), for: .normal)
        self.hesPinCode ? (self.btnSkip.isHidden = false) : (self.btnSkip.isHidden = true)
        
        if self.changePassword == true {
            self.btnSkip.isHidden = false
            
        } else {
            self.btnSkip.isHidden = true
            self.lblTitle.text = Translation(Translations.Titles.verifyMyPassword, Translations.Titles.verifyMyPasswordDefault)
            self.lblSubTitle.isHidden = true
            state.value = .verify
        }
        self.btnSkip.addUnderline(title: Translation(Translations.AlertButtonsKeys.onboardingSkip, Translations.AlertButtonsKeys.onboardingSkipDefault))
    }
    
    fileprivate func updateChangePasswordUI() {
        if state.value == .changePassword {
            self.lblTitle.text = Translation(Translations.Titles.security, Translations.Titles.securityDefault)
            self.lblSubTitle.text = Translation(Translations.SubTitles.securityPinCode, Translations.SubTitles.securityPinCodeDefault)
            self.lblSubTitle.isHidden = false
            self.btnSkip.isHidden = true
            
            for textField in self.textFields {
                self.viewModel.code.append(textField.text ?? "")
                textField.text = ""
            }
            
            self.viewModel.txtArr = []
            self.viewModel.code = []
            self.textFields[0].becomeFirstResponder()
            self.btnContinue.Disabled()
        } else if state.value == .validateChangePassword {
            
            self.lblTitle.text = Translation(Translations.Titles.verifyPinCode, Translations.Titles.verifyPinCodeDefault)
            self.lblSubTitle.text = Translation(Translations.SubTitles.verifyPinCode, Translations.SubTitles.verifyPinCodeDefault)
            self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.endButton, Translations.AlertButtonsKeys.endButtonDefault), for: .normal)
            
            for textField in self.textFields {
                self.viewModel.code.append(textField.text ?? "")
                textField.text = ""
            }
            
            self.viewModel.txtArr = []
            self.textFields[0].becomeFirstResponder()
            self.btnContinue.Disabled()
        }
    }
    
    fileprivate func updateUI() {
        if state.value == .createPassword {
            
        } else if state.value == .validatePassword {
            self.lblTitle.text = Translation(Translations.Titles.verifyPinCode, Translations.Titles.verifyPinCodeDefault)
            self.lblSubTitle.text = Translation(Translations.SubTitles.verifyPinCode, Translations.SubTitles.verifyPinCodeDefault)
            self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.endButton, Translations.AlertButtonsKeys.endButtonDefault), for: .normal)
            
            for textField in self.textFields {
                self.viewModel.code.append(textField.text ?? "")
                textField.text = ""
            }
            
            self.viewModel.txtArr = []
            self.viewModel.code.remove(at: 0)
            self.textFields[0].becomeFirstResponder()
            self.btnContinue.Disabled()
        }
        
    }
    
    fileprivate func validatePassword() -> Bool {
        if viewModel.isCheckValidation {
            if self.viewModel.txtArr == self.viewModel.code {
                self.viewModel.strPinCode = self.viewModel.txtArr.joined(separator: "")
                return true
            } else {
                self.lblSubTitle.textColor = UIColor.red
                self.lblSubTitle.text = Translation(Translations.SubTitles.verifyPinCodeError, Translations.SubTitles.verifyPinCodeErrorDefault)
                return false
            }
        } else {
            return true
        }
    }
    
    fileprivate func setupTextFields() {
        for textField in self.textFields {textField.addTarget(self, action: #selector(textFieldDidChange(_:replacementString:)), for: .editingChanged)}
        for textField in self.textFields {textField.myDelegate = self}
        for textField in self.textFields {textField.keyboardType = UIKeyboardType.numberPad}
        for textField in self.textFields { self.addBottomBorderTo(textField: textField)}
        for (index, element) in self.textFields.enumerated() {
            element.tag = index
        }
    }
    
    //MARK: TextFieldDelegate
    func textFieldDidDelete(textField: UITextField) {
        self.btnContinue.Disabled()
        if textField.tag == self.textFields.first?.tag {
            if textField.text?.count == 0 {
                textField.becomeFirstResponder()
            }
        } else {
            self.viewModel.txtArr.removeLast()
            if textField.tag != self.textFields.last?.tag {
                if textField.text?.count == 0 {
                    self.textFields[textField.tag - 1].becomeFirstResponder()
                    self.textFields[textField.tag - 1].text = ""
                }
            } else {
                if textField.text?.count == 0 {
                    self.textFields[textField.tag - 1].becomeFirstResponder()
                    self.textFields[textField.tag - 1].text = ""
                } else {
                    textField.text = ""
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField, replacementString string: String) -> Bool  {
        if let txt = textField.text {
            self.viewModel.txtArr.append(txt)
        }
        if textField.tag != self.textFields.last?.tag {
            self.textFields[textField.tag + 1].becomeFirstResponder()
            self.btnContinue.Disabled()
        } else {
            self.textFields[textField.tag].resignFirstResponder()
            self.btnContinue.Enabled()
        }
        return true
    }
    
    func addBottomBorderTo(textField:UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 18.0, width: textField.frame.size.width, height: 1.0)
        textField.layer.addSublayer(layer)
    }
    
    //MARK: IBAction
    @IBAction func didTapTxtFld(_ sender: Any) {
        if self.viewModel.txtArr.count == self.textFields.count {
            if !(self.textFields.last?.isFirstResponder ?? false) {
                self.textFields.last?.becomeFirstResponder()
            }
        } else if self.viewModel.txtArr.count == 0 {
            if !(self.textFields.first?.isFirstResponder ?? false) {
                self.textFields.first?.becomeFirstResponder()
            }
        } else {
            if !(self.textFields[self.viewModel.txtArr.count].isFirstResponder) {
                self.textFields[self.viewModel.txtArr.count].becomeFirstResponder()
            }
        }
    }
    
    fileprivate func initializeBindings() {
        if !self.changePassword {
            self.state.value = .verify
        } else {
            self.state.bind { [unowned self] (newVal) in
                switch self.state.value{
                    
                case .createPassword:
                    self.viewModel.isCheckValidation = false
                    break
                    
                case .validatePassword:
                    self.viewModel.isCheckValidation = true
                    self.updateUI()
                    break
                    
                case .sendRequest:
                    self.viewModel.buildJsonAndSendEditUserInformation(vc: self)
                case .verify:
                    
                    break
                case .changePassword:
                    self.updateChangePasswordUI()
                    
                case .validateChangePassword:
                    self.viewModel.isCheckValidation = true
                    self.updateChangePasswordUI()
                }
            }
        }
    }
    
    @IBAction func didTapSkip(_ sender: Any) {
        //TODO: send to main screen
    }
    
    @IBAction func didTapContinue(_ sender: Any, id: Any?) {
        
        if self.validatePassword() {
            switch self.state.value {
                
            case .createPassword:
                self.state.value = .validatePassword
                
            case .validatePassword:
                self.state.value = .sendRequest
                
            case .verify:
                self.viewModel.strPinCode = self.viewModel.txtArr.joined(separator: "")
                self.viewModel.buildJsonAndSendVerifyPinCode(vc: self)
                
            case .changePassword:
                self.state.value = .validateChangePassword
                self.viewModel.isCheckValidation = true
                self.updateChangePasswordUI()
                
            case .validateChangePassword:
                self.viewModel.buildJsonAndSendEditUserInformation(vc: self)
                
            default:
                break
            }
        }
    }
}

extension FourDigitCodeViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getEditUserInformation {
            if let SignUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpPasswordCreatedSuccessfullyViewController.className) as? SignUpPasswordCreatedSuccessfullyViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(SignUpVC, animated: true)
            }
        }
        if request.requestName == TenRequestNames.getVerifyPinCode {
            self.changePassword = true
            self.state.value = .changePassword
            self.updateChangePasswordUI()
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}
