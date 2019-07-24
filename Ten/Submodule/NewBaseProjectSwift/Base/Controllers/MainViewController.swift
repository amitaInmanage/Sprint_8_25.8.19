//
//  MainViewController.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setNavigationItemTitle(title: "2")
    }
    
    override func getGANTScreenName() -> (String) {
        return self.className
    }
    
}
