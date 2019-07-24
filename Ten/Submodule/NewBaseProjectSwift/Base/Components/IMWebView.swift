//
//  IMWebView.swift
//  SwiftChuckNorris
//
//  Created by inmanage on 06/03/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import Foundation
import UIKit

class IMWebView : UIWebView {
    
    private func initialize() {
        
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.scrollView.bounces = false
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
  
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    
    }
    
    func loadHTMLString(strString :String, withBaseURL baseURL:URL?) {
        
        super.loadHTMLString("\(ApplicationManager.sharedInstance.appGD.strWebViewFontStyle)\(strString)", baseURL: baseURL)
        
    }
    
    
    
}
