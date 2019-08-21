//
//  StorePaymentViewController.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StorePaymentViewController: BaseFormViewController {
    
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var lblSubTitle: RegularText!
    
    var viewModel = StorePaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.storePayment, Translations.Titles.storePaymentDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.storePayment, Translations.Titles.storePaymentDefault)
    }
    
    //IBAction:
    @IBAction func didTapBtnAddPayment(_ sender: Any) {
        ApplicationManager.sharedInstance.userAccountManager.callAddCreditCard(requestFinishedDelegate: self)
    }
}

extension StorePaymentViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == TenRequestNames.getAddCreditCard {
            
           if let innerResponse = innerResponse as? AddCreditCardResponse {
            
                if let signUp = UIStoryboard.init(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: SignUpCreditCardDetailsViewController.className) as? SignUpCreditCardDetailsViewController {
                    signUp.viewModel.strWebViewUrl = innerResponse.strUrl
                    signUp.isAddCreditCard = true
                    ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUp, animated: true)
                }
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}
