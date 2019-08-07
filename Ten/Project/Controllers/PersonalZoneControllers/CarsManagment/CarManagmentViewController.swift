//
//  CarManagmentViewController.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CarManagmentViewControoler: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case carManufacturer = 1
        case carModel = 2
        case carInspectionValidityDate = 3
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: MediumLabel!
    @IBOutlet weak var btnNewCar: TenButtonStyle!
    @IBOutlet var vwTitle: UIView!
    
    var viewModel = CarManagmentViewModel()
    var user = ApplicationManager.sharedInstance.userAccountManager.user
    var isShowPopup = false
    var fuelingDeviceItemInfo = [FuelingDevicesItem]()
    var selectedItem = -1
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXibs()
        self.initUI()
        self.showPopup()
        self.createToolBar()
        self.createDatePicker()
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
        self.vwTitle.addShadowAndCorner()
        self.view.backgroundColor = .clear
        self.btnNewCar.setWhiteBackground()
    }
    
    fileprivate func createToolBar() {
        self.toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker));
        self.toolbar.setItems([doneButton], animated: true)
    }
    
    fileprivate func createDatePicker() {
        datePicker.datePickerMode = .date
    }
    
    override func fillTextWithTrans() {
        self.btnNewCar.setTitle("\("+ ")\(Translation(Translations.AlertButtonsKeys.vehicleManagement, Translations.AlertButtonsKeys.vehicleManagementDefault))", for: .normal)
        self.lblTitle.text = Translation(Translations.Titles.vehicleManagement, Translations.Titles.vehicleManagementDefault)
    }
    
    //IBAction:
    @IBAction func didTapAddNewCar(_ sender: Any) {
        ApplicationManager.sharedInstance.userAccountManager.callStarsNewFuelingDeviceProcess(requestFinishedDelegate: nil)
    }
}


extension CarManagmentViewControoler: UITableViewDelegate, UITableViewDataSource {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
            
        case TxtFldTag.carManufacturer.rawValue:
            self.user.fuelingDevicesArr[selectedItem].objInfo.carManufacturer = textField.text ?? ""
        case TxtFldTag.carModel.rawValue:
            self.user.fuelingDevicesArr[selectedItem].objInfo.carModel = textField.text ?? ""
        case TxtFldTag.carInspectionValidityDate.rawValue:
            self.user.fuelingDevicesArr[selectedItem].objInfo.carInspectionValidityDate = textField.text ?? ""
            
