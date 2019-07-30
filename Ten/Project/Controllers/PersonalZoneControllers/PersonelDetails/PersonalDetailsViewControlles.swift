//
//  PersonalDetailsViewControlles.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import iOSDropDown

class PersonalDetailsViewControlles: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case firstName = 1
        case lastName = 2
        case gander = 3
        case phoneNumber = 4
        case email = 5
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: IMLabel!
    @IBOutlet weak var txtFldFirstName: InputCustomView!
    @IBOutlet weak var txtFldLastName: InputCustomView!
    @IBOutlet weak var txtFldPhone: InputCustomView!
    @IBOutlet weak var txtFldEmail: InputCustomView!
    @IBOutlet weak var btnNotafication: IMButton!
    @IBOutlet weak var lblNotafication: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblSecurityManager: IMLabel!
    @IBOutlet weak var btnSaveChanges: TenButtonStyle!
    @IBOutlet weak var lblGender: IMLabel!
    @IBOutlet weak var tableDropDown: UITableView!
    @IBOutlet weak var tableDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var imgDropDown: UIImageView!
    
    var keys = [Int]()
    var values = [String]()
    var viewModel = PersonalDetailsViewModel()
    var button: PersonalDetailsBottomButton?
    var genserArr = ApplicationManager.sharedInstance.appGD.genderArr
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var isTableVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.setupTextFields()
        self.initTextField()
        self.initLable()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
            vc.containerView.backgroundColor = UIColor.groupTableViewBackground
            vc.containerView = nil
            let mysubView: PersonalDetailsBottomButton = PersonalDetailsBottomButton()
            self.view.addSubview(mysubView)
        }
    }
    
    fileprivate func initLable() {
        lblGender.font = UIFont(name: LightLabel.getFontName(), size: 16)
    }
    
    fileprivate func initUI() {
        
        self.btnSaveChanges.isHidden = true
        self.view.backgroundColor = .clear
        self.contentView.addShadow()
        self.bottomView.addShadow()
        self.tableDropDown.addShadow()
        self.tableDropDownHC.constant = 0
   
    }
    
    func initTextField() {
        self.txtFldFirstName.txtFldInput.text  = user.strFirstName
        self.txtFldLastName.txtFldInput.text = user.strLastName
        self.txtFldPhone.txtFldInput.text = user.strPhoneNumber
        
        self.mDCTextSetUp(mDCText: self.txtFldFirstName.txtFldInput, withPlaceholderText: "שם פרטי", withIndex: self.txtFldFirstName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldLastName.txtFldInput, withPlaceholderText: "שם משפחה", withIndex: self.txtFldLastName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldPhone.txtFldInput, withPlaceholderText: "טלפון", withIndex: self.txtFldPhone.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        
        if user.strEmail.isEmpty {
            self.mDCTextSetUp(mDCText: self.txtFldEmail.txtFldInput, withPlaceholderText: "אנא הזן את כתובת המייל שלך", withIndex: self.txtFldEmail.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        } else {
            self.mDCTextSetUp(mDCText: self.txtFldEmail.txtFldInput, withPlaceholderText: "דוא׳׳ל", withIndex: self.txtFldEmail.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
            self.txtFldEmail.txtFldInput.text  = user.strEmail
        }
        //TODO: Add gander
    }
    
    fileprivate func setupTextFields() {
        txtFldPhone.isUserInteractionEnabled = false
        self.txtFldFirstName.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        self.txtFldLastName.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        self.txtFldEmail.txtFldInput.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        
    }
    
    @objc override func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnSaveChanges.isHidden = false
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.editPersonalInformation, Translations.Titles.editPersonalInformationDefault)
        self.lblSecurityManager.text = Translation(Translations.AlertButtonsKeys.securityMenagement, Translations.AlertButtonsKeys.securityMenagementDefault)
        self.lblSecurityManager.textColor = UIColor.getApplicationTextColor()
    }
    
    //IBAction:
    @IBAction func didTapBtnNotafication(_ sender: Any) {
        
        
    }
    
    @IBAction func didTapGender(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            if self.isTableVisible == false {
                self.tableDropDownHC.constant = 44.0 * 2.0
                self.imgDropDown.image = UIImage(named: "up")
                self.isTableVisible = true
            } else {
                self.imgDropDown.image = UIImage(named: "down")
                self.tableDropDownHC.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func didTapSecurityManager(_ sender: Any) {
        if let personalSecurity = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: SecurityManagmentViewController.className) as? SecurityManagmentViewController {
            
            ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalSecurity, animated: true)
        }
    }
    
    @IBAction func didTapSaveChange(_ sender: Any) {
        
        self.viewModel.strFirstName = self.txtFldFirstName.txtFldInput.text!
        self.viewModel.strLastName  = self.txtFldLastName.txtFldInput.text!
        self.viewModel.strEmail  = self.txtFldEmail.txtFldInput.text!
        
        self.viewModel.buildJsonAndSendEditUserInformation(vc: self)
        
    }
}

extension PersonalDetailsViewControlles {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getEditUserInformation {
            
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PersonalZoneViewController.className) as? PersonalZoneViewController {
                
                personalZone.user = ApplicationManager.sharedInstance.userAccountManager.user
                
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

        self.lblGender.text = values[indexPath.row]
        UIView.animate(withDuration: 0.3) {
            self.tableDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
    }
}
