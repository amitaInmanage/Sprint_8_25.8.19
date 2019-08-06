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
    var fieldsArr = [String: Any]()
    var id = ""
    var carManufacturer = ""
    var carModel = ""
    var carInspectionValidityDate = ""
    var datePicker: UIDatePicker?
    var open = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXibs()
        self.initUI()
        self.showPopup()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        datePicker?.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
 
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
            self.carManufacturer = textField.text ?? ""
        case TxtFldTag.carModel.rawValue:
            self.carModel = textField.text ?? ""
        case TxtFldTag.carInspectionValidityDate.rawValue:
            self.carInspectionValidityDate = textField.text ?? ""
            
        default:
            break;
        }
    }
    

    @objc func dateChanged(_ datePicker: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        for fuelingDevices in user.fuelingDevicesArr {
            if self.id == fuelingDevices.strId {
                fuelingDevices.objInfo.carInspectionValidityDate = formatter.string(from: datePicker.date)
                self.carInspectionValidityDate = formatter.string(from: datePicker.date)
            }
        }
        
        self.view.endEditing(false)
        
        tableView.reloadData()
        
//        txtDatePicker.text = formatter.string(from: datePicker.date)
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.fuelingDevicesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarManagmentTableViewCell.className, for: indexPath) as! CarManagmentTableViewCell
        
        cell.deleteCarDelegate = self
        cell.saveChangesDelegate = self
        cell.selectionStyle = .none
        
        if !self.user.fuelingDevicesArr[indexPath.row].objInfo.carManufacturer.isEmpty{
            cell.txtFldManufacturer.txtFldInput.text = self.user.fuelingDevicesArr[indexPath.row].objInfo.carManufacturer
        }
        
        if !self.user.fuelingDevicesArr[indexPath.row].objInfo.carModel.isEmpty{
            cell.txtFldModel.txtFldInput.text = self.user.fuelingDevicesArr[indexPath.row].objInfo.carModel
        }
        
        if !self.user.fuelingDevicesArr[indexPath.row].objInfo.carInspectionValidityDate.isEmpty{
            cell.txtFldDate.txtFldInput.text = self.user.fuelingDevicesArr[indexPath.row].objInfo.carInspectionValidityDate
        }
        
        cell.txtFldModel.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cell.txtFldManufacturer.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
      
         if user.fuelingDevicesArr[indexPath.row].isExtended {
            
            UIView.animate(withDuration: 0.3) {
                cell.imgDropDown.image = UIImage(named: "up")
                cell.vwCarMenegmentCell.removeShadow()
                cell.contentViewHeightConstraint.constant = 260
                cell.dropDownView.isHidden = false
                cell.dropDownView.addShadow()
                self.view.layoutIfNeeded()
//                self.user.fuelingDevicesArr[indexPath.row].isExtended = !self.user.fuelingDevicesArr[indexPath.row].isExtended
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
  

            cell.imgCar.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].strIcon, withAddUnderscoreIphone: false)
            cell.lblCarNumber.text = user.fuelingDevicesArr[indexPath.row].strTitle
            cell.imgFuelType.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].fuelItem.strIcon, withAddUnderscoreIphone: false)
            cell.lblCreditCardNumber.text = user.fuelingDevicesArr[indexPath.row].payment.strTitle
            cell.imgCreditCard.setImageWithStrURL(strURL: user.fuelingDevicesArr[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        
        mDCTextSetUp(mDCText: cell.txtFldManufacturer.txtFldInput, withPlaceholderText: "יצרן", withIndex: 1, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: " ", addToolbar: true)
       
        
        mDCTextSetUp(mDCText: cell.txtFldModel.txtFldInput, withPlaceholderText: "דגם", withIndex: 2, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: " ", addToolbar: true)
        
        
        mDCTextSetUp(mDCText: cell.txtFldDate.txtFldInput, withPlaceholderText: "תוקף טסט", withIndex: 3, withKeyboardType: .default, withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: " ", addToolbar: true)
        
        
        cell.txtFldDate.txtFldInput.inputView = datePicker
        
        return cell
    }
    
    
    
    
    
    
    
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.id = user.fuelingDevicesArr[indexPath.row].strId
        
        user.fuelingDevicesArr[indexPath.row].isExtended = !user.fuelingDevicesArr[indexPath.row].isExtended
        self.open = true
        
        self.view.layoutIfNeeded()
        self.tableView.reloadData()
        
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
        
        let dict = [TenParamsNames.id: self.id, TenParamsNames.carManufacturer: self.carManufacturer, TenParamsNames.carModel: self.carModel, TenParamsNames.carInspectionValidityDate: self.carInspectionValidityDate] as [String:Any]
        
        ApplicationManager.sharedInstance.userAccountManager.callUpdateFuelingDevice(dictParams: dict, requestFinishedDelegate: self)
    }
}


extension CarManagmentViewControoler {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        if request.requestName == TenRequestNames.getRemoveFuelingDevice {
           self.tableView.reloadData()
        }
        if request.requestName == TenRequestNames.getUpdateFuelingDevice {
            self.tableView.reloadData()
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
      
    }
}
