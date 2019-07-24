//
//  MainNavigationController.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class MainNavigationController: BaseNavigationController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
        self.setNavigationBgColor()
    }
    
    func setNavigationBgColor() {
        //TODO: uncomment this to get the url navigationColor
//        self.navigationBar.barTintColor =  UIColor.retrieveColorFromNSUserDefaultsWithKey(key: "devEnviromentColorDataKey", defaultValue: UIColor.getApplicationThemeColor())
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = UIColor.getApplicationThemeColor()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    

}
