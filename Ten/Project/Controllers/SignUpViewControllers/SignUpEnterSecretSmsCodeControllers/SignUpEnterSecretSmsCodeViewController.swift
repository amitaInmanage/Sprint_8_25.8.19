//
//  SignUpEnterSecretSmsCodeViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpEnterSecretSmsCodeViewController: BaseFormViewController, MyTextFieldDelegate {
    
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var imgNewCode: UIImageView!
    @IBOutlet weak var lblSubTitle: RegularText!
    @IBOutlet weak var imgSendingCode: UIImageView!
    @IBOutlet weak var btnContectUs: TenButtonStyle!
    @IBOutlet weak var lblPhoneNumber: RegularText!
    @IBOutlet weak var lblValidCodeStatus: SemiBoldText!
    @IBOutlet var textFields: [DeleteTextField]!
    
    var viewModel = SignUpEnterSecretSmsCodeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        //TODO: delete after Test
        self.showTokenPopup()
    }
    
    //TODO: delete after Test
    fileprivate func showTokenPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .general
        popupInfoObj.strTitle = self.viewModel.strToken
        popupInfoObj.strSubtitle = "QA Test"
        popupInfoObj.strFirstButtonTitle = "ok"
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
    
    func initializeUI() {
        
        self.setupTextFields()
        
        //TODO: row for check:
        //        ApplicationManager.sharedInstance.loginAndSignupManager.callVerifySmsToken(dictParams: [TenParamsNames.token: self.viewModel.strToken, TenParamsNames.cellPhone: self.viewModel.strPhoneNumber], andRequestFinishedDelegate: self)
        
        //TODO: remove or ask about thet:
        self.viewModel.validCodeStr = self.viewModel.validCodeStr.stringByReplacingFirstOccurrenceOfString(target: "}", withString: "").stringByReplacingFirstOccurrenceOfString(target: "{", withString: "")
        
        self.lblPhoneNumber.text = self.viewModel.strPhoneNumber
        self.lblValidCodeStatus.attributedText = NSAttributedString(string: self.viewModel.validCodeStr, attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, .foregroundColor : UIColor.getApplicationThemeColor()])
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapLblValidCodeStatus))
        self.lblValidCodeStatus.isUserInteractionEnabled = true
        self.lblValidCodeStatus.addGestureRecognizer(tap)
        self.btnContectUs.setReverseColor(textColor: UIColor.getApplicationThemeColor())
        self.btnContectUs.setWhiteBackground()
    }
    
    override func fillTextWithTrans() {
        self.viewModel.validCodeStr = Translation(Translations.Titles.registercodevalidationBtnNotGetCode, Translations.Titles.registercodevalidationBtnNotGetCodeDefault)
        self.lblTitle.text = Translation(Translations.Titles.registercodevalidationSubTitle, Translations.Titles.registercodevalidationSubTitleDefault)
        self.lblSubTitle.text = Translation(Translations.Titles.registercodevalidationSubTitleCode, Translations.Titles.registercodevalidationSubTitleCodeDefault)
        self.btnContectUs.setTitle(Translation(Translations.AlertButtonsKeys.contect, Translations.AlertButtonsKeys.contectDefault), for: .normal)
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
        } else {
            self.textFields[textField.tag].resignFirstResponder()
            let txt = self.viewModel.txtArr.joined(separator: "")
            ApplicationManager.sharedInstance.loginAndSignupManager.callVerifySmsToken(dictParams: [TenParamsNames.token: txt, TenParamsNames.cellPhone: self.viewModel.strPhoneNumber], andRequestFinishedDelegate: self, vc: self)
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
    @objc func didTapLblValidCodeStatus(sender:UITapGestureRecognizer) {
        
        if !self.viewModel.isInProgress {
            self.viewModel.isInProgress = true
            self.changeCodeStateView(isSending: true)
            ApplicationManager.sharedInstance.loginAndSignupManager.callGetSmsToken(dictParams: [TenParamsNames.cellPhone: self.viewModel.strPhoneNumber], andRequestFinishedDelegate: self, vc:  self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
                self.changeCodeStateView(isSending: false)
                //TODO: Delete show popup after QA
                self.showTokenPopup()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.imgNewCode.isHidden = true
                    self.lblValidCodeStatus.attributedText = NSAttributedString(string: self.viewModel.validCodeStr, attributes:
                        [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, .foregroundColor : UIColor.getApplicationThemeColor()])
                    self.viewModel.isInProgress = false
                }
            }
        }
    }
    
    private func changeCodeStateView(isSending: Bool) {
        if isSending {
            self.lblValidCodeStatus.text = Translation(Translations.Titles.registercodevalidationSendNewCode, Translations.Titles.registercodevalidationSendNewCodeDefault)
            
            self.lblValidCodeStatus.textColor = UIColor.getApplicationThemeColor()
            
            self.imgSendingCode.image = UIImage(named: "sending")
            self.imgSendingCode.isHidden = false
        } else {
            self.lblValidCodeStatus.text = Translation(Translations.Titles.registercodevalidationSendNewCodeSuccess, Translations.Titles.registercodevalidationSendNewCodeSuccessDefault)
            self.lblValidCodeStatus.textColor = UIColor.getApplicationThemeColor()
            self.imgSendingCode.isHidden = true
            self.imgNewCode.image = UIImage(named: "done")
            self.imgNewCode.isHidden = false
        }
    }
    
    @IBAction func didTapTextFields(_ sender: Any) {
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
    
    @IBAction func didTapContectUsBtn(_ sender: Any) {
        //TODO: send to Customer Service with massage : לא מצליח להתחבר לאפליקציה
    }
}

extension SignUpEnterSecretSmsCodeViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getVerifySmsToken {
            
            if let innerResponse = innerResponse as? VerifySmsTokenResponse {
                
                ApplicationManager.sharedInstance.userAccountManager.arrScreens = [ScreenName]()
                
                if innerResponse.userExists {
                    
                    if let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainScreenViewController.className) as? MainScreenViewController {
                        main.user = ApplicationManager.sharedInstance.userAccountManager.user
                        ApplicationManager.sharedInstance.navigationController.pushTenViewController(main, animated: true)
                    }
                } else {
                    ApplicationManager.sharedInstance.userAccountManager.updateScreensAndRegistrationToken(registrationToken: innerResponse.registrationToken, screens: innerResponse.nextScreenArr)
                }
            }
        }
        
        //TODO: Delete this request afetr test!
        if request.requestName == TenRequestNames.getSmsToken {
            
            if let innerResponse = innerResponse as? GetSmsTokenResponse {
                self.viewModel.strToken = innerResponse.token
                
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        self.lblSubTitle.isHidden = true
        self.lblPhoneNumber.isHidden = true
        self.lblValidCodeStatus.textColor = UIColor.getApllicationErrorColor()
        self.lblValidCodeStatus.text = Translation(Translations.Titles.identificationCodeError, Translations.Titles.identificationCodeErrorDefault)
        self.lblTitle.text = Translation(Translations.Titles.registercodevalidationSubTitleCode, Translations.Titles.registercodevalidationSubTitleCodeDefault)
    }
}
