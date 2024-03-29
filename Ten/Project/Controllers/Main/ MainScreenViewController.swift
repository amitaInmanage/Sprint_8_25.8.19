//
//  MainViewController.swift
//  Ten
//
//  Created by Amit on 23/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class MainScreenViewController: BaseFormViewController {
    
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var userConnect = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTapPersonalZone(_ sender: Any) {
        
        if userConnect {
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PersonalZoneViewController.className) as? PersonalZoneViewController {
                personalZone.user = ApplicationManager.sharedInstance.userAccountManager.user
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
            }
        } else {
            //TODO: Send cal user Disconnected
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PersonalZoneViewController.className) as? PersonalZoneViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
            }
        }
    }
}
