//
//  MainTabBarViewController.swift
//  Mindspace
//
//  Created by Amir-inManage on 02/07/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//


import UIKit

@objc protocol BackProtocol : NSObjectProtocol {
    func backCompletion()
}


class MainTabBarViewController: BaseTabBarViewController {
    
    weak var backDelegate: BackProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func pushViewController(viewController: UIViewController, animated: Bool) {
        
       self.pushViewController(viewController: viewController, tabIndex: self.selectedIndex, animated: true)
    }
    
    func pushViewController(viewController: UIViewController, tabIndex: Int, animated: Bool) {
        var isPushing = false
        if let mainNavController = self.viewControllers?[tabIndex] as? MainNavigationController {
            if !mainNavController.viewControllers.last!.className.elementsEqual(viewController.className) {
                ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true, completionHandler: nil)
                mainNavController.pushViewController(viewController, animated: animated)
                isPushing = true
            }
            if let firstMainController = mainNavController.viewControllers.first,
                let firstViewController = UIApplication.shared.keyWindow?.rootViewController {
                if !firstMainController.className.elementsEqual(firstViewController.className) && mainNavController.viewControllers.last!.className.elementsEqual(viewController.className) && !isPushing && !ApplicationManager.sharedInstance.mainViewController.isLeftViewShowing {
                    ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true, completionHandler: nil)
                    mainNavController.popViewController(animated: true)
                    mainNavController.pushViewController(viewController, animated: true)
                }
            }
            ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true, completionHandler: nil)
        }
    }
    
    
    func popViewController(animated: Bool) {
        
        if let mainNavController = self.viewControllers?[self.selectedIndex] as? MainNavigationController {
            if mainNavController.viewControllers.count == 1 {
                if self.selectedIndex == 0 {
                    mainNavController.setViewControllers([], animated: false)
                }
//                ApplicationManager.sharedInstance.tabsManager.homeNavigationController.popToRootViewController(animated: false)
//                ApplicationManager.sharedInstance.tabBarController.selectedIndex = ApplicationManager.sharedInstance.appGD.arrBottomMenu.count

            } else{
                mainNavController.popViewController(animated: animated)
            }
        }
        
    }
    
    func setViewControllers(viewController: UIViewController, tabIndex: Int, animated: Bool) {
        
        ApplicationManager.sharedInstance.tabBarController.selectedIndex = tabIndex

        if let mainNavController = self.viewControllers?[tabIndex] as? MainNavigationController{
            if mainNavController.viewControllers.isEmpty {
                mainNavController.setViewControllers([viewController], animated: false)
            } else {
                self.pushViewController(viewController: viewController, tabIndex: tabIndex, animated: true)
            }
            
        }
        if ApplicationManager.sharedInstance.mainViewController != nil {
            ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true, completionHandler: nil)
        }
    }

}
