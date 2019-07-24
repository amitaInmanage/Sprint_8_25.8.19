//
//  PersonalDetailCustomView.swift
//  Ten
//
//  Created by inmanage on 14/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalDetailCustomView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var action: ( () -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: PersonalDetailCustomView.self)
        bundle.loadNibNamed(PersonalDetailCustomView.className, owner: self, options: nil)
        addSubview(self.view)
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setDataWith(menuItem: PersonalAreaMenuItem) {
        self.lblTitle.text = menuItem.strTitle
        //TODO: uncomment when server returns images
//        self.img.setImageWithStrURL(strURL: menuItem.strIcon, withAddUnderscoreIphone: false)
    }
}
