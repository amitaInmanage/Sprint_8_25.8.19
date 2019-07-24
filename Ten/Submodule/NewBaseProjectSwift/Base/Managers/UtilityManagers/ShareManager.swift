//
//  ShareManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import Social

class ShareManager: BaseManager {
    
    static var sharedInstance = ShareManager()
    
    func showActivityShareWithItemsToShare(arr :[Any], andActivityCompletionHandler activityCompletionHandler: (() -> ())?, subjectTitle: String) {
        
        let objectsToShare = arr
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.setValue(subjectTitle, forKey: "subject")
        
////        let excludeActivities = [UIActivityType.postToWeibo,
//                                 UIActivityType.message,
//                                 UIActivityType.print,
//                                 UIActivityType.copyToPasteboard,
//                                 UIActivityType.assignToContact,
        //                                 UIActivityType.saveToCameraRoll,
        //                                 UIActivityType.addToReadingList,
        //                                 UIActivityType.postToFlickr,
        //                                 UIActivityType.postToVimeo,
        //                                 UIActivityType.postToTencentWeibo,
        //                                 UIActivityType.airDrop,
        //                                 UIActivityType.postToTwitter,
        //                                 UIActivityType.postToFacebook]
        activityVC.excludedActivityTypes = nil
        
        activityVC.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
                        
            if !completed {
                LogMsg("Share Cancelled")
                
            } else {
                
                let request = ShareLogRequest().initWithDictParams(dictParams: nil, andRequestFinishDelegate: nil)
                
                request.showHUD = false
                request.showResponseMessages = false
                
                ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
                
                if let completionHander = activityCompletionHandler {
                    completionHander()
                }
                
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            if activityVC.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                
                let mainTabBar = ApplicationManager.sharedInstance.tabBarController
                if let mainTabBarController = mainTabBar.viewControllers?[mainTabBar.selectedIndex] as? MainNavigationController {
                    
                    activityVC.popoverPresentationController?.sourceView = mainTabBarController.viewControllers.last?.view
                }
            }
        }
        ApplicationManager.sharedInstance.navigationController.present(activityVC, animated: true, completion: nil)
        
    }

    override func reset() {
        ShareManager.sharedInstance = ShareManager()
    }
    
}
