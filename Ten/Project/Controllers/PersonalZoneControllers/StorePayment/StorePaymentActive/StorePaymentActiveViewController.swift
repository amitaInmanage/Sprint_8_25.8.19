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
    
    var counter = 0
    var userId = 0
    var userType = 0
    var viewModel = StorePaymentActiveViewModel()
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    
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
        return self.user.storePaymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StorePaymentTableViewCell.className, for: indexPath) as! StorePaymentTableViewCell
        cell.delegate = self
        
        if user.storePaymentMethods[indexPath.row].isActiveInStore {
            
            userId = self.user.storePaymentMethods[indexPath.row].intId
            userType = self.user.storePaymentMethods[indexPath.row].intType
            
            cell.imgCardType.setImageWithStrURL(strURL: self.user.storePaymentMethods[indexPath.row].strIcon, withAddUnderscoreIphone: false)
            cell.lblCardNumber.text = self.user.storePaymentMethods[indexPath.row].strtitle
            
            
            if !user.storePaymentMethods[indexPath.row].isRemovable {
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
        self.tableView.reloadData()
        self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
    }
}

extension StorePaymentActiveViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == TenRequestNames.getRemoveStorePaymentMethod {
            
                UIView.animate(withDuration: 0.3) {
                self.tableView.reloadData()
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
