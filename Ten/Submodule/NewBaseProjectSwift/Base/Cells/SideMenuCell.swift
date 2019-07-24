//
//  SideMenuCell.swift
//  WelcomeInSwift
//
//  Created by inmanage on 21/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
  
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var seperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  
    
    func configureWithObj(menuItem: BaseMenuItem) {
        self.lblTitle.text = menuItem.strTitle.uppercased()
        if !menuItem.strIconURL.isEmpty {
            self.imgIcon.setImageWithStrURL(strURL: menuItem.strIconURL, withAddUnderscoreIphone: false)
            //self.imgIcon.image = self.imgIcon.image?.withRenderingMode(.alwaysTemplate)
        }

    }
    
}
