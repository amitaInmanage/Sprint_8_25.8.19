//
//  PersonalZoneViewController.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalZoneViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var lblLogOut: RegularText!
    
    var personelItem = ApplicationManager.sharedInstance.userAccountManager.user.personelAreaMenuArr
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var viewModel = PersonalZoneViewModel()
    var rowTypeArr: [RowType] = []
    
    enum RowType {
        case personalItems
        case accumulation
        case saving
        case powerCard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filRowTypeArr()
        self.registerXibs()
        self.initTableView()
        self.initUI()
    }
    
    override func fillTextWithTrans() {
        self.lblLogOut.text = Translation(Translations.AlertButtonsKeys.logout, Translations.AlertButtonsKeys.logoutDefault)
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = UIColor.clear
        self.logOutBtn.setBackgroundColor(color: UIColor(red: 216, green: 215, blue: 216, alpha: 0), forState: .normal)
    }
    
    fileprivate func initTableView() {
        self.tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.backgroundColor = .clear
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        self.fullScreeen(parent: parent)
    }
    
    
    fileprivate func filRowTypeArr() -> Void{
        
        if user.personelAreaMenuArr.count > 1 {
            
            self.rowTypeArr.append(RowType.personalItems)
        }
        if user.hasAccumulation() {
            
            self.rowTypeArr.append(RowType.accumulation)
            
        }
        if user.isClubMamber {
            
            self.rowTypeArr.append(RowType.saving)
        }
        if user.powerCardArr.isHasCard {
            
            self.rowTypeArr.append(RowType.powerCard)
        }
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: PersonalDetailsTableViewCell.className, bundle: nil), forCellReuseIdentifier: PersonalDetailsTableViewCell.className)
        self.tableView.register(UINib(nibName: MySavingsTableViewCell.className, bundle: nil), forCellReuseIdentifier: MySavingsTableViewCell.className)
        self.tableView.register(UINib(nibName: MyAccumulationTableViewCell.className, bundle: nil), forCellReuseIdentifier: MyAccumulationTableViewCell.className)
        self.tableView.register(UINib(nibName: PowerCardTableViewCell.className, bundle: nil), forCellReuseIdentifier: PowerCardTableViewCell.className)
    }
    
    fileprivate func personalItems(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDetailsTableViewCell.className, for: indexPath) as! PersonalDetailsTableViewCell
        cell.setUpData(didTapItem: self)
        return cell
    }
    
    fileprivate func accumulation(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyAccumulationTableViewCell.className, for: indexPath) as! MyAccumulationTableViewCell
        return cell
    }
    
    fileprivate func saving(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MySavingsTableViewCell.className, for: indexPath) as! MySavingsTableViewCell
        return cell
    }
    
    fileprivate func powerCard(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PowerCardTableViewCell.className, for: indexPath) as! PowerCardTableViewCell
        
        
        return cell
    }
    
    
    //IBAction:
    @IBAction func didTapBtnLogOut(_ sender: Any) {
        self.viewModel.moveToExitPopup()
    }
}

extension PersonalZoneViewController: UITableViewDelegate, UITableViewDataSource, DidTapItem {
    
    func didTapItem(menuItem: PersonalAreaMenuItem) {
        let personalItemObj = menuItem
        if !ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(strFullDeeplink: personalItemObj.strDeepLink, dataObject: nil, animated: true, completionHandler: nil) {
            ApplicationManager.sharedInstance.openURLManager.openSFSafari(strLink: personalItemObj.strDeepLink)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.rowTypeArr[indexPath.row] {
        case .personalItems: return self.personalItems(tableView, cellForRowAt: indexPath)
        case .accumulation: return self.accumulation(tableView, cellForRowAt: indexPath)
        case .saving: return self.saving(tableView, cellForRowAt: indexPath)
        case .powerCard: return self.powerCard(tableView, cellForRowAt: indexPath)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
