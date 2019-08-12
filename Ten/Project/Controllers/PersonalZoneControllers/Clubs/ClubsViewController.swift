//
//  ClubsViewController.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class ClubsViewController: BaseFormViewController {
    
    var viewModel = ClubsViewModel()
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var rowTypeArr: [RowType] = []
    
    enum RowType {
        case tenClub
        case poweCardClub
    }
    
    @IBOutlet weak var lblTitle: MediumLabel!
    @IBOutlet weak var vwTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.initUI()
        self.registerXibs()
        self.initTableView()
        self.filRowTypeArr()
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
    
    fileprivate func tenClubs(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TenClubsTableViewCell.className, for: indexPath) as! TenClubsTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    fileprivate func powerCard(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PowerCardClubTableViewCell.className, for: indexPath) as! PowerCardClubTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: TenClubsTableViewCell.className, bundle: nil), forCellReuseIdentifier: TenClubsTableViewCell.className)
        self.tableView.register(UINib(nibName: PowerCardClubTableViewCell.className, bundle: nil), forCellReuseIdentifier: PowerCardClubTableViewCell.className)
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.clubs, Translations.Titles.clubsDefault)
    }
    
    private func initUI() {
        self.vwTitle.addShadowAndCorner()
        self.view.backgroundColor = .clear
    }
    
    fileprivate func initTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.view.backgroundColor = .clear
    }
    
    fileprivate func filRowTypeArr() -> Void {
    
        self.rowTypeArr.append(RowType.tenClub)
        self.rowTypeArr.append(RowType.poweCardClub)
    }
}


extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.rowTypeArr[indexPath.row] {
        case .tenClub: return self.tenClubs(tableView, cellForRowAt: indexPath)
        case .poweCardClub: return self.powerCard(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.rowTypeArr[indexPath.row] {
        case .tenClub:
            break
        case .poweCardClub:
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: PowerCardViewController.className) as? PowerCardViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
            }
        }
    }
}
