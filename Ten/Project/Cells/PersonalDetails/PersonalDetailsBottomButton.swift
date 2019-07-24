//
//  PersonalDetailsBottomButton.swift
//  Ten
//
//  Created by inmanage on 17/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalDetailsBottomButton: UIView {

    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    fileprivate func setup() {
        view = loadFromXib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
        view.setBottom(bottom: 0)
        addSubview(view)
    }
    
    func loadFromXib() -> UIView {
    
        let bundel = Bundle.main.loadNibNamed("PersonalDetailsBottomButton", owner: self, options: nil)?.first as! UIView
        return bundel
        
    }
    
}
