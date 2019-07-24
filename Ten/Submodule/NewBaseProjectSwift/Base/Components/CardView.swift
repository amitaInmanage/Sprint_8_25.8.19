//
//  CardView.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 12/09/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class CardView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 1;
        self.layer.cornerRadius = 1;
        
    }

}
