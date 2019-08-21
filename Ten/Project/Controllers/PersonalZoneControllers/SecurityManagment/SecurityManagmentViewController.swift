//
//  SecurityManagmentViewController.swift
//  Ten
//
//  Created by Amit on 21/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit
import LocalAuthentication

class SecurityManagmentViewController: BaseFormViewController {
    
    enum BiometricType {
        case none
        case touch
        case face
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTtile: MediumText!
    @IBOutlet weak var lblSubTitle: RegularText!
    
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var rowTypeArr: [RowType] = []
    
    enum RowType {
        case createPassword
        case changePassword
        case touchId
        case faceId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filRowTypeArr()
        self.registerXibs()
        self.initTableView()
        self.initUI()
        
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
       self.fullScreeen(parent: parent)
    }
    
     func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }
    
    override func fillTextWithTrans() {
        self.lblTtile.text = Translation(Translations.AlertButtonsKeys.securityMenagement, Translations.AlertButtonsKeys.securityMenagementDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.securityManagment, Translations.SubTitles.securityManagmentDefault)
    }
    
    fileprivate func initUI() {
       !user.hasPinCode ? (self.lblSubTitle.isHidden = false) : (self.lblSubTitle.isHidden = true)
        
    }
    
    fileprivate func filRowTypeArr() -> Void {
        
        let device = self.biometricType()
        
        if device == BiometricType.touch && user.hasPinCode {
            self.rowTypeArr.append(RowType.changePassword)
            self.rowTypeArr.append(RowType.touchId)
            
        } else if device == BiometricType.face && user.hasPinCode {
            self.rowTypeArr.append(RowType.changePassword)
            self.rowTypeArr.append(RowType.faceId)
       
        } else if device == BiometricType.none && user.hasPinCode {
                self.rowTypeArr.append(RowType.changePassword)
    
        } else {
            
            self.rowTypeArr.append(RowType.createPassword)
        }
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: CreatePasswordTableViewCell.className, bundle: nil), forCellReuseIdentifier: CreatePasswordTableViewCell.className)
        self.tableView.register(UINib(nibName: PasswordManagmenTableViewCell.className, bundle: nil), forCellReuseIdentifier: PasswordManagmenTableViewCell.className)
        self.tableView.register(UINib(nibName: FaceIdTableViewCell.className, bundle: nil), forCellReuseIdentifier: FaceIdTableViewCell.className)
        self.tableView.register(UINib(nibName: TouchIdableViewCell.className, bundle: nil), forCellReuseIdentifier: TouchIdableViewCell.className)
    }
    
    fileprivate func createPassword(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreatePasswordTableViewCell.className, for: indexPath) as! CreatePasswordTableViewCell
        return cell
    }
    
    fileprivate func changePassword(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PasswordManagmenTableViewCell.className, for: indexPath) as! PasswordManagmenTableViewCell
        return cell
    }
    
    fileprivate func faceId(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FaceIdTableViewCell.className, for: indexPath) as! FaceIdTableViewCell
        return cell
    }
    
    fileprivate func tuchId(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TouchIdableViewCell.className, for: indexPath) as! TouchIdableViewCell
        return cell
    }
    
    fileprivate func initTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.allowsSelection = false
        self.view.backgroundColor = .clear
    }
}

extension SecurityManagmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.rowTypeArr[indexPath.row] {
        case .createPassword: return self.createPassword(tableView, cellForRowAt: indexPath)
        case .changePassword: return self.changePassword(tableView, cellForRowAt: indexPath)
        case .touchId: return self.tuchId(tableView, cellForRowAt: indexPath)
        case .faceId: return self.faceId(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
