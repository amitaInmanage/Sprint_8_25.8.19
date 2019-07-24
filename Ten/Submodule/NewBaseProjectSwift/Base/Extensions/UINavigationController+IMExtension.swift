//
//  UINavigationController+IMExtension.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func pushViewControllerWithCustomAnimation(controller :UIViewController, animationTranstion transition: UIViewAnimationTransition) {
        
        UIView.animate(withDuration: 0.3) { 
            
            UIView.setAnimationCurve(.easeInOut)
            self.pushViewController(controller, animated: false)
            UIView.setAnimationTransition(transition, for: self.view, cache: false)
            
        }
        
    }
    
    func popViewControllerWithCustomAnimationTranstion(transition :UIViewAnimationTransition) {
        
        UIView.animate(withDuration: 0.3) {
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationTransition(transition, for: self.view, cache: false)
        }
        
        self.popViewController(animated: false)
        
    }
    
//    func pushViewControllerWithCrossDisolveAnimation(controller :UIViewController) {
//        
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transition.type = kCATransitionFade
//    
//        self.view.layer.add(transition, forKey: nil)
//        self.pushViewController(controller, animated: false)
//        
//    }
//    
//    func popViewControllerWithCrossDisolveAnimation() {
//        
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transition.type = kCATransitionFade
//        
//        self.view.layer.add(transition, forKey: nil)
//        self.popViewController(animated: false)
//        
//    }
    
    
}
