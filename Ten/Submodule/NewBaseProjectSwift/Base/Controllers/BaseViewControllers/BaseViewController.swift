//
//  BaseViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 12/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,RequestFinishedProtocol,GoogleAnalyticsProtocol{

    var processType : ProcessType?
    var shouldReversePushDirection = false
    let dimView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillTextWithTrans()
        
        self.view.backgroundColor = UIColor.getApplicationScreenBackgroundColor()
        if !(self is SplashViewController) {
            //ApplicationManager.sharedInstance.mainViewController.showMain(show: false)
            
            //ApplicationManager.sharedInstance.mainViewController.showBackButton(showBackButton: true, withBackActionDelegate: nil)
            
            self.setNavigationBgColor(color: .white)
            self.setupBackBtn()
            self.setupLogo()
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Don't allow PopupVCs to affect the navbar... (PopupVCs are added to the key window, not to nav stack)
//        if !(self is SplashViewController) {
//            if !(self is BasePopupViewController) {
//                ApplicationManager.sharedInstance.mainViewController.showBackButton(showBackButton: true, withBackActionDelegate: nil)
//            } else {
//                ApplicationManager.sharedInstance.mainViewController.showBackButton(showBackButton: true, withBackActionDelegate: nil)
//            }
//        }
        
        
        
       
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        weak var weakSelf = self
        ApplicationManager.sharedInstance.requestManager.addRequestFinishDelegate(requestFinishDelegate: weakSelf!)
        //ApplicationManager.sharedInstance.gANTManager.trackScreen(screenName: self.getGANTScreenName(), forClassName: self.className)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ApplicationManager.sharedInstance.requestManager.removeRequestFinishedDelegate(requestFinishDelegate: self)
        
    }
    
    deinit {
        ApplicationManager.sharedInstance.requestManager.removeRequestFinishedDelegate(requestFinishDelegate: self)
        LogMsg("\(self.className) deinit called")
        
    }

    func getGANTScreenName() -> (String) {
        return ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing()
    }

    //Translations 
    func fillTextWithTrans(){
        
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }
    
}

extension BaseViewController:ProcessFinishedProtocol {
    
    func processFinished(processManager: BaseProcessManager, processFinishedStatus: ProcessFinishedStatus, processCompletion: (BaseProcessManager, ProcessFinishedStatus) -> ()) {
        
    }
    
}
