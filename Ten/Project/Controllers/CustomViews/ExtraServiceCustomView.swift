//
//  ExtraServiceCustomView.swift
//  Ten
//
//  Created by shani daniel on 25/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class ExtraServiceCustomView: UIView {
    
    //var isSelected = false
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblServiceName: LightLabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: FuelTypeCustomView.self)
        bundle.loadNibNamed("ExtraServiceCustomView", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}
