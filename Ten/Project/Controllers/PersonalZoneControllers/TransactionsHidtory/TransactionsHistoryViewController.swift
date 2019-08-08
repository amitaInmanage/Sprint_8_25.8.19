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
    var fuelingDevices = ApplicationManager.sharedInstance.userAccountManager.user.fuelingDevicesArr
    var transactionHistoryItems = [TransactionHistoryItem]()
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
    
    fileprivate func getFuelingDeviceItem(id: String) -> FuelingDevicesItem {
        for fuelingDevice in self.fuelingDevices {
            if fuelingDevice.strId == id {
                return fuelingDevice
            }
        }
        return FuelingDevicesItem()
    }
    
    fileprivate func allPurchases(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        cell.imgType.setImageWithStrURL(strURL: transactionHistoryItems[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = transactionHistoryItems[indexPath.row].store.strTitle
        cell.lblDate.text = transactionHistoryItems[indexPath.row].strDate
        cell.lblTime.text = transactionHistoryItems[indexPath.row].strTime
        cell.lblAmount.text = transactionHistoryItems[indexPath.row].amount.strValue
        
        if self.transactionHistoryItems[indexPath.row].intType == 2 {
            cell.btnDropDown.isHidden = true
            
        } else if self.transactionHistoryItems[indexPath.row].intType == 1 {
            cell.btnDropDown.isHidden = false
            
            let fuelingDeviceItem = self.getFuelingDeviceItem(id: self.transactionHistoryItems[indexPath.row].fuelingDeviceId)
            cell.imgFuelType.setImageWithStrURL(strURL: fuelingDeviceItem.fuelItem.strIcon, withAddUnderscoreIphone: false)
            cell.lblCarNumber.text = fuelingDeviceItem.strTitle
            cell.imgCar.setImageWithStrURL(strURL: fuelingDeviceItem.strIcon, withAddUnderscoreIphone: false)
            
            if self.transactionHistoryItems[indexPath.row].isExtended {
                
                UIView.animate(withDuration: 0.3) {
                    cell.btnDropDown.setImage(UIImage(named: "up"), for: .normal)
                    cell.historyBottomConstraint.constant = 198.5
                    cell.vwDropDown.isHidden = false
                    cell.vwHistory.removeShadow()
                    
                }
            } else {
                
                UIView.animate(withDuration: 0.3) {
                    cell.btnDropDown.setImage(UIImage(named: "down"), for: .normal)
                    cell.historyBottomConstraint.constant = 129
                    cell.vwDropDown.isHidden = true
                    cell.vwHistory.addShadow()
                }
            }
        }
        
        if self.transactionHistoryItems[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(transactionHistoryItems[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.transactionHistoryItems[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(transactionHistoryItems[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        return cell
    }
    
    fileprivate func refueling(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        cell.imgType.setImageWithStrURL(strURL: transactionHistoryItems[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = transactionHistoryItems[indexPath.row].store.strTitle
        cell.lblDate.text = transactionHistoryItems[indexPath.row].strDate
        cell.lblTime.text = transactionHistoryItems[indexPath.row].strTime
        cell.lblAmount.text = transactionHistoryItems[indexPath.row].amount.strValue
        
        cell.btnDropDown.isHidden = false
        
        let fuelingDeviceItem = self.getFuelingDeviceItem(id: self.transactionHistoryItems[indexPath.row].fuelingDeviceId)
        cell.imgFuelType.setImageWithStrURL(strURL: fuelingDeviceItem.fuelItem.strIcon, withAddUnderscoreIphone: false)
        cell.lblCarNumber.text = fuelingDeviceItem.strTitle
        cell.imgCar.setImageWithStrURL(strURL: fuelingDeviceItem.strIcon, withAddUnderscoreIphone: false)
        
        if self.transactionHistoryItems[indexPath.row].isExtended {
            
            UIView.animate(withDuration: 0.3) {
                cell.btnDropDown.setImage(UIImage(named: "up"), for: .normal)
                cell.historyBottomConstraint.constant = 198.5
                cell.vwDropDown.isHidden = false
                cell.vwHistory.removeShadow()
                
            }
        } else {
            
            UIView.animate(withDuration: 0.3) {
                cell.btnDropDown.setImage(UIImage(named: "down"), for: .normal)
                cell.historyBottomConstraint.constant = 129
                cell.vwDropDown.isHidden = true
                cell.vwHistory.addShadow()
            }
        }
        
        
        if self.transactionHistoryItems[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(transactionHistoryItems[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.transactionHistoryItems[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(transactionHistoryItems[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        return cell
    }
    
    fileprivate func stores(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        cell.btnDropDown.isHidden = true
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        cell.imgType.setImageWithStrURL(strURL: transactionHistoryItems[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = transactionHistoryItems[indexPath.row].store.strTitle
        cell.lblDate.text = transactionHistoryItems[indexPath.row].strDate
        cell.lblTime.text = transactionHistoryItems[indexPath.row].strTime
        cell.lblAmount.text = transactionHistoryItems[indexPath.row].amount.strValue
        
        if self.transactionHistoryItems[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(transactionHistoryItems[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.transactionHistoryItems[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(transactionHistoryItems[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        return cell
    }
    
    fileprivate func initializeBindings() {
        self.state.bind { [unowned self] (newVal) in
            switch self.state.value {
                
            case .allPurchases:
                self.initTabBar()
                self.viewModel.type = self.state.value.rawValue
                self.isWaitingForResponse = true
                self.viewModel.type = 0
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                
            case .refueling:                self.initTabBar()
            self.viewModel.type = self.state.value.rawValue
            self.isWaitingForResponse = true
            self.viewModel.type = 1
            self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                
            case .stores:
                self.initTabBar()
                self.viewModel.type = self.state.value.rawValue
                self.isWaitingForResponse = true
                self.viewModel.type = 2
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
            }
        }
    }
    
    @IBAction func didTapAll(_ sender: Any) {
        self.tableView.reloadData()
        self.state.value = .allPurchases
    }
    
    @IBAction func didTapRefueling(_ sender: Any) {
        self.tableView.reloadData()
        self.state.value = .refueling
    }
    
    @IBAction func didTapStores(_ sender: Any) {
        self.tableView.reloadData()
        self.state.value = .stores
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TransactionsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionHistoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.state.value {
            
        case .allPurchases: return self.allPurchases(tableView, cellForRowAt: indexPath)
            
        case .refueling: return self.refueling(tableView, cellForRowAt: indexPath)
            
        case .stores: return self.stores(tableView, cellForRowAt: indexPath)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StoresTableViewCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if self.transactionHistoryItems[indexPath.row].intType == 1 {
            self.transactionHistoryItems[indexPath.row].isExtended = !self.transactionHistoryItems[indexPath.row].isExtended
            
            self.view.layoutIfNeeded()
            self.tableView.reloadData()
        }
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
                self.transactionHistoryItems = [TransactionHistoryItem]()
                self.transactionHistoryItems.append(contentsOf: innerResponse.transactionHistoryList)
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
