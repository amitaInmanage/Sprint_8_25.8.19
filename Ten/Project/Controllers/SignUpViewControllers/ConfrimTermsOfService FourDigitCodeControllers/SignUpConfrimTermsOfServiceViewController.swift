//
//  ConfrimTermsOfServiceViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import WebKit

class SignUpConfrimTermsOfServiceViewController: BaseFormViewController, WKNavigationDelegate {
    
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var lblSubTitle: BoldText!
    @IBOutlet weak var webViewTermsOfService: IMWebView!
    @IBOutlet weak var btnConfrimTermsOfUse: UIButton!
    
    var parentVC: UIViewController?
    var viewModel = SignUpConfrimTermsOfServiceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        self.loadUrl()
        
        let tabBarController = ApplicationManager.sharedInstance.tabBarController
        tabBarController.backDelegate = self
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
            vc.changeConstraint(trailingConstraint: 0,
                                bottomConstraint: 0,
                                leadingConstraint: 0,
                                containerHeightConst: vc.view.frame.height)
            vc.containerView.backgroundColor = .clear
            vc.view.backgroundColor = .clear
            vc.vwContent = nil
            vc.containerView = nil
            vc.navigationItem.hidesBackButton = true
            
            self.parentVC = vc
        }
    }
    

    
    func initializeUI() {
        self.view.backgroundColor = .clear
        self.webViewTermsOfService.backgroundColor = .white
        self.lblSubTitle.text = self.viewModel.strTitle
        self.btnConfrimTermsOfUse.titleLabel?.font = UIFont(name: "Heebo-Medium", size: 18)
        self.btnConfrimTermsOfUse.setTitle(Translation(Translations.Titles.confirm, Translations.Titles.confirmDefault), for: .normal)
        self.btnConfrimTermsOfUse.backgroundColor = UIColor.getApplicationThemeColor()
        self.btnConfrimTermsOfUse.layer.cornerRadius = 8
        if #available(iOS 11.0, *) {
            btnConfrimTermsOfUse.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            print("iOS Device < 11.0")
        }
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
    
    @IBAction func didTapBtnConfrimTermsOfUse(_ sender: Any) {
        ApplicationManager.sharedInstance.userAccountManager.updateScreensAndRegistrationToken(registrationToken: nil, screens: nil)
    }
}

extension SignUpConfrimTermsOfServiceViewController: BackProtocol {
    func backCompletion() {
        guard let vc = self.parentVC as? TenStyleViewController else { return }
            let controller = (vc.navigationController?.viewControllers[0])!
                vc.navigationController?.popToViewController(controller, animated: true)
    }
}