        default:
            break;
        }
    }

    @objc func donePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: self.datePicker.date)
        user.fuelingDevicesArr[selectedItem].objInfo.carInspectionValidityDate = strDate
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.fuelingDevicesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarManagmentTableViewCell.className, for: indexPath) as! CarManagmentTableViewCell
        
        if user.fuelingDevicesArr.count == 1 {
            cell.btnDeleteCar.isHidden = true
        } else {
            cell.btnDeleteCar.isHidden = false
        }
        
        cell.txtFldDate.txtFldInput.inputView = self.datePicker
        cell.txtFldDate.txtFldInput.inputAccessoryView = self.toolbar
        
        cell.deleteCarDelegate = self
        cell.saveChangesDelegate = self
        
        cell.selectionStyle = .none
        
        cell.imgCar.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblCarNumber.text = user.fuelingDevicesArr[indexPath.row].strTitle
        cell.imgFuelType.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].fuelItem.strIcon, withAddUnderscoreIphone: false)
        cell.lblCreditCardNumber.text = user.fuelingDevicesArr[indexPath.row].payment.strTitle
        cell.imgCreditCard.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        
        cell.txtFldModel.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cell.txtFldManufacturer.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        if self.selectedItem == indexPath.row {
            
            UIView.animate(withDuration: 0.3) {
                cell.imgDropDown.image = UIImage(named: "up")
                cell.vwCarMenegmentCell.removeShadow()
                cell.contentViewHeightConstraint.constant = 260
                cell.dropDownView.isHidden = false
                cell.dropDownView.addShadow()
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                cell.imgDropDown.image = UIImage(named: "down")
                cell.dropDownView.removeShadow()
                cell.contentViewHeightConstraint.constant = 95
                cell.dropDownView.isHidden = true
                cell.vwCarMenegmentCell.addShadow()
                self.view.layoutIfNeeded()
            }
        }
        
        if !self.user.fuelingDevicesArr[indexPath.row].objInfo.carManufacturer.isEmpty {
            cell.txtFldManufacturer.txtFldInput.text =  self.user.fuelingDevicesArr[indexPath.row].objInfo.carManufacturer
        }
        
        if !self.user.fuelingDevicesArr[indexPath.row].objInfo.carModel.isEmpty {
            cell.txtFldModel.txtFldInput.text = self.user.fuelingDevicesArr[indexPath.row].objInfo.carModel
        }
        
        if !self.user.fuelingDevicesArr[indexPath.row].objInfo.carInspectionValidityDate.isEmpty {
            cell.txtFldDate.txtFldInput.text = self.user.fuelingDevicesArr[indexPath.row].objInfo.carInspectionValidityDate
        }
        
        mDCTextSetUp(mDCText: cell.txtFldManufacturer.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carManufacturer, Translations.Placeholders.carManufacturerDefault), withIndex: 1, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: "", addToolbar: true)
        
        
        mDCTextSetUp(mDCText: cell.txtFldModel.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carModel, Translations.Placeholders.carModelDefault), withIndex: 2, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: "", addToolbar: true)
        
        mDCTextSetUp(mDCText: cell.txtFldDate.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carTest, Translations.Placeholders.carTestDefault), withIndex: 3, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: "", addToolbar: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selectedItem == indexPath.row {
            self.selectedItem = -1
        } else {
            self.selectedItem = indexPath.row
        }
        
        self.view.layoutIfNeeded()
        self.tableView.reloadData()
        
    }
}

extension CarManagmentViewControoler: DeleteCarDelegate {
    
    func didTapRemoveCar() {
        
        self.moveToDeletePopup()
    }
    
    func moveToDeletePopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .exit
        popupInfoObj.strTitle = Translation(Translations.Titles.popupRemoveFuelingCard, Translations.Titles.popupRemoveFuelingCardDefault)
        popupInfoObj.strSkipButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardNo, Translations.AlertButtonsKeys.popupRemoveFuelingCardNoDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardYes, Translations.AlertButtonsKeys.popupRemoveFuelingCardYesDefault)
        popupInfoObj.firstButtonAction = {
            let dict = [TenParamsNames.id: self.user.fuelingDevicesArr[self.selectedItem].strId]
            ApplicationManager.sharedInstance.userAccountManager.callRemoveFuelingDevice(dictParams: dict, requestFinishedDelegate: self)
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}

extension CarManagmentViewControoler: SaveChangesDelegate {
    
    func didTapSaveChanges() {
        
        let dict = [TenParamsNames.id: self.user.fuelingDevicesArr[selectedItem].strId,
                    TenParamsNames.carManufacturer: self.user.fuelingDevicesArr[selectedItem].objInfo.carManufacturer,
                    TenParamsNames.carModel: self.user.fuelingDevicesArr[selectedItem].objInfo.carModel,
                    TenParamsNames.carInspectionValidityDate: self.user.fuelingDevicesArr[selectedItem].objInfo.carInspectionValidityDate]
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateFuelingDevice(dictParams: dict, requestFinishedDelegate: self)
    }
}

extension CarManagmentViewControoler {
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getRemoveFuelingDevice {
            self.tableView.reloadData()
        }
        if request.requestName == TenRequestNames.getUpdateFuelingDevice {
            self.selectedItem = -1
            self.tableView.reloadData()
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}

