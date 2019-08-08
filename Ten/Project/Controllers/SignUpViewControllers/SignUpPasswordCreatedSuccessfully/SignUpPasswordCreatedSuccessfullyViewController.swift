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
    
    var userHavePinCode = ApplicationManager.sharedInstance.userAccountManager.user.hasPinCode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            if self.userHavePinCode {
                if let main = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: SecurityManagmentViewController.className) as? SecurityManagmentViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(main, animated: true)
                }
            } else {
                if let main = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: MainScreenViewController.className) as? MainScreenViewController {
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(main, animated: true)
                }
            }
        }
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.pinCodeSuccess, Translations.Titles.pinCodeSuccessDefault)
    }
}
