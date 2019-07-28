//
//  TransactionsHistoryViewController.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

enum States: Int {
    case allPurchases = 0
    case refueling = 1
    case stores = 2
}

enum PagerFontState: String {
    case regular = "OpenSansHebrew-Regular"
}

class TransactionsHistoryViewController : BaseFormViewController {
    
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var viewModel = TransactionsHistoryViewModel()
    var state = Box<States>(States.allPurchases)
    var all: [TransactionHistoryItem] = []
    var allTransactionHistoryResponse: GetTransactionsHistoryResponse?
    var isWaitingForResponse = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: IMLabel!
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblDeluqs: UILabel!
    @IBOutlet weak var lblStores: UILabel!
    @IBOutlet weak var underLinevw2: UIView!
    @IBOutlet weak var underLinevw1: UIView!
    @IBOutlet weak var underLinevw0: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerXibs()
        self.initUI()
        self.initTableView()
        self.initializeBindings()
        
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
        }
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = .clear
        self.initTabBar()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.transactionsHistory, Translations.Titles.transactionsHistoryDefault)
    }
    
    fileprivate func registerXibs()  {
        self.tableView.register(UINib(nibName: StoresTableViewCell.className, bundle: nil), forCellReuseIdentifier: StoresTableViewCell.className)
    }
    
    fileprivate func stores(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
       
       
        
        if self.all[indexPath.row].intType == 2 {
            
        }
        
        if self.all[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(all[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.all[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(all[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        cell.imgType.setImageWithStrURL(strURL: all[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = all[indexPath.row].store.strTitle
        cell.lblDate.text = all[indexPath.row].strDate
        cell.lblTime.text = all[indexPath.row].strTime
        cell.lblAmount.text = all[indexPath.row].amount.strValue
        
        return cell
    }
    
    fileprivate func initializeBindings() {
        self.state.bind { [unowned self] (newVal) in
            switch self.state.value {
                
            case .allPurchases:
                self.initTabBar()
                if self.allTransactionHistoryResponse == nil {
                    self.viewModel.type = self.state.value.rawValue
                    self.isWaitingForResponse = true
                    self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                }
                
            case .refueling:
                self.initTabBar()
                
            case .stores:
                self.initTabBar()
            }
        }
    }
    
    @IBAction func didTapAll(_ sender: Any) {
        self.state.value = .allPurchases
    }
    
    @IBAction func didTapRefueling(_ sender: Any) {
        self.state.value = .refueling
    }
    
    @IBAction func didTapStores(_ sender: Any) {
        self.state.value = .stores
    }
}

extension TransactionsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.state.value {
        case .allPurchases:
            return self.stores(tableView, cellForRowAt: indexPath)
            
        case .refueling:
            //            return self.stores(tableView, cellForRowAt: indexPath)
            break
        case .stores:
            //              return self.stores(tableView, cellForRowAt: indexPath)
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StoresTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
       all[indexPath.row].isExtended = !all[indexPath.row].isExtended
            
        if all[indexPath.row].isExtended {
            UIView.animate(withDuration: 0.3) {
                cell.imgUp.image = UIImage(named: "up")
                cell.historyBottomConstraint.constant = 198.5
                cell.dropDown.isHidden = false
                //cell.imgType.setImageWithStrURL(strURL: self.user.fuelingDevicesArr[indexPath.row].strIcon, withAddUnderscoreIphone: false)
                //cell.imgFuelType.setImageWithStrURL(strURL: self.user.fuelingDevicesArr[indexPath.row].fuelItem.strImage, withAddUnderscoreIphone: false)
                cell.lblCarNumber.text = self.user.fuelingDevicesArr[indexPath.row].strTitle
                cell.vwHistory.removeShadow()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                cell.imgUp.image = UIImage(named: "down")
                cell.historyBottomConstraint.constant = 129
                cell.dropDown.isHidden = true
                cell.vwHistory.addShadow()
            }
        }
        self.view.layoutIfNeeded()
        self.tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if allTransactionHistoryResponse?.hasNextPage == true && !self.isWaitingForResponse {
                isWaitingForResponse = true
                self.viewModel.currentPage += 1
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
            }
        }
    }
}

extension TransactionsHistoryViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getTransactionsHistory {
            if let innerResponse = innerResponse as? GetTransactionsHistoryResponse {
                self.all.append(contentsOf: innerResponse.transactionHistoryList)
                self.allTransactionHistoryResponse = innerResponse
                self.tableView.reloadData()
                isWaitingForResponse = false
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}


extension TransactionsHistoryViewController {
    func initTabBar() {
        switch self.state.value {
        case .allPurchases:
            self.underLinevw0.backgroundColor = UIColor.getApplicationThemeColor()
            self.underLinevw1.backgroundColor = .white
            self.underLinevw2.backgroundColor = .white
            self.lblAll.font =  UIFont.boldSystemFont(ofSize: lblAll.font.pointSize)
            self.lblDeluqs.font =  UIFont(name: PagerFontState.regular.rawValue, size: 16)
            self.lblStores.font =  UIFont(name: PagerFontState.regular.rawValue, size: 16)
            self.loadViewIfNeeded()
            
            break
        case .refueling:
            self.underLinevw0.backgroundColor = .white
            self.underLinevw1.backgroundColor = UIColor.getApplicationThemeColor()
            self.underLinevw2.backgroundColor = .white
            self.lblAll.font =  UIFont(name: PagerFontState.regular.rawValue, size: 16)
            self.lblDeluqs.font =  UIFont.boldSystemFont(ofSize: lblDeluqs.font.pointSize)
            self.lblStores.font =  UIFont(name: PagerFontState.regular.rawValue, size: 16)
            self.loadViewIfNeeded()
            
            break
        case .stores:
            self.underLinevw0.backgroundColor = .white
            self.underLinevw1.backgroundColor = .white
            self.underLinevw2.backgroundColor = UIColor.getApplicationThemeColor()
            self.lblAll.font =  UIFont(name: PagerFontState.regular.rawValue, size: 16)
            self.lblDeluqs.font =  UIFont(name: PagerFontState.regular.rawValue, size: 16)
            self.lblStores.font =  UIFont.boldSystemFont(ofSize: lblStores.font.pointSize)
            self.loadViewIfNeeded()
            
            break
        }
    }
    
    func initTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.view.backgroundColor = .clear
        self.tableView.reloadData()
    }
}
