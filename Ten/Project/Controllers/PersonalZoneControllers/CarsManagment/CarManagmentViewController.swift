//
//  CarManagmentViewController.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CarManagmentViewControoler: BaseFormViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: MediumLabel!
    @IBOutlet weak var btnNewCar: TenButtonStyle!
    
    var viewModel = CarManagmentViewModel()
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var isShowPopup = false
    var fieldsArr = [String: Any]()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXibs()
        self.initUI()
        self.showPopup()
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
    
    fileprivate func registerXibs()  {
        self.tableView.register(UINib(nibName: CarManagmentTableViewCell.className, bundle: nil), forCellReuseIdentifier: CarManagmentTableViewCell.className)
    }
    
    fileprivate func showPopup() {
        if isShowPopup {
            self.viewModel.moveToTenGanrelPopup()
        }
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = .clear
        self.btnNewCar.setWhiteBackground()
    }
    
    override func fillTextWithTrans() {
        self.btnNewCar.setTitle(Translation(Translations.AlertButtonsKeys.vehicleManagement, Translations.AlertButtonsKeys.vehicleManagementDefault), for: .normal)
            self.lblTitle.text = Translation(Translations.Titles.vehicleManagement, Translations.Titles.vehicleManagementDefault)
    }
    
    //IBAction:
    @IBAction func didTapAddNewCar(_ sender: Any) {
        ApplicationManager.sharedInstance.userAccountManager.callStarsNewFuelingDeviceProcess(requestFinishedDelegate: nil)
    }
}


extension CarManagmentViewControoler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.fuelingDevicesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarManagmentTableViewCell.className, for: indexPath) as! CarManagmentTableViewCell
        
        cell.deleteCarDelegate = self
        cell.saveChangesDelegate = self
        
            cell.imgCar.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].strIcon, withAddUnderscoreIphone: false)
            cell.lblCarNumber.text = user.fuelingDevicesArr[indexPath.row].strTitle
            cell.imgFuelType.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].fuelItem.strIcon, withAddUnderscoreIphone: false)
            cell.lblCreditCardNumber.text = user.fuelingDevicesArr[indexPath.row].payment.strTitle
            cell.imgCreditCard.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        
        mDCTextSetUp(mDCText: cell.txtFldManufacturer.txtFldInput, withPlaceholderText: "יצרן", withIndex: 1, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: " ", addToolbar: true)
       
        
        mDCTextSetUp(mDCText: cell.txtFldModel.txtFldInput, withPlaceholderText: "דגם", withIndex: 2, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: " ", addToolbar: true)
        
        
        mDCTextSetUp(mDCText: cell.txtFldDate.txtFldInput, withPlaceholderText: "תוקף טסט", withIndex: 3, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: " ", addToolbar: true)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.id = user.fuelingDevicesArr[indexPath.row].numID
    }
}

extension CarManagmentViewControoler: DeleteCarDelegate {
    func didTapRemoveCar() {
        
        let dict = [TenParamsNames.id: self.id] as [String:Any]
        
        ApplicationManager.sharedInstance.userAccountManager.callRemoveFuelingDevice(dictParams: dict, requestFinishedDelegate: self)
    }
}

extension CarManagmentViewControoler: SaveChangesDelegate {
    func didTapSaveChanges() {
        
    }
}
