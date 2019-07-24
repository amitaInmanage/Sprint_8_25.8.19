//
//  InvoicingNumberViewController.swift
//  Ten
//
//  Created by inmanage on 11/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class InvoicingNumberViewController: BasePopupViewController {
    

    @IBOutlet weak var txtFldInvoicingNumber: InputCustomView!
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var imgInvocing: UIImageView!
    @IBOutlet weak var btnConutinue: TenButtonStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    

    func setupUI() {
        
        if let popupInfoObj = self.popupInfoObj {
            
            if let strImageName = popupInfoObj.strImageName {
                self.imgInvocing.image = UIImage(named: strImageName)
                self.imgInvocing.isHidden = false
            }else {
                self.imgInvocing.isHidden = true
            }
            
            if let strTitle = popupInfoObj.strTitle {
                self.lblTitle.text = strTitle
                self.lblTitle.isHidden = false
            }else {
                self.lblTitle.isHidden = true
            }
            
            if let strFirstButtonTitle = popupInfoObj.strFirstButtonTitle {
                self.btnConutinue.setTitle(strFirstButtonTitle, for: .normal)
                self.btnConutinue.isHidden = false
            }else {
                self.btnConutinue.isHidden = true
            }

        }
    }
    
    @IBAction func didTapContinueBtn(_ sender: Any) {
    }
    
}

