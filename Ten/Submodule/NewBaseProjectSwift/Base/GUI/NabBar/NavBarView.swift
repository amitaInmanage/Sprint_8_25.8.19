//
//  NavBarView.swift
//  Maccabi_Haifa
//
//  Created by Idan Dreispiel on 04/09/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

@objc protocol NavBarViewDelegate: class,NSObjectProtocol {
    func didTapLogo(sender: Any)
    @objc optional func didTapUser(sender: Any)
    @objc optional func didTapLogin(sender: Any)
    @objc optional func didTapSignup(sender: Any)
}

@objc protocol NavBarViewBackActionDelegate: class,NSObjectProtocol {
    func didTapBack(sender: UIButton, customBackDelegate: CustomBackDelegate?)
}

class NavBarView: UIView {

    weak var delegate: NavBarViewDelegate!
    weak var backActionDelegate: NavBarViewBackActionDelegate!
    weak var customBackDelegate: CustomBackDelegate?
    
    @IBOutlet weak var vwNavBarView: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var btnLogo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIApplication.statusBarBackgroundColor = UIColor.getApplicationThemeColor()
//        self.vwNavBarView.backgroundColor = UIColor.retrieveColorFromNSUserDefaultsWithKey(key: "devEnviromentColorDataKey", defaultValue: UIColor.getApplicationThemeColor())
        self.vwNavBarView.backgroundColor = UIColor.getApplicationThemeColor()
    }
    
    // MARK: IBAction
    
    @IBAction func didTapUser(_ sender: Any) {
        if let aDelegate = delegate {
            if let aDidTapUser = aDelegate.didTapUser {
                aDidTapUser(sender)
            }
        }
        
    }
    
    @IBAction func didTapLogo(_ sender: Any) {
        
        if let aDelegate = delegate {
            if aDelegate.responds(to: #selector(aDelegate.didTapLogo(sender:))) {
                aDelegate.didTapLogo(sender: sender)
            }
        }
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        
        if let aBackActionDelegate = backActionDelegate {
            if aBackActionDelegate.responds(to: #selector(aBackActionDelegate.didTapBack(sender:customBackDelegate:))) {
                aBackActionDelegate.didTapBack(sender: sender, customBackDelegate: self.customBackDelegate)
            }
        }
    }
    
    @IBAction func didTapLogin(_ sender: Any) {

        if let aDelegate = delegate {
            if let aDidTapLogin = aDelegate.didTapLogin {
                aDidTapLogin(sender)
            }
        }
    }
    
    @IBAction func didTapSignup(_ sender: Any) {
       
        if let aDelegate = delegate {
            if let aDidTapSignup = aDelegate.didTapSignup {
                aDidTapSignup(sender)
            }
        }

    }
}
