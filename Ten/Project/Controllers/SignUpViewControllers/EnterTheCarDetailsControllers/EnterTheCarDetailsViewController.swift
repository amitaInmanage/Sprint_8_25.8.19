//
//  EnterTheCadDetailsViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class EnterTheCarDetailsViewController: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case cardNumber = 1
        case cardSecret = 2
    }
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    @IBOutlet weak var btnForgotPass: MediumButton!
    @IBOutlet weak var txtFldSecretCode: InputCustomView!
    @IBOutlet weak var txtFldTenNumberCard: InputCustomView!
    
    var viewModel = EnterTheCarDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
    }
    
    func initializeUI() {
        self.setupTextFields()
        self.btnContinue.Disabled()
        self.btnForgotPass.tintColor = UIColor.getHighlightedTextColor()
        self.mDCTextSetUp(mDCText: self.txtFldTenNumberCard.txtFldInput, withPlaceholderText: "מספר כרטיס", withIndex: self.txtFldTenNumberCard.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: "Error")
        txtFldSecretCode.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.mDCTextSetUp(mDCText: self.txtFldSecretCode.txtFldInput, withPlaceholderText: "קוד סודי", withIndex: self.txtFldSecretCode.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: "Error")
        txtFldTenNumberCard.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.carDetailsSubTitle, Translations.Titles.carDetailsSubTitleDefault)
        self.btnForgotPass.addUnderline(title: Translation(Translations.AlertButtonsKeys.forgotPass, Translations.AlertButtonsKeys.forgotPasseDefault))
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.next, Translations.AlertButtonsKeys.nextDefault), for: .normal)
    }
    
    fileprivate func setupTextFields() {
        self.txtFldTenNumberCard.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldSecretCode.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldTenNumberCard.txtFldInput.tag = TxtFldTag.cardNumber.rawValue
        self.txtFldSecretCode.txtFldInput.tag = TxtFldTag.cardSecret.rawValue
    }
    
    //MARK: TextFieldDelegate
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case TxtFldTag.cardNumber.rawValue:
            self.viewModel.strFuilingCard = textField.text ?? ""
        case TxtFldTag.cardSecret.rawValue:
            self.viewModel.strSecretCode = textField.text ?? ""
        default:
            break;
        }
        if self.viewModel.validatePassword(strSecretCode: self.viewModel.strSecretCode) &&
            self.viewModel.validateTenCard(strFuilingCard: self.viewModel.strFuilingCard) {
            self.btnContinue.Enabled()
        } else {
            self.btnContinue.Disabled()
        }
    }
    
    //MARK: IBAction:
    @IBAction func didTapForgotPass(_ sender: Any) {
        //TODO: Send to connect with : קוד סודי
    }
    
    @IBAction func didTapContinueBtn(_ sender: Any) {
        if ApplicationManager.sharedInstance.userAccountManager.registrationToken.isEmpty {
            self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
        } else {
            self.viewModel.buildJsonAndSendUpdateRegistrationData(strScreenName: self.viewModel.screenName, vc: self)
        }
    }
    
    @IBAction func didTapToolTipCardNumber(_ sender: Any) {
        self.viewModel.moveToToolTipsPopup()
    }
    
    @IBAction func didTapToolTipSecretCode(_ sender: Any) {
        //TODO: get the real details popup
        self.viewModel.moveToToolTipsPopup()
    }
}

extension EnterTheCarDetailsViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getUpdateRegistrationData {
            if let innerResponse = innerResponse as? UpdateRegistrationDataResponse {
                ApplicationManager.sharedInstance.userAccountManager.updateScreensAndRegistrationToken(registrationToken: nil, screens: innerResponse.arrNextScreens)
            }
        }
    }

    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        if request.requestName == TenRequestNames.getUpdateRegistrationData {
             if outerResponse.errorResponse.numID == self.viewModel.blockCard {
                self.viewModel.moveToBlockedPopup()
            }
        }
    }
}
