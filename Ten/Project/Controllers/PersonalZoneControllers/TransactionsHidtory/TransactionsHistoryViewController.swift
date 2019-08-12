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
    
    
    
    var allPurchasesItems = [TransactionHistoryItem]()
    var refuelingItems = [TransactionHistoryItem]()
    var storesItems = [TransactionHistoryItem]()
    
    
    
    var allTransactionHistoryResponse: GetTransactionsHistoryResponse?
    var refuelingHistoryResponse: GetTransactionsHistoryResponse?
    var storesHistoryResponse: GetTransactionsHistoryResponse?
    
    
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
    
    fileprivate func initializeBindings() {
        self.state.bind { [unowned self] (newVal) in
            switch self.state.value {
                
            case .allPurchases:
                self.initTabBar()
                self.viewModel.type = self.state.value.rawValue
                self.isWaitingForResponse = true
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                
            case .refueling:
                self.initTabBar()
                self.isWaitingForResponse = true
                self.viewModel.type = self.state.value.rawValue
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                
                
            case .stores:
                self.initTabBar()
                self.viewModel.type = self.state.value.rawValue
                self.isWaitingForResponse = true
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
            }
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
        
        cell.imgType.setImageWithStrURL(strURL: allPurchasesItems[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = allPurchasesItems[indexPath.row].store.strTitle
        cell.lblDate.text = allPurchasesItems[indexPath.row].strDate
        cell.lblTime.text = allPurchasesItems[indexPath.row].strTime
        cell.lblAmount.text = allPurchasesItems[indexPath.row].amount.strValue
        
        if self.allPurchasesItems[indexPath.row].intType == 2 {
            cell.btnDropDown.isHidden = true
            
        } else if self.allPurchasesItems[indexPath.row].intType == 1 {
            cell.btnDropDown.isHidden = false
            
            let fuelingDeviceItem = self.getFuelingDeviceItem(id: self.allPurchasesItems[indexPath.row].fuelingDeviceId)
            cell.imgFuelType.setImageWithStrURL(strURL: fuelingDeviceItem.fuelItem.strIcon, withAddUnderscoreIphone: false)
            cell.lblCarNumber.text = fuelingDeviceItem.strTitle
            cell.imgCar.setImageWithStrURL(strURL: fuelingDeviceItem.strIcon, withAddUnderscoreIphone: false)
            
            if self.allPurchasesItems[indexPath.row].isExtended {
                
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
        
        if self.allPurchasesItems[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(allPurchasesItems[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.allPurchasesItems[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(allPurchasesItems[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        return cell
    }
    
    fileprivate func refueling(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        cell.btnDropDown.isHidden = false
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        cell.imgType.setImageWithStrURL(strURL: refuelingItems[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = refuelingItems[indexPath.row].store.strTitle
        cell.lblDate.text = refuelingItems[indexPath.row].strDate
        cell.lblTime.text = refuelingItems[indexPath.row].strTime
        cell.lblAmount.text = refuelingItems[indexPath.row].amount.strValue
        
        
        let fuelingDeviceItem = self.getFuelingDeviceItem(id: self.refuelingItems[indexPath.row].fuelingDeviceId)
        cell.imgFuelType.setImageWithStrURL(strURL: fuelingDeviceItem.fuelItem.strIcon, withAddUnderscoreIphone: false)
        cell.lblCarNumber.text = fuelingDeviceItem.strTitle
        cell.imgCar.setImageWithStrURL(strURL: fuelingDeviceItem.strIcon, withAddUnderscoreIphone: false)
        
        if self.refuelingItems[indexPath.row].isExtended {
            
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
        
        
        if self.refuelingItems[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(refuelingItems[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.refuelingItems[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(refuelingItems[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        return cell
    }
    
    fileprivate func stores(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        cell.btnDropDown.isHidden = true
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        cell.imgType.setImageWithStrURL(strURL: storesItems[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = storesItems[indexPath.row].store.strTitle
        cell.lblDate.text = storesItems[indexPath.row].strDate
        cell.lblTime.text = storesItems[indexPath.row].strTime
        cell.lblAmount.text = storesItems[indexPath.row].amount.strValue
        
        if self.storesItems[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(storesItems[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if self.storesItems[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(storesItems[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        return cell
        
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TransactionsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.state.value {
        case .allPurchases:
            return allPurchasesItems.count
            
        case .refueling:
            return refuelingItems.count
            
        case .stores:
            return storesItems.count
        }
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
        
        
        switch self.state.value {
            
        case .allPurchases:
            if self.allPurchasesItems[indexPath.row].intType == 1 {
                self.allPurchasesItems[indexPath.row].isExtended = !self.allPurchasesItems[indexPath.row].isExtended
                self.view.layoutIfNeeded()
                self.tableView.reloadData()
            }
            
        case .refueling:
            if self.refuelingItems[indexPath.row].intType == 1 {
                self.refuelingItems[indexPath.row].isExtended = !self.refuelingItems[indexPath.row].isExtended
                self.view.layoutIfNeeded()
                self.tableView.reloadData()
            }
            
        case .stores:
            self.view.layoutIfNeeded()
            self.tableView.reloadData()
        }
        
    }
    
    //MARK - LazyLoad:
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
              switch self.state.value {
              case .allPurchases:
                if allTransactionHistoryResponse?.hasNextPage == true && !self.isWaitingForResponse {
                    isWaitingForResponse = true
                    self.viewModel.currentPage += 1
                    self.viewModel.type = self.state.value.rawValue
                    self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                }
                
              case .refueling:
                if refuelingHistoryResponse?.hasNextPage == true && !self.isWaitingForResponse {
                    isWaitingForResponse = true
                    self.viewModel.currentPage += 1
                    self.viewModel.type = self.state.value.rawValue
                    self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)

                }
                
              case .stores:
                if storesHistoryResponse?.hasNextPage == true && !self.isWaitingForResponse {
                    isWaitingForResponse = true
                    self.viewModel.currentPage += 1
                    self.viewModel.type = self.state.value.rawValue
                    self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                 

                }
            }
        }
    }
}

extension TransactionsHistoryViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getTransactionsHistory {
            
            if let innerResponse = innerResponse as? GetTransactionsHistoryResponse {
                
                switch self.state.value {
                case .allPurchases:
                    
                    self.allPurchasesItems.append(contentsOf: innerResponse.transactionHistoryList)
                    self.allTransactionHistoryResponse = innerResponse
                    self.tableView.reloadData()
                    
                case .refueling:
                    
                    self.refuelingItems.append(contentsOf: innerResponse.transactionHistoryList)
                    self.refuelingHistoryResponse = innerResponse
                    self.tableView.reloadData()
                    
                case .stores:
                    
                    self.storesItems.append(contentsOf: innerResponse.transactionHistoryList)
                    self.storesHistoryResponse = innerResponse
                    self.tableView.reloadData()
                    
                }
                isWaitingForResponse = false
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}

extension TransactionsHistoryViewController {
    private func initTabBar() {
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
    
    private func initTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.view.backgroundColor = .clear
    }
}
