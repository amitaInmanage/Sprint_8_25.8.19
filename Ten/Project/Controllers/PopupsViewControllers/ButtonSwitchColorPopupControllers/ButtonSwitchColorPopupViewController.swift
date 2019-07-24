//
//  buttonSwitchColorPopupViewController.swift
//  Ten
//
//  Created by shani daniel on 08/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

enum BtnConfirmColors : Int {
    
    case Green = 0 , Blue
    static let allValues = [Green, Blue]
}

class ButtonSwitchColorPopupViewController: BasePopupViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnConfirm: TenButtonStyle!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var vwFuelType: FuelTypeCustomView!
    @IBOutlet weak var txtFuelType: UILabel!
    
    var currentBtnConfirmColor = BtnConfirmColors.Blue
    
    var subtitleAlignment = SubtitleAlignment.center
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - General
    func setupUI() {
        
        if let image =  UIImage(named: "bigNoText") {
            self.vwFuelType.imgFuel.image = image
        }
        self.vwFuelType.txtFuel.text = "95" //TODO:get from object MediumLabel
        
        let font = UIFont(name: MediumLabel.getFontName(), size: 15)
        
        self.vwFuelType.txtFuel.font = font
        
        self.txtFuelType.text = "סולר"//TODO:get from object
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblTitle.text = aStrTitle
            } else {
                self.lblTitle.isHidden = true
            }
            
            if let aStrSubitle = aPopupInfo.strSubtitle {
                
                if ApplicationManager.sharedInstance.stringManager.splitString(originalString: aStrSubitle).count > 1 {
                    
                    let firstStr = ApplicationManager.sharedInstance.stringManager.splitString(originalString: aStrSubitle)[0]
                    let secondStr = ApplicationManager.sharedInstance.stringManager.splitString(originalString: aStrSubitle)[1]
                    let firstFont =  UIFont(name: LightLabel.getFontName(), size: 14)
                    let secondFont = UIFont(name: MediumLabel.getFontName(), size: 14)
                    
                    self.lblSubTitle.attributedText = ApplicationManager.sharedInstance.stringManager.setAttributedStringWithTwoFonts(firstStr: firstStr, firstFont: firstFont!, secondStr: secondStr, secondFont: secondFont!)
                 
                } else {
                    self.lblSubTitle.text = aStrSubitle
                }
                
                switch subtitleAlignment {
                case .left:
                    self.lblSubTitle.textAlignment = .left
                    break
                case .right:
                    self.lblSubTitle.textAlignment = .right
                    break
                case.center:
                    self.lblSubTitle.textAlignment = .center
                    break
                }
            } else {
                self.lblSubTitle.isHidden = true
            }
            
            if let strConfirmBtn = aPopupInfo.strConfirmButtonTitle {

                if let aBtnConfirmColor = aPopupInfo.btnConfirmColor {
                    
                    self.btnConfirm.setTitle(strConfirmBtn, for: .normal)
                    
                    switch aBtnConfirmColor {
                        
                    case BtnConfirmColors.Green:
                        
                        self.btnConfirm.backgroundColor = UIColor.getAppGreenButtonColor()
                       
                    case BtnConfirmColors.Blue:
                        
                        self.btnConfirm.backgroundColor = UIColor.getApplicationTenButtonColor()
                    }
                }
         
                self.btnConfirm.isHidden = false
            } else {
                self.btnConfirm.isHidden = true
            }
        }
        
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aConfirmButtonAction = aPopupInfo.confirmButtonAction {
                aConfirmButtonAction()
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
