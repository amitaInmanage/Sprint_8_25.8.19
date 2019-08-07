//
//  StorePaymentActiveViewController.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StorePaymentActiveViewController: BaseFormViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var btnAddPayment: TenButtonStyle!
    
    var userId = 0
    var userType = 0
    var viewModel = StorePaymentActiveViewModel()
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var storePamentMathods = [StorePaymentMethodsItem]()
    
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.registerXibs()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
    
    fileprivate func initUI() {
        self.titleView.addShadow()
        self.view.backgroundColor = .clear
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.btnAddPayment.setReverseColor(textColor: UIColor.getApplicationThemeColor())
        self.btnAddPayment.setClearBackground()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.storePayment, Translations.Titles.storePaymentDefault)
    }
    
    fileprivate func registerXibs()  {
        self.tableView.register(UINib(nibName: StorePaymentTableViewCell.className, bundle: nil), forCellReuseIdentifier: StorePaymentTableViewCell.className)
    }
    
    //IBAction:
    @IBAction func didTapAddPayment(_ sender: Any) {
        ApplicationManager.sharedInstance.userAccountManager.callAddCreditCard(requestFinishedDelegate: self)
    }
}

extension StorePaymentActiveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storePamentMathods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StorePaymentTableViewCell.className, for: indexPath) as! StorePaymentTableViewCell
        cell.delegate = self
        
        if storePamentMathods[indexPath.row].isRemovable {
            userId = storePamentMathods[indexPath.row].intId
            userType = storePamentMathods[indexPath.row].intType
        }
        
        if storePamentMathods[indexPath.row].isActiveInStore {
            
            cell.imgCardType.setImageWithStrURL(strURL: storePamentMathods[indexPath.row].strIcon, withAddUnderscoreIphone: false)
            cell.lblCardNumber.text = storePamentMathods[indexPath.row].strTitle
            
            if !storePamentMathods[indexPath.row].isRemovable {
                cell.lblRemove.isHidden = true
                cell.btnRemove.isHidden = true
                cell.vwBetween.isHidden = true
                cell.btnRemoveStorePayment.isHidden = true
            } else {
                cell.lblRemove.isHidden = false
                cell.btnRemove.isHidden = false
                cell.vwBetween.isHidden = false
                cell.btnRemoveStorePayment.isHidden = false
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension StorePaymentActiveViewController: RemoveStorePaymentDelegate {
    
    func didTapRemoveStorePayment() {
        
        self.viewModel.id = self.userId
        self.viewModel.type = self.userType
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .exit
        popupInfoObj.strTitle = Translation(Translations.Titles.popupRemovePaymentMethod, Translations.Titles.popupRemovePaymentMethodDefault)
        popupInfoObj.strSkipButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardNo, Translations.AlertButtonsKeys.popupRemoveFuelingCardNoDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardYes, Translations.AlertButtonsKeys.popupRemoveFuelingCardYesDefault)
        popupInfoObj.firstButtonAction = {
            self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}

extension StorePaymentActiveViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == TenRequestNames.getRemoveStorePaymentMethod {
            UserAccountManager.sharedInstance.validateUserPayment(storePamentMathods: self.storePamentMathods)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        if let innerResponse = innerResponse as? AddCreditCardResponse {
            
            if request.requestName == TenRequestNames.getAddCreditCard {
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
