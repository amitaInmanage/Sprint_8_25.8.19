//
//  TenGanrelPopupViewController.swift
//  Ten
//
//  Created by inmanage on 03/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TenGanrelPopupViewController: BasePopupViewController {
    
    @IBOutlet weak var imgSecondaryGeneral: UIImageView!
    @IBOutlet weak var lblTitle: MediumBoldText!
    @IBOutlet weak var lblSubTitle: RegularText!
    @IBOutlet weak var lblSecondSubTitle: RegularText!
    @IBOutlet weak var btnConfirm: TenButtonStyle!
    @IBOutlet weak var btnSkip: MediumBtn!
    @IBOutlet weak var btnsStackView: UIStackView!
    @IBOutlet weak var btnExit: IMButton!
 
    var subtitleAlignment = SubtitleAlignment.center
    var viewModel = TenGanrelPopupViewModel()
    
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
            
            if let strSubTitle = popupInfoObj.strSubtitle {
                self.lblSubTitle.text = strSubTitle
                self.lblSubTitle.isHidden = false
            } else {
                self.lblSubTitle.isHidden = true
            }
            
            if let strBottomText = popupInfoObj.strBottomText {
                self.lblSecondSubTitle.text = strBottomText
                self.lblSecondSubTitle.isHidden = false
            }else {
                self.lblSecondSubTitle.isHidden = true
            }
            
            if let strFirstButtonTitle = popupInfoObj.strFirstButtonTitle {
                self.btnConfirm.setTitle(strFirstButtonTitle, for: .normal)
                self.btnConfirm.isHidden = false
            }else {
                self.btnConfirm.isHidden = true
            }
            
            if let strSecondButtonTitle = popupInfoObj.strSecondButtonTitle {
                self.btnSkip.addUnderline(title: strSecondButtonTitle)
                self.btnSkip.isHidden = false
            }else {
                self.btnSkip.isHidden = true
            }
            
            self.btnExit?.isHidden = !(popupInfoObj.shouldHaveCloseBtn ?? true)
            
        }
        
        if btnSkip.isHidden == true && btnConfirm.isHidden == true {
            self.btnsStackView.isHidden = true
        }
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            if let firstButtonAction = aPopupInfo.firstButtonAction {
                firstButtonAction()
            }
           self.didTapExit(sender)
        }
    }
    
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
    
    @IBAction func didTapSkip(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            if let secondButtonAction = aPopupInfo.secondButtonAction {
                secondButtonAction()
            }
            self.didTapExit(sender)
        }
    }
}
