//
//  ConfrimTermsOfServiceViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import WebKit

class SignUpConfrimTermsOfServiceViewController: BaseFormViewController, WKNavigationDelegate, ActionBottomBtnDelegate {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: BoldLabel!
    @IBOutlet weak var webViewTermsOfService: IMWebView!
    
    var viewModel = SignUpConfrimTermsOfServiceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        self.loadUrl() 
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
            vc.bottomBtn.width()
        }
    }
    
    func initializeUI() {
        self.lblSubTitle.text = self.viewModel.strTitle
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.welcomeDelekTen, Translations.Titles.welcomeDelekTenDefault)
    }
    
    fileprivate func loadUrl() {
        if !self.viewModel.strUrl.isEmpty {
            let url = URL (string: self.viewModel.strUrl)
            let request = URLRequest(url: url!)
            webViewTermsOfService.loadRequest(request)
        } else {
            webViewTermsOfService.loadHTMLString(self.viewModel.strHTML, baseURL: nil)
        }
    }
    
    func didTapBottomBtn() {
        ApplicationManager.sharedInstance.userAccountManager.updateScreensAndRegistrationToken(registrationToken: nil, screens: nil)
    }
}



