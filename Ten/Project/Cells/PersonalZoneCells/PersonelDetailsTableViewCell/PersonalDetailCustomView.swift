//
//  PersonalDetailCustomView.swift
//  Ten
//
//  Created by inmanage on 14/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol DidTapItem {
    func didTapItem(menuItem: PersonalAreaMenuItem)
}

class PersonalDetailCustomView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var lblTitle: RegularText!
    @IBOutlet weak var img: UIImageView!
    
    var didTapItem: DidTapItem?
    var action: ( () -> Void )?
    var menuItem: PersonalAreaMenuItem?
    
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
        self.menuItem = menuItem
        self.lblTitle.text = menuItem.strTitle
        self.lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 15)
        self.img.setImageWithStrURL(strURL: menuItem.strIcon, withAddUnderscoreIphone: false)
    }
    
    //IBAction:
    @IBAction func didTapitem(_ sender: Any) {
        if self.didTapItem != nil {
            self.didTapItem?.didTapItem(menuItem: self.menuItem!)
        }
    }
}
