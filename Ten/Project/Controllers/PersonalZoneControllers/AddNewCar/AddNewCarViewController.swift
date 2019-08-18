//
//  AddNewCarViewController.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class AddNewCarViewController: BaseFormViewController {
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: RegularLabel!
    @IBOutlet weak var lblCardNumber: RegularLabel!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var btnUse: TenButtonStyle!
    @IBOutlet weak var btnAddNew: TenButtonStyle!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var lblTableViewHederTitle: RegularLabel!
    @IBOutlet weak var contentView: UIView!
    
    var viewModel = AddNewCarViewModel()
    var isTableVisible = false
    var storePaymentMethodsTypeOne = [StorePaymentMethodsItem]()
    var window: UIWindow?
    var transparentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createStoreTypeOneArr()
        self.initUI()
        self.registerXibs()
    }
    
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as?TenStyleViewController {
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
    
    fileprivate func createStoreTypeOneArr() {
        for storeTypeOne in self.viewModel.user.storePaymentMethods {
            if storeTypeOne.intType == 1 {
                storePaymentMethodsTypeOne.append(storeTypeOne)
            }
        }
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.chooseCreditCard, Translations.Titles.chooseCreditCardDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.chooseCreditCard, Translations.SubTitles.chooseCreditCardDefault)
        self.btnUse.setTitle(Translation(Translations.AlertButtonsKeys.chooseCreditCardUse, Translations.AlertButtonsKeys.chooseCreditCardUseDefault), for: .normal)
        self.btnAddNew.setTitle(Translation(Translations.AlertButtonsKeys.chooseCreditCardNew, Translations.AlertButtonsKeys.chooseCreditCardNewDefault), for: .normal)
    }
    
    fileprivate func initUI() {
        self.contentView.addShadow()
        self.view.backgroundColor = .clear
        self.lblTableViewHederTitle.text = Translation(Translations.Titles.chooseCreditCardBottom, Translations.Titles.chooseCreditCardBottomDefault)
        self.tableDropDownHC.constant = 0
        self.lblCardNumber.text = self.storePaymentMethodsTypeOne[0].strShortTitle
        self.imgCreditCard.setImageWithStrURL(strURL: storePaymentMethodsTypeOne[0].strIcon, withAddUnderscoreIphone: false)
        self.btnAddNew.setWhiteBackground()
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: CreditCardExistsTableViewCell.className, bundle: nil), forCellReuseIdentifier: CreditCardExistsTableViewCell.className)
    }
    
    
    //IBAction:
    @IBAction func didTapAddNew(_ sender: Any) {
        self.viewModel.cardId = 0
        self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
    }
    
    @IBAction func didTapUse(_ sender: Any) {
        self.viewModel.cardId = self.storePaymentMethodsTypeOne[0].intId
        self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
    }
    
    @IBAction func didTapDropDwon(_ sender: Any) {
        
        if self.isTableVisible == false {
            
            self.openDropDown()
            
        } else {
            
            self.closeDropDown()
        }
    }
    
    @IBAction func didTapCloseDropDown(_ sender: Any) {
        self.closeDropDown()
    }
}

extension AddNewCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storePaymentMethodsTypeOne.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCardExistsTableViewCell.className, for: indexPath) as! CreditCardExistsTableViewCell
        
        cell.imgCreditCard.setImageWithStrURL(strURL: self.storePaymentMethodsTypeOne[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblCardNumber.text = self.storePaymentMethodsTypeOne[indexPath.row].strShortTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.imgCreditCard.setImageWithStrURL(strURL: self.storePaymentMethodsTypeOne[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        self.lblCardNumber.text =  self.storePaymentMethodsTypeOne[indexPath.row].strShortTitle
        self.viewModel.cardId =  self.storePaymentMethodsTypeOne[indexPath.row].intId
        
        self.closeDropDown()
        
    }
}

extension AddNewCarViewController {
    
    fileprivate func closeDropDown() {
        UIView.animate(withDuration: 0.3) {

            self.imgDropDown.image = UIImage(named: "down")
            self.tableDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func openDropDown() {
        
        let window = UIApplication.shared.keyWindow
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            if self.storePaymentMethodsTypeOne.count <= 3 {
                self.tableDropDownHC.constant = 70 + (70.0 * CGFloat(self.storePaymentMethodsTypeOne.count))
            } else {
                self.tableDropDownHC.constant = 70 + (70.0 * 3)
            }
            self.imgDropDown.image = UIImage(named: "up")
            self.isTableVisible = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func didTapTransparentView() {
        transparentView.alpha = 0
    }
}
