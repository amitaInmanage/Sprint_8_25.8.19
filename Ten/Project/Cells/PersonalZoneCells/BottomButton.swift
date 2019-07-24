//
//  BottomButton.swift
//  Ten
//
//  Created by inmanage on 16/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class BottomButton: UIView {
    
    
    @IBOutlet weak var bottomBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    fileprivate func buttonInit() {
        Bundle.main.loadNibNamed("BottomButton", owner: self, options: nil)
        addSubview(bottomBtn)
        self.bottomBtn.frame = self.bounds
        self.bottomBtn.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight]
    }
    
    fileprivate func initUI() {
    self.bottomBtn.setTitle(Translation(Translations.AlertButtonsKeys.logout,Translations.AlertButtonsKeys.logoutDefault), for: .normal)
    self.bottomBtn.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    
    }
}
