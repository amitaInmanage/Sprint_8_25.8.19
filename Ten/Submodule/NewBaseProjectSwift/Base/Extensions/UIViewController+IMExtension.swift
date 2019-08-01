//
//  UIViewController+IMExtension.swift
//  NewBaseProjectSwift
//
//  Created by Shani on 30/04/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import Foundation

extension UIViewController {

    func setNavigationItemTitle(title: String) {
        self.navigationItem.title = title;
    }

    func setNavigationBgColor(color: UIColor) {
        //self.navigationController?.navigationBar.tintColor = color
//        self.navigationController?.navigationBar.backgroundColor = UIColor.getApplicationThemeColor()
//        self.navigationController?.navigationBar.barTintColor = UIColor.getApplicationThemeColor()
//        UINavigationBar.appearance().tintColor = UIColor.getApplicationThemeColor()
//        UINavigationBar.appearance().backgroundColor = UIColor.getApplicationThemeColor()
//        UIApplication.statusBarBackgroundColor = UIColor.getApplicationThemeColor()

        
    }

    
//    func setupBackBtn(title: String) {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .done, target: ApplicationManager.sharedInstance.mainViewController, action: #selector(HomeViewController.didTapBack(sender:)))
//    }
    
    func setupBackBtn() {
       self.setupBackBtn(imgName: "gray")
    }
    
    func setupBackBtn(imgName: String) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: imgName), style: .done, target: ApplicationManager.sharedInstance.mainViewController, action: #selector(HomeViewController.didTapBack(sender:)))
    }
    
    func hideBackBtn() {
         self.navigationItem.rightBarButtonItem = nil
    }

    func hideLogo() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func setupLogo(enable: Bool = true) {
        
        //title logo
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logo", style: .plain, target: ApplicationManager.sharedInstance.mainViewController, action: #selector(HomeViewController.didTapBack(sender:)))
        
        //image logo
//        let image = UIImage(named: "tenMainLogo")!.withRenderingMode(.alwaysTemplate)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "tenMainLogo"), style: .done, target: ApplicationManager.sharedInstance.mainViewController, action: #selector(HomeViewController.didTapLogo(sender:)))
        
        
        self.navigationItem.leftBarButtonItem?.isEnabled = enable

    }
    
    func setupMenu() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: ApplicationManager.sharedInstance.mainViewController, action: #selector(HomeViewController.didTapMenu(sender:)))
        
    }
}
