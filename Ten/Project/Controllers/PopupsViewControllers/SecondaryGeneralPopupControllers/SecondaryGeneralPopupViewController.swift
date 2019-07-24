//
//  SecondaryGeneralViewController.swift
//  Ten
//
//  Created by shani daniel on 08/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//


import UIKit

class SecondaryGeneralPopupViewController: BasePopupViewController {
    
    @IBOutlet weak var lblBottom: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var imgSecondaryGeneral: UIImageView!

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
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aStrImg = aPopupInfo.strImageName {
                self.imgSecondaryGeneral.image = UIImage(named: aStrImg)
            }
            
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblTitle.text = aStrTitle
            } else {
                self.lblTitle.isHidden = true
            }
            
            if let aStrSubitle = aPopupInfo.strSubtitle {
                self.lblSubTitle.text = aStrSubitle
                
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
            
            if let aStrBottomText = aPopupInfo.strBottomText {
                self.lblBottom.text = aStrBottomText
            } else {
                self.lblBottom.isHidden = true
            }
            
            if let strConfirmBtn = aPopupInfo.strConfirmButtonTitle {
                
       
            }
            
            if let strSkipBtn = aPopupInfo.strSkipButtonTitle {
                
                let font = UIFont.getBtnFontWithFontName(fontClass: MediumButton(), fontSize: 14)
                self.btnSkip.setAttributedTitle(ApplicationManager.sharedInstance.stringManager.attributeStringWithUnderline(string: strSkipBtn, font: font), for: .normal)
                
                self.btnSkip.isHidden = false
            } else {
                self.btnSkip.isHidden = true
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
    
    @IBAction func didTapSkip(_ sender: Any) {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aSkipButtonAction = aPopupInfo.skipButtonAction {
                aSkipButtonAction()
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
    
/*
    func oneLabelWithTwoFonts (originalString: String)  {
        
        if originalString.contains("<") && originalString.contains(">") {
        
        let firstStr = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "")
        
        let secondStr = ApplicationManager.sharedInstance.stringManager.getStringBetweenCharacter(str1: "<", and: ">", fromString: originalString)
        
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor : UIColor.green]
        
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string: firstStr, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: secondStr, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        
        self.lblSubTitle.attributedText = attributedString1
        
        //return attributedString1
            
        }else {
            self.lblSubTitle.text = originalString
        }
        
    }
 
*/
    
}
