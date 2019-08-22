//
//  PersonalDetailsViewControlles.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import UserNotifications


class PersonalDetailsViewControlles: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case firstName = 1
        case lastName = 2
        case gander = 3
        case phoneNumber = 4
        case email = 5
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var txtFldFirstName: InputCustomView!
    @IBOutlet weak var txtFldLastName: InputCustomView!
    @IBOutlet weak var txtFldPhone: InputCustomView!
    @IBOutlet weak var txtFldEmail: InputCustomView!
    @IBOutlet weak var lblNotafication: SmallText!
    @IBOutlet weak var bottomView: RegularText!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblSecurityManager: RegularText!
    @IBOutlet weak var btnSaveChanges: TenButtonStyle!
    @IBOutlet weak var lblGender: RegularText!
    @IBOutlet weak var tableDropDown: UITableView!
    @IBOutlet weak var tableDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var lblFirstNameError: ErrorText!
    @IBOutlet weak var lblLastNameError: ErrorText!
    @IBOutlet weak var lblEmailError: ErrorText!
    
    var keys = [Int]()
    var values = [String]()
    var viewModel = PersonalDetailsViewModel()
    var genserArr = ApplicationManager.sharedInstance.appGD.genderArr
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var isTableVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.setupTextFields()
        self.initTextField()
        self.initCheckBox()
    }
    
    override func fillTextWithTrans() {
        self.lblEmailError.text = Translation(Translations.ValidationFormErros.fullNameError, Translations.ValidationFormErros.fullNameErrorDefault)
        self.lblTitle.text = Translation(Translations.Titles.editPersonal, Translations.Titles.editPersonalDefault)
        self.lblNotafication.text = Translation(Translations.AlertButtonsKeys.editPersonalInformation, Translations.AlertButtonsKeys.editPersonalInformationDefault)
        self.lblSecurityManager.text = Translation(Translations.AlertButtonsKeys.securityMenagement, Translations.AlertButtonsKeys.securityMenagementDefault)
        self.lblFirstNameError.text = Translation(Translations.ValidationFormErros.fullNameError, Translations.ValidationFormErros.fullNameErrorDefault)
        self.lblLastNameError.text = Translation(Translations.ValidationFormErros.fullNameError, Translations.ValidationFormErros.fullNameErrorDefault)
        self.btnSaveChanges.setTitle(Translation(Translations.AlertButtonsKeys.delekTenChooseProgram, Translations.AlertButtonsKeys.delekTenChooseProgramDefault), for: .normal)
        self.lblSecurityManager.textColor = UIColor.getApplicationTextColor()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        self.fullScreeen(parent: parent)
    }
    
    fileprivate func initUI() {
        self.lblFirstNameError.isHidden = true
        self.lblLastNameError.isHidden = true
        self.lblEmailError.isHidden = true
        self.btnSaveChanges.isHidden = true
        self.view.backgroundColor = .clear
        self.contentView.addShadow()
        self.bottomView.addShadow()
        self.tableDropDownHC.constant = 0
        self.tableDropDown.layer.masksToBounds = true
        self.tableDropDown.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.tableDropDown.layer.borderWidth = 2.0
    }
    
    fileprivate func initCheckBox() {
        if user.isAcceptsUpdates {
            self.imgCheckBox.image = UIImage(named: "checkBoxOn")
        } else {
            self.imgCheckBox.image = UIImage(named: "checkBoxOff")
        }
    }
    
    func initTextField() {
        self.txtFldFirstName.txtFldInput.text  = user.strFirstName
        self.txtFldLastName.txtFldInput.text = user.strLastName
        self.txtFldPhone.txtFldInput.text = user.strPhoneNumber
        self.txtFldEmail.txtFldInput.text = user.strEmail
        
        if user.strGender == "0" {
            self.lblGender.text = Translation(Translations.AlertButtonsKeys.gender, Translations.AlertButtonsKeys.genderDefault)
        } else {
            self.viewModel.intGenderId = Int(user.strGender) ?? 0
            self.lblGender.text = genserArr[user.strGender] as? String
        }
        
        self.mDCTextSetUp(mDCText: self.txtFldFirstName.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.registerNameFirstName, Translations.Placeholders.registerNameFirstNameDefault), withIndex: self.txtFldFirstName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldLastName.txtFldInput, withPlaceholderText:Translation(Translations.Placeholders.registerNameLastName, Translations.Placeholders.registerNameLastNameDefault), withIndex: self.txtFldLastName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldPhone.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.phone, Translations.Placeholders.phoneDefault), withIndex: self.txtFldPhone.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        if user.strEmail.isEmpty {
            self.mDCTextSetUp(mDCText: self.txtFldEmail.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.email, Translations.Placeholders.emailDefault), withIndex: self.txtFldEmail.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        } else {
            self.mDCTextSetUp(mDCText: self.txtFldEmail.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.insertYourEmailAddress, Translations.Placeholders.insertYourEmailAddressDefault), withIndex: self.txtFldEmail.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
            self.txtFldEmail.txtFldInput.text  = user.strEmail
        }
        
        
    }
    
    fileprivate func setupTextFields() {
        txtFldPhone.isUserInteractionEnabled = false
        self.txtFldFirstName.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        self.txtFldLastName.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        self.txtFldEmail.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        
        self.txtFldFirstName.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldLastName.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldEmail.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.txtFldFirstName.txtFldInput.tag = TxtFldTag.firstName.rawValue
        self.txtFldLastName.txtFldInput.tag = TxtFldTag.lastName.rawValue
        self.txtFldEmail.txtFldInput.tag = TxtFldTag.email.rawValue
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        switch textField.tag {
        case TxtFldTag.firstName.rawValue:
            self.txtFldFirstName.txtFldInput.text = textField.text ?? ""
            self.lblFirstNameError.isHidden = true
        case TxtFldTag.lastName.rawValue:
            self.txtFldLastName.txtFldInput.text = textField.text ?? ""
            self.lblLastNameError.isHidden = true
        case TxtFldTag.email.rawValue:
            self.lblEmailError.isHidden = true
            self.txtFldEmail.txtFldInput.text = textField.text ?? ""
        default:
            break;
        }
    }
    
    @objc override func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnSaveChanges.isHidden = false
    }
    
    //IBAction:
    @IBAction func didTapNotafication(_ sender: Any) {
        if self.imgCheckBox.image == UIImage(named: "checkBoxOff") {
            UIView.animate(withDuration: 0.3) {
                self.imgCheckBox.image = UIImage(named: "checkBoxOn")
                self.btnSaveChanges.isHidden = false
                self.viewModel.isAcceptsUpdates = true
                self.view.layoutIfNeeded()
                
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.imgCheckBox.image = UIImage(named: "checkBoxOff")
                self.btnSaveChanges.isHidden = false
                self.viewModel.isAcceptsUpdates = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func didTapGender(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            if self.isTableVisible == false {
                self.tableDropDownHC.constant = 44.0 * 2.0
                self.imgDropDown.image = UIImage(named: "up")
                self.isTableVisible = true
            } else {
                self.tableDropDownHC.constant = 0
                self.imgDropDown.image = UIImage(named: "down")
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func didTapSecurityManager(_ sender: Any) {
        
        if self.btnSaveChanges.isHidden == true {
            if let personalSecurity = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: SecurityManagmentViewController.className) as? SecurityManagmentViewController {
                
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalSecurity, animated: true)
            }
        } else {
            let popupInfoObj = PopupInfoObj()
            popupInfoObj.popupType = .exit
            popupInfoObj.strTitle = Translation(Translations.Titles.editPersonalInformationPopup, Translations.Titles.editPersonalInformationPopupDefault)
            popupInfoObj.strSkipButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardNo, Translations.AlertButtonsKeys.popupRemoveFuelingCardNoDefault)
            popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardYes, Translations.AlertButtonsKeys.popupRemoveFuelingCardYesDefault)
            
            popupInfoObj.firstButtonAction = {
                
                if let personalSecurity = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: SecurityManagmentViewController.className) as? SecurityManagmentViewController {
                    
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalSecurity, animated: true)
                }
            }
            ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        }
    }
    
    @IBAction func didTapSaveChange(_ sender: Any) {
        
        var isValid = true
        
        if !ApplicationManager.sharedInstance.inputValidationManager.isHebrewValidSingleName(name: self.txtFldFirstName.txtFldInput.text!) {
            isValid = false
            self.lblFirstNameError.isHidden = false
        }
        if !TenInputValidation.sharedInstance.isHebrewValidLastName(name: self.txtFldLastName.txtFldInput.text!) {
            isValid = false
            self.lblLastNameError.isHidden = false
        }
        if self.txtFldEmail.txtFldInput.text == "" {
            isValid = true
            self.lblEmailError.isHidden = true
            
        } else {
            if !ApplicationManager.sharedInstance.inputValidationManager.isValidEmail(emailStr: self.txtFldEmail.txtFldInput.text!) {
                isValid = false
                self.lblEmailError.isHidden = false
            } else {
                isValid = true
                self.lblEmailError.isHidden = true
            }
        }
        
        if isValid {
            self.viewModel.strFirstName = self.txtFldFirstName.txtFldInput.text!
            self.viewModel.strLastName  = self.txtFldLastName.txtFldInput.text!
            self.viewModel.strEmail  = self.txtFldEmail.txtFldInput.text!
            
            if  self.imgCheckBox.image == UIImage(named: "checkBoxOn") {
                self.viewModel.isAcceptsUpdates = true
            } else if  self.imgCheckBox.image == UIImage(named: "checkBoxOff") {
                self.viewModel.isAcceptsUpdates = false
            }
            
            self.viewModel.strCurrentEmail = user.strEmail
            self.viewModel.buildJsonAndSendEditUserInformation(vc: self)
        }
    }
}


