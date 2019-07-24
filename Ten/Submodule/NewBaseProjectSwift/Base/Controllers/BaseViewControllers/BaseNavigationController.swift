//
//  BaseNavigationController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 22/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,ProcessFinishedProtocol,RequestFinishedProtocol,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UINavigationControllerDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation Methods
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        LogMsg("Stack before: \(self.viewControllers)")
        super.pushViewController(viewController, animated: animated)
        LogMsg("Stack after: \(self.viewControllers)")
    }
    
    @discardableResult override func popViewController(animated: Bool) -> UIViewController? {
        LogMsg("Stack before: \(self.viewControllers)")
        return super.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        LogMsg("Stack before: \(self.viewControllers)")
        return super.popToViewController(viewController, animated: animated)
    }
    
    @discardableResult override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        LogMsg("Stack before: \(self.viewControllers)")
        return super.popToRootViewController(animated: animated)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        LogMsg("Stack before: \(self.viewControllers)")
        super.setViewControllers(viewControllers, animated: animated)
        LogMsg("Stack after: \(self.viewControllers)")
    }
    
    // Overriding presentViewController to allow presenting a VC even when one is already presented
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        if self.presentedViewController != nil {
            self.dismiss(animated: false, completion: {
                super.present(viewControllerToPresent, animated: flag, completion: completion)
            })
        } else {
            super.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    // MARK: - RequestFinishedProtocol
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
    
    // MARK: - ProcessFinishedProtocol
    
    func processFinished(processManager: BaseProcessManager, processFinishedStatus: ProcessFinishedStatus, processCompletion: (BaseProcessManager, ProcessFinishedStatus) -> ()) {
        
    }
    
    // MARK: -  UINavigationControllerDelegate
    
    
       /* override */ func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push && toVC is BaseViewController && (toVC as! BaseViewController).shouldReversePushDirection {
            return PushAnimator()
            
        } else if operation == .pop && fromVC is BaseViewController && (fromVC as! BaseViewController).shouldReversePushDirection {
            return PopAnimator()
        }
        
        return nil
    }
    
    
    
}
