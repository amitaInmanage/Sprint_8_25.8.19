//
//  UIStackView+IMExtension.swift
//  Maccabi_Haifa
//
//  Created by aviv frenkel on 27/12/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
    func reSizeSubViews (subView: UIView, subViewsCount: Int, maxViewsWithoutScroll: Int, scrollView: UIScrollView) {
        let subViewsCount = CGFloat(subViewsCount)
        let maxViewsWithoutScroll = CGFloat(maxViewsWithoutScroll)
        let spacing = self.spacing
        var subViewWidth: CGFloat
        let seeHalfOfTheNextView = CGFloat(0.5)
        
        if(subViewsCount > maxViewsWithoutScroll) {
            
            scrollView.isScrollEnabled = true
            
            let fuelTypesStackMargins = self.layoutMargins.left
            subViewWidth = ( UIScreen.main.bounds.width - (spacing * (maxViewsWithoutScroll-1)+fuelTypesStackMargins) )/(maxViewsWithoutScroll + seeHalfOfTheNextView)
            
        }else if (subViewsCount <= maxViewsWithoutScroll) {
            
            scrollView.isScrollEnabled = false
            self.layoutMargins = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
            self.isLayoutMarginsRelativeArrangement = true
            subViewWidth = ( UIScreen.main.bounds.width - (70 + spacing * (subViewsCount-1)) )/subViewsCount
            
        }else {
            subViewWidth = UIScreen.main.bounds.width
        }
        
        let widthConstraint = subView.widthAnchor.constraint(equalToConstant: CGFloat(subViewWidth))
        subView.addConstraints([widthConstraint])
    }
    
}