extension PersonalDetailsViewControlles {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getEditUserInformation {
            
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PersonalZoneViewController.className) as? PersonalZoneViewController {
                
                personalZone.user = self.user
                
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        if request.requestName == TenRequestNames.getEditUserInformation {
            
        }
    }
}

//MARK: UITableView delegate And DataSource
extension PersonalDetailsViewControlles: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genserArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableDropDown.dequeueReusableCell(withIdentifier: "selecteGenderUITableViewCell")
        
        for key in self.genserArr.keys {
            let tempKey = Int(key)
            keys.append(tempKey ?? 0)
        }
        
        for value in self.genserArr.values {
            let tempValue = String(describing: value)
            values.append(tempValue)
        }
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "selecteGenderUITableViewCell")
        }
        
        cell?.textLabel?.text = values[indexPath.row]
        cell?.textLabel?.font = UIFont(name: LightLabel.getFontName(), size: 16)
        cell?.textLabel?.textAlignment = .right
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.viewModel.intGenderId = keys[indexPath.row]
        self.lblGender.text = values[indexPath.row]
        
        UIView.animate(withDuration: 0.3) {
            self.tableDropDownHC.constant = 0
            self.btnSaveChanges.isHidden = false
            self.imgDropDown.image = UIImage(named: "down")
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
    }
}
