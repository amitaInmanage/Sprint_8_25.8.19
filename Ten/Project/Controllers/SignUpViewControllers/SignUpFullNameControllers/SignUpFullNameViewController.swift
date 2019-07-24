//
//  SignUpFullNameViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

enum TxtFldTag: Int {
    case firstName = 1
    case lastName = 2
}

class SignUpFullNameViewController: BaseFormViewController {
    
    @IBOutlet weak var txtFldFirstName: InputCustomView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldLastName: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    @IBOutlet weak var lblFirstNameError: UILabel!
    @IBOutlet weak var lblLastNameError: UILabel!
    
    var viewModel = SignUpFullNameViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
    }
    
    func initializeUI() {
        self.setupTextFields()
        self.btnContinue.Disabled()
        self.lblFirstNameError.isHidden = true
        self.lblLastNameError.isHidden = true
        
        self.mDCTextSetUp(mDCText: self.txtFldFirstName.txtFldInput, withPlaceholderText: "שם פרטי", withIndex: self.txtFldFirstName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        self.mDCTextSetUp(mDCText: self.txtFldLastName.txtFldInput, withPlaceholderText: "שם משפחה", withIndex: self.txtFldLastName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.name, Translations.Titles.nameDefault)
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.next, Translations.AlertButtonsKeys.nextDefault), for: .normal)
        self.lblFirstNameError.text = Translation(Translations.ValidationFormErros.fullNameError, Translations.ValidationFormErros.fullNameErrorDefault)
        self.lblLastNameError.text = Translation(Translations.ValidationFormErros.fullNameError, Translations.ValidationFormErros.fullNameErrorDefault)
    }
    
    fileprivate func setupTextFields() {
        self.txtFldFirstName.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldLastName.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldFirstName.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        self.txtFldLastName.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        self.txtFldFirstName.txtFldInput.tag = TxtFldTag.firstName.rawValue
        self.txtFldLastName.txtFldInput.tag = TxtFldTag.lastName.rawValue
    }
    
    //MARK: TextFieldDelegate
    @objc func textFieldDidChange(_ textField: UITextField) {

        switch textField.tag {
        case TxtFldTag.firstName.rawValue:
            self.viewModel.strFirstName = textField.text ?? ""
            lblFirstNameError.isHidden = true
        case TxtFldTag.lastName.rawValue:
            self.viewModel.strLastName = textField.text ?? ""
            lblLastNameError.isHidden = true
        default:
            break;
        }
    }
    
    @objc override func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnContinue.Enabled()
    }
    
    //MARK: IBAction
    @IBAction func didTapContinueBtn(_ sender: Any) {
        var isValid = true
        
        if !ApplicationManager.sharedInstance.inputValidationManager.isHebrewValidSingleName(name: self.viewModel.strFirstName) {
           isValid = false
            lblFirstNameError.isHidden = false
        }
        if !TenInputValidation.sharedInstance.isHebrewValidLastName(name: self.viewModel.strLastName) {
            isValid = false
            lblLastNameError.isHidden = false
        }
        if isValid {
            self.viewModel.buildJsonAndSendUpdateRegistrationData(strScreenName: self.viewModel.screenName)
        }
    }
}
