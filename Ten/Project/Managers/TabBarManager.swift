//
//  TabBarManager.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 10/09/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class TabBarManager: BaseManager {

    static var sharedInstance = TabBarManager()
    
    //Navigations
    var sidemenuNavigationController = MainNavigationController()
    var tabBar = UITabBar()
    
    // MARK: - Reset
    
    public func createTabBarViewControllerAndNavigation() {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        
//        let tabBarController =  sb.instantiateViewController(withIdentifier: MaccabiTabBarViewController.className) as! MaccabiTabBarViewController
//        
//        var sidemenuNavigationController = sb.instantiateViewController(withIdentifier: MainNavigationController.className) as! MainNavigationController
//        
//        sidemenuNavigationController = MainNavigationController(navigationBarClass: CustomNavigationBar.self, toolbarClass: nil)
//
//        sidemenuNavigationController.tabBarItem = UITabBarItem(title: Translation(TabBarTranslations.btnMore, TabBarTranslations.btnMoreDefault), image: UIImage(named: "more"), selectedImage: UIImage(named: "more_on"))
//        
//        let arrBottomMenu = ApplicationManager.sharedInstance.appGD.arrBottomMenu
//        
//        self.sidemenuNavigationController = sidemenuNavigationController
//        
//        //Hide all navigation bars.
//        sidemenuNavigationController.setNavigationBarHidden(true, animated: false)
//    tabBarController.setViewControllers([sidemenuNavigationController,storeNavigationController,gamesNavigationController,newsNavigationController,homeNavigationController], animated: true)
//
//        tabBarController.selectedIndex = ApplicationManager.sharedInstance.appGD.arrBottomMenu.count
//
//        ApplicationManager.sharedInstance.tabBarController = tabBarController
//        
//        ApplicationManager.sharedInstance.navigationController.setViewControllers([tabBarController], animated: true)
        
        
    }
    
//    func getTabBarItemWith(bottomMenu: BottomMenu, defaultTitle: String, defaultImg: String) -> UITabBarItem {
//
//        let title = bottomMenu.strTitle.isEmpty ? defaultTitle : bottomMenu.strTitle
//        let img = (bottomMenu.imgData != nil) ? UIImage(data: bottomMenu.imgData!) : UIImage(named: defaultImg)
//
//        return UITabBarItem(title: title, image: img, selectedImage: img)
//
//    }
    
    override func reset() {
        TabBarManager.sharedInstance = TabBarManager()
    }
    
}
