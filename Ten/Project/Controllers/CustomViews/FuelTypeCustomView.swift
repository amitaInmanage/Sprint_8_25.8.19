//
//  FuelTypeCustomView.swift
//  Ten
//
//  Created by shani daniel on 26/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//


import UIKit

 class FuelTypeCustomView: UIView {
    
    var isSelected = false
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imgFuel: UIImageView!
    @IBOutlet weak var txtFuel: RegularLabel!
  
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
        bundle.loadNibNamed("FuelTypeCustomView", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}


