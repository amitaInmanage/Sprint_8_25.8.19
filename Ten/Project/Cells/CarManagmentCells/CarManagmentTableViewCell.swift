//
//  CarManagmentTableViewCell.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol DeleteCarDelegate: NSObject {
    func didTapRemoveCar()
}

protocol SaveChangesDelegate: NSObject {
    func didTapSaveChanges()
}

class CarManagmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dropDownConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblCarNumber: RegularLabel!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var lblCreditCardNumber: RegularLabel!
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var vwCarMenegmentCell: UIView!
    @IBOutlet weak var txtFldManufacturer: InputCustomView!
    @IBOutlet weak var txtFldModel: InputCustomView!
    @IBOutlet weak var txtFldDate: InputCustomView!
    @IBOutlet weak var btnDeleteCar: TenButtonStyle!
    @IBOutlet weak var btnSaveChanges: TenButtonStyle!
    @IBOutlet weak var dropDownView: UIView!
    
    weak var deleteCarDelegate: DeleteCarDelegate?
    weak var saveChangesDelegate: SaveChangesDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
        self.contentViewHeightConstraint.constant = 95
        self.dropDownView.isHidden = true
    }
    
    fileprivate func initUI() {
        self.vwCarMenegmentCell.addShadow()
        self.btnDeleteCar.setWhiteBackground()
        self.btnDeleteCar.setImage(UIImage(named: "blueTrush"), for: .normal)
        self.btnDeleteCar.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -80)
        self.btnDeleteCar.setTitle(Translation(Translations.AlertButtonsKeys.securityManagementRemovePinCode, Translations.AlertButtonsKeys.securityManagementRemovePinCodeDefault), for: .normal)
        self.btnDeleteCar.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        self.btnSaveChanges.setTitle(Translation(Translations.AlertButtonsKeys.VehicleManagementRowSaveChanges, Translations.AlertButtonsKeys.VehicleManagementRowSaveChangesDefault), for: .normal)
    }
    
    @IBAction func didTapRemoveCar(_ sender: Any) {
        if let delegate = deleteCarDelegate {
            delegate.didTapRemoveCar()
        }
    }
    
    @IBAction func didTapSaveChanges(_ sender: Any) {
        if let delegate = saveChangesDelegate {
            delegate.didTapSaveChanges()
        }
    }
}

