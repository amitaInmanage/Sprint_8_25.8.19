//
//  BaseContainerViewController.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 03/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseContainerViewController: UIViewController,RequestFinishedProtocol{
    
    var processType : ProcessType?
    var shouldReversePushDirection = false
    let dimView = UIView()
    var data : Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTextWithTrans()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        weak var weakSelf = self
        ApplicationManager.sharedInstance.requestManager.addRequestFinishDelegate(requestFinishDelegate: weakSelf!)
        //ApplicationManager.sharedInstance.gANTManager.trackScreen(screenName: self.getGANTScreenName(), forClassName: self.className)
        
    }
    
    func setScrollViewSize() {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ApplicationManager.sharedInstance.requestManager.removeRequestFinishedDelegate(requestFinishDelegate: self)
        
    }
    
    
    deinit {
        ApplicationManager.sharedInstance.requestManager.removeRequestFinishedDelegate(requestFinishDelegate: self)
        LogMsg("\(self.className) deinit called")
        
    }

    //Translations
    func fillTextWithTrans(){}
    
    func endEditing() {
        self.view.endEditing(true)
    }
    
    func refreshXibsData(){}
    
    
}
