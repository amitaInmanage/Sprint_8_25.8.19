//
//  CreatePasswordTableViewCell.swift
//  Ten
//
//  Created by Amit on 22/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CreatePasswordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPassword: RegularText!
    @IBOutlet weak var lblCreatePassword: RegularBtn!
    @IBOutlet weak var vwContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
    
    fileprivate func initUI() {
        self.vwContent.addShadow()
        self.lblCreatePassword.addUnderline(title: Translation(Translations.AlertButtonsKeys.securityManagementSetPinCode, Translations.AlertButtonsKeys.securityManagementSetPinCodeDefault))
        self.lblPassword.text = Translation(Translations.Titles.securityManagment, Translations.Titles.securityManagmentDefault)
    }
    
    @IBAction func didTapCreatePassword(_ sender: Any) {
        if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: FourDigitCodeViewController.className) as? FourDigitCodeViewController {
            signUpVC.hesPinCode = false
            ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
        }
    }
}
