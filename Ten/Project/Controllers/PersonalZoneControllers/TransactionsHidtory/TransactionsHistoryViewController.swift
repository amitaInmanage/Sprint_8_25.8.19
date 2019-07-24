//
//  TransactionsHistoryViewController.swift
//  Ten
//
//  Created by Amit on 24/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

enum RowType {
    case stores
}

enum States: Int {
    case all = 0
    case refueling = 1
    case stores = 2
}

enum PagerFontState: String {
    case regular = "OpenSansHebrew-Regular"
}

class TransactionsHistoryViewController : BaseFormViewController {
    
    var user = TenUser()
    var viewModel = TransactionsHistoryViewModel()
    var state = Box<States>(States.all)
    var rowTypeArr: [RowType] = []
    var all: [TransactionHistoryItem] = []
    var allTransactionHistoryResponse: GetTransactionsHistoryResponse?
    
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
        return cell
    }
    
    fileprivate func initializeBindings() {
        self.state.bind { [unowned self] (newVal) in
            switch self.state.value {
                
            case .all: self.initUI()
            if self.allTransactionHistoryResponse == nil {
                self.viewModel.type = self.state.value.rawValue
                self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
            }
                break
                
            case .refueling: self.initUI()
//            self.viewModel.type = self.state.value.rawValue
//            self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                break
                
            case .stores: self.initUI()
//            self.viewModel.type = self.state.value.rawValue
//            self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                break
            }
        }
    }
    
    @IBAction func didTapAll(_ sender: Any) {
        self.state.value = .all
    }
    
    @IBAction func didTapDeluqs(_ sender: Any) {
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
        case .all:
             return self.stores(tableView, cellForRowAt: indexPath)
             
            break
        case .refueling:
          return UITableViewCell()
         break
        case .stores:
              return self.stores(tableView, cellForRowAt: indexPath)
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                if allTransactionHistoryResponse?.hasNextPage == true {
                    self.viewModel.buildJsonAndSendGetTransactionsHistory(vc: self)
                    self.viewModel.page += 1
                }
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
                self.initTableView()
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {

    }
}


extension TransactionsHistoryViewController {
    func initTabBar() {
        switch self.state.value {
        case .all:
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
        self.tableView.allowsSelection = false
        self.view.backgroundColor = .clear
        self.tableView.reloadData()
    }
}
