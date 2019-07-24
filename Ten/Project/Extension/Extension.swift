//
//  Extension.swift
//  Ten
//
//  Created by inmanage on 17/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import Foundation


extension MainNavigationController {
    func pushTenViewController(_ viewController: UIViewController, animated: Bool, height: CGFloat? = nil, shouldShowBottomBtn: Bool = false, shouldShowPersonalZoneBtn: Bool = false) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TenStyleViewController.className) as? TenStyleViewController {
            if let height = height {
                vc.changeSize(height: height)
            }
            vc.boxChild.value = viewController
            if ((viewController as? SignUpConfrimTermsOfServiceViewController) != nil){
                
            }
         
            if let signUpVC = viewController as? ActionBottomBtnDelegate {
                vc.delegate = signUpVC
            }
            
            vc.shouldShowBottomBtn.value = shouldShowBottomBtn
            ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
            
        }
    }
}
extension UIButton{
    func roundedButton() {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        self.clipsToBounds = true
    }
}
