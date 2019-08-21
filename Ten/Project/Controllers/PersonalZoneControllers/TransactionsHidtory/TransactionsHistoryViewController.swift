//
//  TransactionsHistoryViewController.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

enum TabState: Int {
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
    var state = Box<TabState>(TabState.allPurchases)
    var fuelingDevices = ApplicationManager.sharedInstance.userAccountManager.user.fuelingDevicesArr
    
    var transectionHistoryDict = [TabState: GetTransactionsHistoryResponse?]()
    
    var isWaitingForResponse = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var lblAll: RegularText!
    @IBOutlet weak var lblDeluqs: RegularText!
    @IBOutlet weak var lblStores: RegularText!
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
    
    fileprivate func getActiveTransactionHistoryResponse() -> GetTransactionsHistoryResponse? {
        return transectionHistoryDict[self.state.value] ?? nil
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
       self.fullScreeen(parent: parent)
    }
    
    fileprivate func initializeBindings() {
        self.state.bind { [unowned self] (newVal) in
            
            let activeState = self.getActiveTransactionHistoryResponse()?.transactionHistoryList
            
            if activeState != nil {
                self.initTabBar()
                self.tableView.reloadData()

            } else {
                self.initTabBar()
                self.isWaitingForResponse = true
                self.viewModel.type = self.state.value.rawValue
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                self.tableView.reloadData()
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
        
        cell.selectionStyle = .none
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        guard let activeTransactionHistory = self.getActiveTransactionHistoryResponse()?.transactionHistoryList else { return UITableViewCell()}
        
        cell.imgType.setImageWithStrURL(strURL: activeTransactionHistory[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = activeTransactionHistory[indexPath.row].store.strTitle
        cell.lblDate.text = activeTransactionHistory[indexPath.row].strDate
        cell.lblTime.text = activeTransactionHistory[indexPath.row].strTime
        cell.lblAmount.text = activeTransactionHistory[indexPath.row].amount.strValue
        
        if activeTransactionHistory[indexPath.row].intType == 2 {
            
            cell.btnDropDown.isHidden = true
            
        } else if activeTransactionHistory[indexPath.row].intType == 1 {
            cell.btnDropDown.isHidden = false
            
            let fuelingDeviceItem = self.getFuelingDeviceItem(id: activeTransactionHistory[indexPath.row].fuelingDeviceId)
            cell.imgFuelType.setImageWithStrURL(strURL: fuelingDeviceItem.fuelItem.strIcon, withAddUnderscoreIphone: false)
            cell.lblCarNumber.text = fuelingDeviceItem.strTitle
            cell.imgCar.setImageWithStrURL(strURL: fuelingDeviceItem.strIcon, withAddUnderscoreIphone: false)
            
            if activeTransactionHistory[indexPath.row].isExtended {
                
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
        
        if activeTransactionHistory[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(activeTransactionHistory[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if activeTransactionHistory[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(activeTransactionHistory[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        return cell
    }
    
    fileprivate func refueling(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        cell.selectionStyle = .none
        cell.btnDropDown.isHidden = false
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        
        guard let activeTransactionHistory = self.getActiveTransactionHistoryResponse()?.transactionHistoryList else { return UITableViewCell() }
        
        cell.imgType.setImageWithStrURL(strURL: activeTransactionHistory[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = activeTransactionHistory[indexPath.row].store.strTitle
        cell.lblDate.text = activeTransactionHistory[indexPath.row].strDate
        cell.lblTime.text = activeTransactionHistory[indexPath.row].strTime
        cell.lblAmount.text = activeTransactionHistory[indexPath.row].amount.strValue
        
        let fuelingDeviceItem = self.getFuelingDeviceItem(id: activeTransactionHistory[indexPath.row].fuelingDeviceId)
        cell.imgFuelType.setImageWithStrURL(strURL: fuelingDeviceItem.fuelItem.strIcon, withAddUnderscoreIphone: false)
        cell.lblCarNumber.text = fuelingDeviceItem.strTitle
        cell.imgCar.setImageWithStrURL(strURL: fuelingDeviceItem.strIcon, withAddUnderscoreIphone: false)
        
        if activeTransactionHistory[indexPath.row].isExtended {
            
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
    
        if activeTransactionHistory[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(activeTransactionHistory[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if activeTransactionHistory[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(activeTransactionHistory[indexPath.row].usageAmount.intValue)
            cell.stackViewUsage.isHidden = false
        }
        
        return cell
    }
    
    fileprivate func stores(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.className, for: indexPath) as! StoresTableViewCell
        
        guard let activeTransactionHistory = self.getActiveTransactionHistoryResponse()?.transactionHistoryList else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.btnDropDown.isHidden = true
        cell.stackViewUsage.isHidden = true
        cell.stackViewAccunulation.isHidden = true
        cell.imgType.setImageWithStrURL(strURL: activeTransactionHistory[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblTitle.text = activeTransactionHistory[indexPath.row].store.strTitle
        cell.lblDate.text = activeTransactionHistory[indexPath.row].strDate
        cell.lblTime.text = activeTransactionHistory[indexPath.row].strTime
        cell.lblAmount.text = activeTransactionHistory[indexPath.row].amount.strValue
        
        if activeTransactionHistory[indexPath.row].accumulationAmount.intDisplay == 1 {
            cell.lblAccumulationAmount.text = String(activeTransactionHistory[indexPath.row].accumulationAmount.intValue)
            cell.stackViewAccunulation.isHidden = false
        }
        
        if activeTransactionHistory[indexPath.row].usageAmount.intDisplay == 1 {
            cell.lblUsageAmount.text = String(activeTransactionHistory[indexPath.row].usageAmount.intValue)
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
        
        guard let activeTransactionHistory = self.getActiveTransactionHistoryResponse()?.transactionHistoryList else { return 0}
        
        return activeTransactionHistory.count
        
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
        
        guard let activeTransactionHistory = self.getActiveTransactionHistoryResponse()?.transactionHistoryList else { return }
        
        if activeTransactionHistory[indexPath.row].intType == 1 {
            activeTransactionHistory[indexPath.row].isExtended = !activeTransactionHistory[indexPath.row].isExtended
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
            
            guard let activeTransactionHistory = self.getActiveTransactionHistoryResponse() else { return }
            
            if activeTransactionHistory != nil && activeTransactionHistory.hasNextPage && !self.isWaitingForResponse {
                isWaitingForResponse = true
                self.viewModel.currentPage += 1
                self.viewModel.type = self.state.value.rawValue
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
            }
        }
    }
}

extension TransactionsHistoryViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getTransactionsHistory {
            
            if let innerResponse = innerResponse as? GetTransactionsHistoryResponse {
                
                var activeTransactionHistory = innerResponse
                
                if let _ = self.getActiveTransactionHistoryResponse() {
                    
                    activeTransactionHistory = self.getActiveTransactionHistoryResponse()!
                    var currentTransectionHistory = activeTransactionHistory.transactionHistoryList
                    let newTransectionHistory = innerResponse.transactionHistoryList
                    
                    currentTransectionHistory += newTransectionHistory
                    innerResponse.transactionHistoryList = currentTransectionHistory
                    activeTransactionHistory = innerResponse
                }
                
                self.transectionHistoryDict[self.state.value] = activeTransactionHistory
                self.tableView.reloadData()
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
