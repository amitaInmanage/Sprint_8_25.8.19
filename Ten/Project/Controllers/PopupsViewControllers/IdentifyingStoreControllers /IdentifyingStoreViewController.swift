//
//  identifyingStoreViewController.swift
//  Ten
//
//  Created by inmanage on 16/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class IdentifyingStoreViewController: BasePopupViewController {

    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: LightLabel!
    @IBOutlet weak var lblTimer: RegularLabel!
    @IBOutlet weak var imgTimer: UIImageView!
    @IBOutlet weak var lblSeconderyTitle: LightLabel!
    @IBOutlet weak var lblNumber: RegularLabel!
    @IBOutlet weak var lblSeconderySubTitle: LightLabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let popupInfoObj = self.popupInfoObj {
            
            if let strTitle = popupInfoObj.strTitle {
                self.lblTitle.text = strTitle
                self.lblTitle.isHidden = false
            }else {
                self.lblTitle.isHidden = true
            }
            
            if let strSubTitle = popupInfoObj.strSubtitle {
                self.lblSubTitle.text = strSubTitle
                self.lblSubTitle.isHidden = false
            } else {
                self.lblSubTitle.isHidden = true
            }
            
            if let strLiterTxt = popupInfoObj.strLiterTxt {
                self.lblTimer.text = strLiterTxt
                self.lblTimer.isHidden = false
            } else {
                self.lblTimer.isHidden = true
            }
                
            
            if let strImageName = popupInfoObj.strImageName {
                self.imgTimer.image = UIImage(named: strImageName)
                self.imgTimer.isHidden = false
            }else {
                self.imgTimer.isHidden = true
            }
            
            if let strLimitInputTitle = popupInfoObj.strLimitInputTitle {
                self.lblSeconderyTitle.text = strLimitInputTitle
                self.lblSeconderyTitle.isHidden = false
            } else {
                self.lblSeconderyTitle.isHidden = true
            }
            
            if let strDescription = popupInfoObj.strDescription {
               self.lblNumber.text = strDescription
                self.lblNumber.isHidden = false
            }else {
                self.lblNumber.isHidden = true
            }
            
            if let strErrorEmail = popupInfoObj.strErrorEmail {
                self.lblSeconderySubTitle.text = strErrorEmail
                self.lblSeconderySubTitle.isHidden = false
            }else {
                self.lblSeconderySubTitle.isHidden = true
            }
            
            
            if let strSecondButtonImage = popupInfoObj.strSecondButtonImage {
                self.imgQRCode.image = UIImage(named: strSecondButtonImage)
                self.imgQRCode.isHidden = false
            }else {
                self.imgQRCode.isHidden = true
            }
        }
    }
}
