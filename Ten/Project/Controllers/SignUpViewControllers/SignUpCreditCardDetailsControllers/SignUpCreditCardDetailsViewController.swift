//
//  SignUpCreditCarDetailsViewController.swift
//  Ten
//
//  Created by inmanage on 30/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import JavaScriptCore


class SignUpCreditCardDetailsViewController: BaseFormViewController, UIWebViewDelegate, CardIOPaymentViewControllerDelegate {
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: LightLabel!
    @IBOutlet weak var btnOpenCamera: LightButton!
    @IBOutlet weak var webView: UIWebView!
    
    var isAddCreditCard = false
    var viewModel = SignUpCreditCardViewModel()
    var screenName = ""
    var redactedCardNumber = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        CardIOUtilities.preload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func initializeUI() {
        self.webView.delegate = self
        self.loadUrl()
        self.btnOpenCamera.designbtnOpenCamera()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.creditCardDetails, Translations.Titles.creditCardDetailsDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.creditCardSubTitle, Translations.SubTitles.creditCardSubTitleDefault)
        self.btnOpenCamera.setTitle(Translation(Translations.AlertButtonsKeys.openCamera, Translations.AlertButtonsKeys.openCameraDefault), for: .normal)
    }
    
    fileprivate func loadUrl() {
        let url = URL (string: self.viewModel.strWebViewUrl)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    
    //Mark: IBAction
    @IBAction func didTapOpenCamera(_ sender: Any) {
        
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.hideCardIOLogo = true
        cardIOVC?.guideColor = .green
        cardIOVC?.collectCVV = false
        self.present(cardIOVC!, animated: true, completion: nil)
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {

        paymentViewController.dismiss(animated: true, completion: nil)
    
        let param1 = cardInfo.cardNumber
        let param2 = cardInfo.expiryMonth
        let param3 = cardInfo.expiryYear
        let year = param3 % 100
        let month = param2 < 10 ? "0\(param2)" : "\(param2)"
        let date = ("\(month)/\(year)")
        let strFunc = "fillCreditCardData('\(param1!)','\(date)')"
        self.webView.stringByEvaluatingJavaScript(from: strFunc)

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if let strUrl = webView.request?.url?.absoluteString {
            if strUrl.contains("\(PaymentUrlPrefix.baseUrl)\(PaymentUrlPrefix.path)") {
                let success = strUrl.contains("/success/")
                let failed = strUrl.contains("/failure/")
                
                if success {
                    let jsonObject = ParseValidator.parseUrlToJson(strUrl: strUrl, andSubString: "?json=")
                    if isAddCreditCard {
                        if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: StorePaymentActiveViewController.className) as? StorePaymentActiveViewController {
                            ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                        }
                    } else {
                        if let data = UpdateRegistrationDataResponse().buildFromJSONDict(JSONDict: jsonObject) as? UpdateRegistrationDataResponse {
                            
                            ApplicationManager.sharedInstance.userAccountManager.updateScreensAndRegistrationToken(registrationToken: nil, screens: data.arrNextScreens)
                        }
                    }
                } else if failed {
                    //TODO: faild  ?
                print("faildpdjfkdsjsfdsk;jfndsakjfnasdfdsj")
                } else {
                    //TODO: else ?
                }
            }
        }
    }
}
