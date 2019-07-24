//
//  SideMenuProfileTableViewCell.swift
//  Mindspace
//
//  Created by Amir-inManage on 14/08/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

@objc protocol SideMenuProfileTableViewCellDelegate : NSObjectProtocol{
    func didTapSignout(_ sender : Any)
}

class SideMenuProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTitlePrivateSpace: RegularLabel!
    
    weak var delegate: SideMenuProfileTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgProfile.image = imgProfile.image!.withRenderingMode(.alwaysTemplate)
        self.imgProfile.tintColor = .black
    }

    func configureWithObj(menuItem: BaseMenuItem) {
        
        if !ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn {

            self.imgProfile.image = #imageLiteral(resourceName: "user")
            self.imgProfile.image = imgProfile.image!.withRenderingMode(.alwaysTemplate)
            self.imgProfile.tintColor = .black

        } else {
            
            self.lblTitlePrivateSpace.text = ApplicationManager.sharedInstance.userAccountManager.user.strFirstName
            if !ApplicationManager.sharedInstance.userAccountManager.setStrPicture(imageView:  self.imgProfile) {
                 self.imgProfile.image = #imageLiteral(resourceName: "user2")
            }

            self.imgProfile.layer.masksToBounds = true
            self.imgProfile.layer.cornerRadius = 24
            self.imgProfile.layoutIfNeeded()

        }
       
    }
    
    @IBAction func btnSignout(_ sender: Any) {
        if let aDelegate = self.delegate {
            if aDelegate.responds(to: #selector(SideMenuProfileTableViewCellDelegate.didTapSignout)) {
                aDelegate.didTapSignout(sender)
            }
        }
    }
}
