//
//  BasePopupViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 12/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BasePopupViewController: UIViewController, RequestFinishedProtocol {
    
    var popupViewControllerDelegate : PopupViewControllerDelegate?
    var kLCPopup : KLCPopup?
    var popupInfoObj : PopupInfoObj?
    
    @IBOutlet weak var vwContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTextWithTrans()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //MARK: General
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.clear
        
        self.vwContainer.backgroundColor = UIColor.white
        self.vwContainer.layer.cornerRadius = 4
        self.vwContainer.clipsToBounds = true
    }
    
    //Translations
    func fillTextWithTrans(){}
}
