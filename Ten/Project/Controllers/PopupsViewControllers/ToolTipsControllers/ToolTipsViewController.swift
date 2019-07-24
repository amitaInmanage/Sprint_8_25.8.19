//
//  ToolTipsViewController.swift
//  Ten
//
//  Created by inmanage on 03/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class ToolTipsViewController: BasePopupViewController {

    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var imgSecondaryGeneral: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        
        if let popupInfoObj = self.popupInfoObj {
            
            if let strImageName = popupInfoObj.strImageName {
                self.imgSecondaryGeneral.image = UIImage(named: strImageName)
                self.imgSecondaryGeneral.isHidden = false
            }else {
                self.imgSecondaryGeneral.isHidden = true
            }
            
            if let strTitle = popupInfoObj.strTitle {
                self.lblTitle.text = strTitle
                self.lblTitle.isHidden = false
            }else {
                self.lblTitle.isHidden = true
            }
            
        
        }
    }
    
    //MARK: IBAction:
    @IBAction func didTapExit(_ sender: Any) {
        
        if let aDelegate = self.popupViewControllerDelegate {
            if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                aDelegate.closePopupVC!(popupVC: self)
            }
        }
    }
    
    @IBAction func dismmisPopup(_ sender: UIButton) {
        self.didTapExit(sender)
    }
}
