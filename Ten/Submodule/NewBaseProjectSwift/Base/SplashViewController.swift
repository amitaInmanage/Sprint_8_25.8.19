//
//  SplashViewController.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import AVKit

class SplashViewController: BaseViewController {

    fileprivate var appliction = ApplicationManager.sharedInstance
    
    var progressViewWidthConstant : CGFloat?
    
    @IBOutlet weak var lblInmanage: RegularLabel!
    @IBOutlet weak var vwPlayerSplashVideo: PlayerView!
    @IBOutlet weak var lblPercent: RegularLabel!
    @IBOutlet weak var progressViewContainer: UIView!
    @IBOutlet weak var progressViewWidth: NSLayoutConstraint!
    @IBOutlet weak var progressView: CustomProgressView!
    @IBOutlet weak var progressViewContainerWidth: NSLayoutConstraint!
    
    private var numberOfResponses = 6
    private var doOnce = false
    private var arrLoadingTexts = [String]()
    private var currentTime: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playSplashVideo()
        self.progressViewWidthConstant = progressViewWidth.constant
        self.progressViewWidth.constant = 0
        self.progressViewContainer.setupWithBorderColor(borderColor: nil, andBorderWidth: nil, addCornerRadius: true)
        self.lblInmanage.text = Constans.createdByInmanage
        weak var weakSelf = self
        
        appliction.splashViewController = weakSelf!
        
        self.lblPercent.text = "0%"
        
        let willAttemptLogin = appliction.userAccountManager.canAttemptLoginOfType(loginOrSignupAttemptType: .loginAny)
        
        numberOfResponses = kNumberOfResponses
        
        if willAttemptLogin {
            numberOfResponses -= 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !doOnce {
            
            doOnce = true
            
            appliction.startupManager.startProcess(processType: .startup, processObj: nil, processFinishedDelegate: nil, processCompletion: { (processManager, processFinishedStatus) in
                
                let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: MainNavigationController.className) as! MainNavigationController
                
                ApplicationManager.sharedInstance.navigationController = mainNavigationController
                
                let homeViewContoroller: HomeViewController = HomeViewController().initWithRootViewController(rootViewController: mainNavigationController, presentationStyle: .slideAbove, type: 2, sideMenuDirection: .right)
                
                ApplicationManager.sharedInstance.mainViewController = homeViewContoroller
                
                UIApplication.shared.keyWindow?.rootViewController = homeViewContoroller
                
                ApplicationManager.sharedInstance.sideMenuAndContentPageManager.buildFullSideMenu()
            })
        }
    }

    private func playSplashVideo() {
        if let path = Bundle.main.path(forResource: "splash", ofType:"mp4")  {
            let videoURL = URL(fileURLWithPath: path)
            
            vwPlayerSplashVideo.player = AVPlayer(url: videoURL)
            vwPlayerSplashVideo.playerLayer.videoGravity = .resizeAspectFill
            vwPlayerSplashVideo.player?.play()
        }
    }
    
    fileprivate func requestOnBordingData() {
        ApplicationManager.sharedInstance.startupManager.callGetOnBoarding(requestFinishedDelegate: StartupManager())
    }
    
    func setProgressBarAnimate(percent : Int?) {
        
        if self.numberOfResponses > 0{
            if percent == nil {
                self.progressViewWidth.constant = CGFloat((Float)(self.progressViewWidthConstant!) / ((Float)(self.numberOfResponses)))
            } else {
                self.progressViewWidth.constant = CGFloat((Float)(self.progressViewWidthConstant!) / ((Float)(percent!)))
            }
        } else {
            self.progressViewWidth.constant = self.progressViewContainer.frame.width
        }
        self.progressView.layoutIfNeeded()
    }
    
    override func getGANTScreenName() -> (String) {
        return self.className
    }

    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if ApplicationManager.sharedInstance.startupManager.isIncreaseResponseCounterRequest(request: request) {
            numberOfResponses -= 1
            
            self.setProgressBarAnimate(percent: nil)
            
            if numberOfResponses > 1 {
                self.lblPercent.text = "\(100 / numberOfResponses)%"
            } else if numberOfResponses > 1 {
                self.lblPercent.text = "98%"
            } else {
                self.lblPercent.text = "100%"
            }
        } else if request.requestName == ServerUserRequests.loginUser {
            
            self.lblPercent.text = "\(100 / 1)%"
            
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}
