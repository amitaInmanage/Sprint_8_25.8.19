//
//  SignUpPasswordCreatedSuccessfullyViewController.swift
//  Ten
//
//  Created by inmanage on 02/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpPasswordCreatedSuccessfullyViewController: BaseFormViewController {
    @IBOutlet weak var lblTitle: RegularLabel!
    
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let main = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: MainScreenViewController.className) as? MainScreenViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(main, animated: true)
            }
//            if self.user.hasPinCode {
//                if let login = UIStoryboard(name: "PersonalZone", bundle: nil).instantiateViewController(withIdentifier: PersonalZoneViewController.className) as? PersonalZoneViewController {
//                    login.user = self.user
//                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(login, animated: true)
//                }
//            } else {
//                if let login = UIStoryboard(name: "PersonalZone", bundle: nil).instantiateViewController(withIdentifier: SecurityManagmentViewController.className) as? SecurityManagmentViewController {
//                    login.user = self.user
//                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(login, animated: true)
//                }
//            }
        }
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.pinCodeSuccess, Translations.Titles.pinCodeSuccessDefault)
    }
}
