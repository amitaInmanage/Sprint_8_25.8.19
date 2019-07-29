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
    
    var storePamentMathods = [StorePaymentMethodsItem]()
    var isAddCreditCard = false
    var viewModel = SignUpCreditCardViewModel()
    var screenName = ""
    var redactedCardNumber = ""
    var fieldsArr = [String: Any]()
    
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
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .unicode) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if let strUrl = webView.request?.url?.absoluteString {
            if strUrl.contains("\(PaymentUrlPrefix.baseUrl)\(PaymentUrlPrefix.path)") {
                let success = strUrl.contains("/success/")
                let failed = strUrl.contains("/failure/")
                
                if success {
                    
                    var jsonArr = [String]()
                    jsonArr = strUrl.components(separatedBy: "json=")
                    let json = jsonArr[1].removingPercentEncoding!
                    let jsonDict = self.convertToDictionary(text: json)
                    
                    if isAddCreditCard {
                        if let data = SuccessAddCraditCardResponse().buildFromJSONDict(JSONDict: jsonDict ) as? SuccessAddCraditCardResponse {
                            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: StorePaymentActiveViewController.className) as? StorePaymentActiveViewController {
                               
                                if !ApplicationManager.sharedInstance.userAccountManager.user.storePaymentMethods.isEmpty {
                                    for storePaymante in data.user.storePaymentMethods {
                                        if storePaymante.isActiveInStore {
                                            storePamentMathods.append(storePaymante)
                                        }
                                    }
                                }
                                personalZone.storePamentMathods = storePamentMathods
                                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
                            }
                        }
                    } else {
                        
                        if let data = UpdateRegistrationDataResponse().buildFromJSONDict(JSONDict: jsonDict ) as? UpdateRegistrationDataResponse {
                            
                            ApplicationManager.sharedInstance.userAccountManager.updateScreensAndRegistrationToken(registrationToken: ApplicationManager.sharedInstance.userAccountManager.registrationToken, screens: data.arrNextScreens)
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

