//
//  ExitViewController.swift
//  Ten
//
//  Created by inmanage on 16/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class ExitViewController: BasePopupViewController {

    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: LightLabel!
    @IBOutlet weak var btnYes: TenButtonStyle!
    @IBOutlet weak var btnNo: TenButtonStyle!
    @IBOutlet weak var btnExit: IMButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        if let popupInfoObj = self.popupInfoObj {
            
            if let strTitle = popupInfoObj.strTitle {
                self.lblTitle.text = strTitle
                self.lblTitle.isHidden = false
            }else {
                self.lblTitle.isHidden = true
            }
            
            if let strSubtitle = popupInfoObj.strSubtitle {
                self.lblSubTitle.text = strSubtitle
                self.lblSubTitle.isHidden = false
            }else {
                self.lblSubTitle.isHidden = true
            }
            
            if let strFirstButtonTitle = popupInfoObj.strFirstButtonTitle {
                self.btnYes.setTitle(strFirstButtonTitle, for: .normal)
                self.btnYes.isHidden = false
            }else {
                self.btnYes.isHidden = true
            }
            
            if let strSkipButtonTitle = popupInfoObj.strSkipButtonTitle {
                self.btnNo.setWhiteBackground()
                self.btnNo.setTitle(strSkipButtonTitle, for: .normal)
                self.btnNo.isHidden = false
            }else {
                self.btnNo.isHidden = true
            }
        }
    }
   
    //IBAction:
    @IBAction func didTapExitBtn(_ sender: Any) {
        if let aDelegate = self.popupViewControllerDelegate {
            if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                aDelegate.closePopupVC!(popupVC: self)
            }
        }
    }
    
    @IBAction func didTapYesBtn(_ sender: Any) {
        if let aPopupInfo = self.popupInfoObj {
            if let secondButtonAction = aPopupInfo.secondButtonAction {
                secondButtonAction()
            }
            self.didTapExitBtn(sender)
        }
    }
    
    @IBAction func didTapNoBtn(_ sender: Any) {
        if let aPopupInfo = self.popupInfoObj {
            if let firstButtonAction = aPopupInfo.firstButtonAction {
                firstButtonAction()
            }
            self.didTapExitBtn(sender)
        }
    }
}
