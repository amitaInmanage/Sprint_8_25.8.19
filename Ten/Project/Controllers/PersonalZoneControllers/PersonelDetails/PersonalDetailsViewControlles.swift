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
    @IBOutlet weak var txtFldGander: DropDown!
    @IBOutlet weak var txtFldPhone: InputCustomView!
    @IBOutlet weak var txtFldEmail: InputCustomView!
    @IBOutlet weak var btnNotafication: IMButton!
    @IBOutlet weak var lblNotafication: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblSecurityManager: IMLabel!
    
    var keys = [Int]()
    var values = [String]()
    var viewModel = PersonalDetailsViewModel()
    var user = TenUser()
    var button: PersonalDetailsBottomButton?
    var genserArr = ApplicationManager.sharedInstance.appGD.genderArr
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
            vc.containerView.backgroundColor = UIColor.groupTableViewBackground
            vc.containerView = nil
            let mysubView: PersonalDetailsBottomButton = PersonalDetailsBottomButton()
            self.view.addSubview(mysubView)
        }
    }
    
    fileprivate func initUI() {
       self.view.backgroundColor = .clear
       self.contentView.addShadow()
       self.bottomView.addShadow()
        self.mDCTextSetUp(mDCText: self.txtFldFirstName.txtFldInput, withPlaceholderText: "שם פרטי", withIndex: self.txtFldFirstName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldLastName.txtFldInput, withPlaceholderText: "שם משפחה", withIndex: self.txtFldLastName.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        
         self.mDCTextSetUp(mDCText: self.txtFldPhone.txtFldInput, withPlaceholderText: "טלפון", withIndex: self.txtFldPhone.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)

        self.mDCTextSetUp(mDCText: self.txtFldEmail.txtFldInput, withPlaceholderText: "דוא׳׳ל", withIndex: self.txtFldEmail.txtFldInput.tag, withKeyboardType: .default , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "דיווח על טעות", addToolbar: true)
        
        
        for key in self.genserArr.keys {
            let tempKey = Int(key)
           keys.append(tempKey ?? 0)
        }
        
        for value in self.genserArr.values {
            let tempValue = String(describing: value)
            values.append(tempValue)
        }
  
        
        self.txtFldGander.optionArray = values
        self.txtFldGander.optionIds = keys
        
        self.txtFldFirstName.txtFldInput.text  = user.strFirstName
        self.txtFldLastName.txtFldInput.text = user.strLastName
//        self.txtFldPhone.txtFldInput.text = user.strPhoneNumber
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.editPersonalInformation, Translations.Titles.editPersonalInformationDefault)
        self.lblSecurityManager.text = Translation(Translations.AlertButtonsKeys.securityMenagement, Translations.AlertButtonsKeys.securityMenagementDefault)
        self.lblSecurityManager.textColor = UIColor.getApplicationTextColor()
    }
    
    //IBAction:
    @IBAction func didTapBtnNotafication(_ sender: Any) {
        
    }
    
    @IBAction func didTapSecurityManager(_ sender: Any) {
        if let personalSecurity = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: SecurityManagmentViewController.className) as? SecurityManagmentViewController {
            personalSecurity.user = self.user
            ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalSecurity, animated: true)
        }
    }
    
    func didTapPersonalZoneBtn() {
        //TODO: send call
    }
}
