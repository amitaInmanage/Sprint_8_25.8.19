//
//  ChooseCustomerTypeViewController.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpChooseCustomerTypeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var btnConfrime: TenButtonStyle!
    
    var viewModel = ChooseCustomerTypeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initinlizeUI()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
            vc.bottomConstraint.constant = 17.5
        }
    }
    
    func initinlizeUI() {
        self.btnConfrime.Disabled()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.customerTypeTitle, Translations.Titles.customerTypeTitleDefault)
        self.btnConfrime.setTitle(Translation(Translations.AlertButtonsKeys.btnConfirm, Translations.AlertButtonsKeys.btnConfirmDefault), for: .normal)
    }
    
    //MARK: IBAction:
    @IBAction func didTapContinueBtn(_ sender: Any) {
        if ApplicationManager.sharedInstance.userAccountManager.registrationToken.isEmpty {
           self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
        } else {
            self.viewModel.buildJsonAndSendUpdateRegistrationData(strScreenName: self.viewModel.screenName)
        }
    }
}

extension SignUpChooseCustomerTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignUpChooseCustomerTypeCell.className, for: indexPath) as! SignUpChooseCustomerTypeCell
        
        cell.imgCustomerType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOff, withAddUnderscoreIphone: false)
        
        cell.lblTitle.text = self.viewModel.data[indexPath.item].strTitle
        cell.lblSubTitle.text = self.viewModel.data[indexPath.item].strSubTitle
        
        if indexPath.item == self.viewModel.selectedIndexPath {
            cell.addShadowAndCorner()
            cell.imgCustomerType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOn, withAddUnderscoreIphone: false)
        } else {
            cell.removeShadow()
            cell.imgCustomerType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOff, withAddUnderscoreIphone: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.btnConfrime.Enabled()
        self.viewModel.selectedIndexPath = indexPath.item
        let code = self.viewModel.data[indexPath.item].intId
        self.viewModel.intType = code
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
}

