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
    
    var viewModel = AddNewCarViewModel()
    var isTableVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.registerXibs()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.chooseCreditCard, Translations.Titles.chooseCreditCardDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.chooseCreditCard, Translations.SubTitles.chooseCreditCardDefault)
        self.btnUse.setTitle(Translation(Translations.AlertButtonsKeys.chooseCreditCardUse, Translations.AlertButtonsKeys.chooseCreditCardUseDefault), for: .normal)
        self.btnAddNew.setTitle(Translation(Translations.AlertButtonsKeys.chooseCreditCardNew, Translations.AlertButtonsKeys.chooseCreditCardNewDefault), for: .normal)
    }
    
    fileprivate func initUI() {
        self.lblTableViewHederTitle.text = Translation(Translations.Titles.chooseCreditCardBottom, Translations.Titles.chooseCreditCardBottomDefault)
        self.tableDropDownHC.constant = 0
        self.lblCardNumber.text = self.viewModel.user.fuelingDevicesArr[0].payment.strTitle
        self.imgCreditCard.setImageWithStrURL(strURL: self.viewModel.user.fuelingDevicesArr[0].payment.strIcon, withAddUnderscoreIphone: false)
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
        self.viewModel.cardId = self.viewModel.user.fuelingDevicesArr[0].payment.intId
        self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
    }
    
    @IBAction func didTapDropDwon(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            if self.isTableVisible == false {
                self.tableDropDownHC.constant = 70 + (70.0 * CGFloat(self.viewModel.user.fuelingDevicesArr.count))
                self.imgDropDown.image = UIImage(named: "up")
                self.isTableVisible = true
            } else {
                self.imgDropDown.image = UIImage(named: "down")
                self.tableDropDownHC.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension AddNewCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.viewModel.user.fuelingDevicesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCardExistsTableViewCell.className, for: indexPath) as! CreditCardExistsTableViewCell
        cell.imgCreditCard.setImageWithStrURL(strURL: self.viewModel.user.fuelingDevicesArr[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        cell.lblCardNumber.text = self.viewModel.user.fuelingDevicesArr[indexPath.row].payment.strTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.imgCreditCard.setImageWithStrURL(strURL: self.viewModel.user.fuelingDevicesArr[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        self.lblCardNumber.text = self.viewModel.user.fuelingDevicesArr[indexPath.row].payment.strTitle
        self.viewModel.cardId = self.viewModel.user.fuelingDevicesArr[indexPath.row].payment.intId
        
        UIView.animate(withDuration: 0.3) {
            self.imgDropDown.image = UIImage(named: "down")
            self.tableDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
    }
}
