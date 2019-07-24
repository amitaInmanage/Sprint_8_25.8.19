//
//  GANTManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
//import Google

private let kGANTWarningPrefix = "על מנת לדווח לגוגל אנליטיקס יש לממש את מתודת getGANTScreenName במחלקה:"

class GANTManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = GANTManager()
    
    var applicationUsesGoogleAnalytics = false
   
    
    // Initial configuration
    func configureSettingsAndStartTracking() {
        
//        guard let gai = GAI.sharedInstance() else {
//            assert(false, "Google Analytics not configured correctly")
//            return
//        }
//        
//        // Optional: automatically send uncaught exceptions to Google Analytics.
//        gai.trackUncaughtExceptions = true
//        
//        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
//        gai.dispatchInterval = 20
//        
//        // Optional: set Logger to VERBOSE for debug information.
//        //gai.logger.logLevel = .verbose  // remove before app release
//        
//        // DryRun - not sending tracking info
//        gai.dryRun = Constans.debugMode
//
//        // Initialize tracker. Replace with your tracking ID.
//        let tracker = gai.tracker(withTrackingId: ApisKeys.GANTAccountID)
//        
//        if tracker != nil {
//            self.applicationUsesGoogleAnalytics = true
//        }
//        
//        gai.defaultTracker.allowIDFACollection = true
        
    }
    
    
    // Tracks screen event (i.e viewDidAppear)
    func trackScreen(screenName: String, forClassName className: String) {
        
        if !screenName.isEmpty && Constans.debugMode {
            
            let strAlertTitle = "\(kGANTWarningPrefix) \(className)"
            ApplicationManager.sharedInstance.alertManager .showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: .alertView, andTitle: strAlertTitle, andMessage: nil, andAction: nil)
            
        } else {
            
//            GAI.sharedInstance().defaultTracker.set(kGAIScreenName, value: screenName)
//            let build = (GAIDictionaryBuilder.createScreenView().build() as NSDictionary) as! [AnyHashable: Any]
//            GAI.sharedInstance().defaultTracker.send(build)
            
        }
        
    }
    
    // Tracks action events (i.e button tapping)
    func trackEventWithCategory(categoryName: String, andAction action: String, andLabel label: String, andValue value: NSNumber) {
        
//        let tracker = GAI.sharedInstance().defaultTracker
//
//        if let aTracker = tracker {
//
//             let params = (GAIDictionaryBuilder.createEvent(withCategory: categoryName, action: action, label: label, value: value).build() as NSDictionary) as! [AnyHashable: Any]
//
//            aTracker.send(params)
//
//        }
        
    }
    
    override func reset() {
        GANTManager.sharedInstance = GANTManager()
    }

}
