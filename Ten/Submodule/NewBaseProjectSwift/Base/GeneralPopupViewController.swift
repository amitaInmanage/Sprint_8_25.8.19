//
//  GeneralPopupViewController.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 04/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

enum SubtitleAlignment {
    case center
    case right
    case left
}

class GeneralPopupViewController: BasePopupViewController {

    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubtitle: RegularLabel!
    @IBOutlet weak var vwStackButtons: UIStackView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    var subtitleAlignment = SubtitleAlignment.center
    
    @IBOutlet weak var imgGeneral: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - General
    func setupUI() {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aStrImg = aPopupInfo.strImageName {
                self.imgGeneral.image = UIImage(named: aStrImg)
            }
            
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblTitle.text = aStrTitle
            }
            
            if let aStrSubitle = aPopupInfo.strSubtitle {
                self.lblSubtitle.text = aStrSubitle
                switch subtitleAlignment {
                case .left:
                    self.lblSubtitle.textAlignment = .left
                    break
                case .right:
                    self.lblSubtitle.textAlignment = .right
                    break
                case.center:
                    self.lblSubtitle.textAlignment = .center
                    break
                }
            }
            
            if let strFirstBtn = aPopupInfo.strFirstButtonTitle {
                self.btnConfirm.setTitle(strFirstBtn, for: .normal)
                self.btnConfirm.isHidden = false
            } else {
                self.btnConfirm.isHidden = true
            }
            
            if let strSecondBtn = aPopupInfo.strSecondButtonTitle {
                self.btnCancel.setTitle(strSecondBtn, for: .normal)
                self.btnCancel.isHidden = false
            } else {
                self.btnCancel.isHidden = true
            }
        }
        
    }

    @IBAction func didTapConfirm(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aFirstButtonAction = aPopupInfo.firstButtonAction {
                aFirstButtonAction()
            }
            
            if let aDelegate = self.popupViewControllerDelegate {
                if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                    
                    aDelegate.closePopupVC!(popupVC: self)
                }
                
            }
        }
        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aSecondButtonAction = aPopupInfo.secondButtonAction {
                aSecondButtonAction()
            }
            
            if let aDelegate = self.popupViewControllerDelegate {
                if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                    
                    aDelegate.closePopupVC!(popupVC: self)
                }
                
            }
        }
        
    }
    
    
}
