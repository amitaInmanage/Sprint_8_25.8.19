//
//  PickPumpObligoLiterViewController.swift
//  Ten
//
//  Created by shani daniel on 14/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit


enum LimitFormatOptions : Int {
    
    case Liter = 0 , Money
    
    static let allValues = [Liter, Money]
}

class PickPumpObligoLiterPopupViewController: BasePopupViewController { 
    
    @IBOutlet weak var popupConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblchosenFuelingLimitFormat: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnConfirm: TenButtonStyle!
    @IBOutlet weak var btnInit: MediumButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vwInput: UIView!
    @IBOutlet weak var vwPickLimitFormt: UIView!
    @IBOutlet weak var lblPickLimitFormatTitle: UILabel!
    @IBOutlet weak var lblLimitInputTitle: RegularLabel!
    @IBOutlet weak var texFldInput: UITextField!
    @IBOutlet weak var txtFidInput: UITextField!
    @IBOutlet weak var btnMoney: UIButton!
    @IBOutlet weak var btnLiter: UIButton!
    
    var chosenFuelingLimitFormat = LimitFormatOptions.Money
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
            
            
            
            switch self.chosenFuelingLimitFormat {
                
            case LimitFormatOptions.Liter :
                
                if let aStrLiterTxt = aPopupInfo.strLiterTxt {
                    self.lblchosenFuelingLimitFormat.text = aStrLiterTxt
                } else {
                    self.lblchosenFuelingLimitFormat.isHidden = true
                }
                
                //self.lblLiter.textColor = UIColor.getApplicationTextColor()
                /*
                if let aStrLiterFuelingLimitDefault = aPopupInfo.strLiterFuelingLimitDefault {
                    
                }
                
                self.txtFidInput.attributedPlaceholder = NSAttributedString(string: aStrLiterFuelingLimitDefault , attributes: [
                    .foregroundColor: UIColor.lightGray,
                    .font: UIFont.boldSystemFont(ofSize: 45.0)
                    ])
                */
                
                break
                
            case LimitFormatOptions.Money :
                
                
                if let aStrMoneyTxt = aPopupInfo.strMoneyTxt {
                    self.lblchosenFuelingLimitFormat.text = aStrMoneyTxt.stringWithNIS()  //aStrMoneyTxt
                } else {
                    self.lblchosenFuelingLimitFormat.isHidden = true
                }
                
                //self.lblMoney.textColor = UIColor.getApplicationTextColor()
                
                /*
                 
                 if let aStrMoneyFuelingLimitDefault = aPopupInfo.strMoneyFuelingLimitDefault {
                 
                 }
                self.txtFidInput.attributedPlaceholder = NSAttributedString(string: aStrMoneyFuelingLimitDefault , attributes: [
                    .foregroundColor: UIColor.lightGray,
                    .font: UIFont.boldSystemFont(ofSize: 45.0)
                    ])
                */
                
                break
            }
            
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblTitle.text = aStrTitle
            } else {
                self.lblTitle.isHidden = true
            }
            
            if let aStrPickLimitFormatTitle = aPopupInfo.strPickLimitFormatTitle {
                self.lblPickLimitFormatTitle.text = aStrPickLimitFormatTitle
            } else {
                self.lblPickLimitFormatTitle.isHidden = true
            }
            
            if let aStrLimitInputTitle = aPopupInfo.strLimitInputTitle {
                self.lblLimitInputTitle.text = aStrLimitInputTitle
            } else {
                self.lblLimitInputTitle.isHidden = true
            }
           /*
            if let aStrLiterTxt = aPopupInfo.strLiterTxt {
                self.lblLiter.text = aStrLiterTxt
            } else {
                self.lblLiter.isHidden = true
            }
            
            if let aStrMoneyTxt = aPopupInfo.strMoneyTxt {
                self.lblMoney.text = aStrMoneyTxt
            } else {
                self.lblMoney.isHidden = true
            }
            */
            self.vwInput.layer.cornerRadius = self.vwInput.frame.size.height / 4.16
            
            self.vwInput.layer.borderColor = UIColor.getApplicationTenButtonColor().cgColor
            self.vwInput.layer.borderWidth = 1
            
            if let strConfirmBtn = aPopupInfo.strConfirmButtonTitle {
                
                self.btnConfirm.setTitle(strConfirmBtn, for: .normal)
                
                self.btnConfirm.isHidden = false
            } else {
                self.btnConfirm.isHidden = true
            }
            
            if let strInitBtn = aPopupInfo.strInitButtonTitle {
                
                let font = UIFont.getBtnFontWithFontName(fontClass: MediumButton(), fontSize: 14)
                self.btnInit.setAttributedTitle(ApplicationManager.sharedInstance.stringManager.attributeStringWithUnderline(string: strInitBtn, font: font), for: .normal)
                
                self.btnInit.isHidden = false
            } else {
                self.btnInit.isHidden = true
            }
            
        }
    }
    
    /*
    func initFuelingLimitInput() {
        
        switch chosenFuelingLimitFormat {
            
        case LimitFormatOptions.Liter :
            self.txtFidInput.placeholder = self.aStrLiterFuelingLimitDefault
            break
            
        case LimitFormatOptions.Money :
            self.txtFidInput.placeholder = self.aStrMoneyFuelingLimitDefault
            break
        }
        
    }
    */
 
 
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
    
    
    @IBAction func didTapInit(_ sender: Any) {
        
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    // MARK: - UIKeyboardNotifications
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let tabBarHeight = self.tabBarController != nil ? (self.tabBarController?.tabBar.height())! : 0
            if self.popupConstraint.constant != keyboardSize.height - tabBarHeight{
                self.popupConstraint.constant = keyboardSize.height - tabBarHeight
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let buttonsConstraintInit = 29
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.popupConstraint.constant != CGFloat(buttonsConstraintInit) {
                self.popupConstraint.constant = CGFloat(buttonsConstraintInit)
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}







