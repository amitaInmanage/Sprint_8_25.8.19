//
//  AddPowerCardViewController.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class AddPowerCardViewController: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case idNumber = 1
        case codeNumber = 2
    }
    
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var txtFldId: InputCustomView!
    @IBOutlet weak var txtFldPinCode: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    
    var viewModel = AddPowerCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.setupTextFields()
    }
    
    fileprivate func initUI() {
        
        self.mDCTextSetUp(mDCText: self.txtFldId.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.powercardConnectId, Translations.Placeholders.powercardConnectIdDefault), withIndex: self.txtFldId.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldPinCode.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.powercardConnectPinCode, Translations.Placeholders.powercardConnectPinCodeDefault), withIndex: self.txtFldPinCode.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
    }
    
    fileprivate func setupTextFields() {
        self.txtFldId.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldPinCode.txtFldInput.addTarget(self, action: #selector(secondTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
          self.viewModel.strIdNumber = textField.text ?? ""
    
    }
    
     @objc func secondTextFieldDidChange(_ textField: UITextField) {
        self.viewModel.strPinCode = textField.text ?? ""
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.powercardConnect, Translations.Titles.powercardConnectDefault)
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.btnConfirm, Translations.AlertButtonsKeys.btnConfirmDefault), for: .normal)
    }
    
    //Mark - IBAction
    
    @IBAction func didTapToolTip(_ sender: Any) {
        self.viewModel.moveToToolTipPopup()
    }
    
    @IBAction func didTapBtnContinue(_ sender: Any) {
        
        let dict = [addPowerCard.cardId: self.viewModel.strIdNumber, addPowerCard.pinCode: self.viewModel.strPinCode]
        
        ApplicationManager.sharedInstance.userAccountManager.callAddPowerCard(dictParams: dict, requestFinishedDelegate: nil)
    }
}


