//
//  SideMenuFooter.swift
//  Mindspace
//
//  Created by Idan Dreispiel on 06/07/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit
class SideMenuFooter: UIView {

    @IBOutlet weak var lblTitle: RegularLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapFooter(_ sender: Any) {
        
        ApplicationManager.sharedInstance.userAccountManager.callGetUserSettings(dictParams: nil, andRequestFinishedDelegate: nil)
        
        //        let sb = UIStoryboard(name: "Main", bundle: nil)
        //      let vc = sb.instantiateViewController(withIdentifier: "SettingsViewController") as! BaseViewController
        //
        //        ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
        ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true) {
            
        }

    }
}
