//
//  SignUpTenClientViewController.swift
//  Ten
//
//  Created by inmanage on 30/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpTenClientViewController: BaseFormViewController {

    enum TxtFldTag: Int {
        case idNumber = 1
        case carNumber = 2
    }
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var txtFldAuthorizedDealer: InputCustomView!
    @IBOutlet weak var txtFldCarNumber: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    
    var viewModel = SignUpTenClientViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
    }

    func initializeUI() {
        self.btnContinue.Disabled()
        self.setupTextFields()
        self.mDCTextSetUp(mDCText: self.txtFldAuthorizedDealer.txtFldInput, withPlaceholderText: "מספר ח.פ / עוסק מורשה", withIndex: self.txtFldAuthorizedDealer.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        self.mDCTextSetUp(mDCText: self.txtFldCarNumber.txtFldInput, withPlaceholderText: "מספר רכב", withIndex: self.txtFldCarNumber.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
    }
    
    override func fillTextWithTrans() {
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.next, Translations.AlertButtonsKeys.nextDefault), for: .normal)
        self.lblTitle.text = Translation(Translations.Titles.tenClient, Translations.Titles.tenClientDefault)
    }
    
    fileprivate func setupTextFields() {
        self.txtFldAuthorizedDealer.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldCarNumber.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldAuthorizedDealer.txtFldInput.tag = TxtFldTag.idNumber.rawValue
        self.txtFldCarNumber.txtFldInput.tag = TxtFldTag.carNumber.rawValue
    }
    
    //MARK: TextFieldDelegate
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case TxtFldTag.idNumber.rawValue:
            self.viewModel.strBusinessId = textField.text ?? ""
        case TxtFldTag.carNumber.rawValue:
            self.viewModel.strLicensePlate = textField.text ?? ""
        default:
            break;
        }
        if self.viewModel.validateBusinessId(strBusinessId: self.viewModel.strBusinessId) &&
            self.viewModel.validateLicensePlat(strLicensePlate: self.viewModel.strLicensePlate){
            self.btnContinue.Enabled()
        } else {
            self.btnContinue.Disabled()
        }
    }
    
    //MARK: IBAction
    @IBAction func didTapContinueBtn(_ sender: Any) {
        self.viewModel.buildJsonAndSendUpdateRegistrationData(strScreenName: self.viewModel.screenName)
    }
    
    @IBAction func didTapAuthorizedDealerToolTip(_ sender: Any) {
        self.viewModel.moveToToolTipsPopup()
    }
}
