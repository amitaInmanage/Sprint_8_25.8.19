//
//  PasswordManagmentCell.swift
//  Ten
//
//  Created by Amit on 21/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PasswordManagmenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblChangePassowrd: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var vwContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
    
    fileprivate func initUI() {
        self.vwContent.addShadow()
    }
    
    //IBAction:
    @IBAction func didTapChangePassword(_ sender: Any) {
        if let signUpVC = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: FourDigitCodeViewController.className) as? FourDigitCodeViewController {
            signUpVC.changePassword = false
        ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
        }
    }
}
