//
//  HomeViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 13/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

enum SideMenuDirection: Int {
    case left = 0, right
}

import UIKit
import LGSideMenuController

class HomeViewController: LGSideMenuController,UITextFieldDelegate {
    
    var sideMenuTableViewController = SideMenuTableViewController()
    var navBarView = NavBarView()
    
    weak var customBackDelegate: CustomBackDelegate?
    
    func initWithRootViewController(rootViewController: UIViewController, presentationStyle style: LGSideMenuPresentationStyle, type: NSInteger, sideMenuDirection: SideMenuDirection) -> (HomeViewController) {
        
//        ApplicationManager.sharedInstance.sideMenuAndContentPageManager.buildFullSideMenu()
        
        self.rootViewController = rootViewController
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        sideMenuTableViewController = sb.instantiateViewController(withIdentifier: SideMenuTableViewController.className) as! SideMenuTableViewController

        switch sideMenuDirection  {
            
        case .left:
//            
            self.setLeftViewEnabledWithWidth((90 / 100) * UIScreen.main.bounds.width, presentationStyle: style, alwaysVisibleOptions: .init(rawValue: 0))
            self.isLeftViewSwipeGestureEnabled = false
            self.leftViewStatusBarStyle = .default
            self.leftViewStatusBarVisibleOptions = .onAll
            self.leftViewBackgroundColor = UIColor.clear
            self.rootViewCoverColorForLeftView = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
           
            sideMenuTableViewController.tableView.reloadData()
            self.leftView().addSubview(sideMenuTableViewController.tableView)
            
            
           self.leftView()
            break
        case .right:
            
            self.setRightViewEnabledWithWidth((90 / 100) * UIScreen.main.bounds.width, presentationStyle: style, alwaysVisibleOptions: .init(rawValue: 0))
            self.isRightViewSwipeGestureEnabled = false
            self.rightViewStatusBarStyle = .default
            self.rightViewStatusBarVisibleOptions = .onAll
            self.rightViewBackgroundColor = UIColor.clear
            self.rootViewCoverColorForRightView = UIColor.clear
            
            sideMenuTableViewController.tableView.reloadData()
            self.rightView().addSubview(sideMenuTableViewController.tableView)
            break
        }
        
        
        //Add custom NavBar
        
//        if let arrBundle = Bundle.main.loadNibNamed(NavBarView.className, owner: nil, options: nil) {
//
//            navBarView = arrBundle[0] as! NavBarView
//
//            navBarView.translatesAutoresizingMaskIntoConstraints = false
//
//            rootViewController.view.addSubview(navBarView)
//
//            let views = ["navBarView":navBarView]
//            let height = DeviceType.IS_IPHONE_X ? 88 : 64
//            let metrics = ["navBarViewHeight":height] //Default 64
//
//            // navBarView view fills the width of its superview
//            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[navBarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
//
//            // navBarView view is pinned to the top of the superview
//            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[navBarView(navBarViewHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
//
//            navBarView.delegate = self
//            navBarView.backActionDelegate = self
//        }

        return self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func rightViewWillLayoutSubviews(with size: CGSize) {
        super.rightViewWillLayoutSubviews(with: size)
        
        if !UIApplication.shared.isStatusBarHidden {
            sideMenuTableViewController.tableView.frame = CGRect(x: 0, y: 0, width: (90 / 100) * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        } else {
            sideMenuTableViewController.tableView.frame = CGRect(x: 0, y: 0, width: (90 / 100) * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }

    }
    
    override func leftViewWillLayoutSubviews(with size: CGSize) {
        super.leftViewWillLayoutSubviews(with: size)
        
        if !UIApplication.shared.isStatusBarHidden {
            sideMenuTableViewController.tableView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: (90 / 100) * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        } else {
            sideMenuTableViewController.tableView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: (90 / 100) * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        
    }
    
    
    func hideSideMenu(animated: Bool, completionHandler: (() -> Void)!) {
        
        if self.isLeftViewShowing {
            self.hideLeftView(animated: animated, completionHandler: completionHandler)
        } else if self.isRightViewShowing {
            self.hideRightView(animated: animated, completionHandler: completionHandler)
        }
        
    }
    
    func showSideMenu(animated: Bool, completionHandler: (() -> Void)!) {
        
        if self.isLeftViewShowing {
            self.hideLeftView(animated: animated, completionHandler: completionHandler)
        } else if self.isRightViewShowing {
            self.hideRightView(animated: animated, completionHandler: completionHandler)
        } else if self.leftView() != nil {
            
//            self.view.insertSubview(ApplicationManager.sharedInstance.tabBarController.tabBar, aboveSubview: sideMenuTableViewController.tableView)
//            self.view.insertSubview(navBarView, aboveSubview: sideMenuTableViewController.tableView)
            self.showLeftView(animated: animated, completionHandler: completionHandler)
           
        } else {
            self.showRightView(animated: animated, completionHandler: completionHandler)
        }
        
    }
    
    // MARK: - General
    
    func showBackButton(showBackButton: Bool, withBackActionDelegate backActionDelegate: CustomBackDelegate?) {
        
        //navBarView.btnBack.isHidden = !showBackButton

        navBarView.customBackDelegate = backActionDelegate

    }
    
    func showMain(show: Bool) {
        
        navBarView.btnBack.isHidden = show ? true : false
    }
    
    
    
    func setNavbarTitle(strTitle: String) {
        //navBarView.lblTitle.text = strTitle
//        self.rootViewController.navigationItem.title = strTitle
        
        ApplicationManager.sharedInstance.navigationController.navigationItem.title = strTitle
    }
    
    func popToHomeVC(resetAllTabsToRoot: Bool) {
        ApplicationManager.sharedInstance.navigationController.popToRootViewController(animated: true)
    }
    
    // MARK: - NavBarViewDelegate

//    func didTapLogo(sender: Any) {
//        self.hideSideMenu(animated: true, completionHandler: nil)
//        popToHomeVC(resetAllTabsToRoot: true)
//
//    }
//
//    func didTapMenu(sender: Any) {
//        self.showSideMenu(animated: true, completionHandler: nil)
//    }
//
//    // MARK: - NavBarViewActionDelegate
//
//    func didTapBack(sender: UIButton, customBackDelegate: CustomBackDelegate?) {
////        self.hideSideMenu(animated: true, completionHandler: nil)
////
////        if let aCustomDelegate = customBackDelegate {
////            if aCustomDelegate.responds(to: #selector(aCustomDelegate.didTapBack(sender:))) {
////                aCustomDelegate.didTapBack(sender: sender)
////            }
////        } else if ApplicationManager.sharedInstance.tabBarController.backDelegate != nil {
////            ApplicationManager.sharedInstance.tabBarController.backDelegate?.backCompletion()
////            ApplicationManager.sharedInstance.tabBarController.backDelegate = nil
////
////        } else {
////            ApplicationManager.sharedInstance.tabBarController.popViewController(animated: true)
////        }
//
//    }
    
    
    func hideNavigationBar(hideNavigationBar: Bool) {
        ApplicationManager.sharedInstance.navigationController.navigationBar.isHidden = hideNavigationBar
        navBarView.isHidden = hideNavigationBar
    }
    
    func handleDevEnviroment(isDevEnviroment: Bool) {
        //navBarView.vwDevEnviroment.isHidden = !isDevEnviroment
    }
    
    // Mark: navBar
 
    @objc func didTapBack(sender: UIBarButtonItem) {
        
        self.hideSideMenu(animated: true, completionHandler: nil)
        
        if let aCustomDelegate = self.customBackDelegate {
            if aCustomDelegate.responds(to: #selector(aCustomDelegate.didTapBack(sender:))) {
                aCustomDelegate.didTapBack(sender: sender)
            }

        } else if ApplicationManager.sharedInstance.tabBarController.backDelegate != nil {
            ApplicationManager.sharedInstance.tabBarController.backDelegate?.backCompletion()
            ApplicationManager.sharedInstance.tabBarController.backDelegate = nil
            
        } else {
            ApplicationManager.sharedInstance.navigationController.popViewController(animated: true)
        }
    }
    
    @objc func didTapLogo(sender: UIBarButtonItem) {
        self.hideSideMenu(animated: true, completionHandler: nil)
        popToHomeVC(resetAllTabsToRoot: true)
    }
    
    @objc func didTapMenu(sender: UIBarButtonItem) {
        self.showSideMenu(animated: true, completionHandler: nil)
    }
}
