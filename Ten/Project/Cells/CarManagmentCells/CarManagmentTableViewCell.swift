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
    
     weak var deleteCarDelegate: DeleteCarDelegate?
     weak var saveChangesDelegate: SaveChangesDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
        
    }

    fileprivate func initUI() {
        self.vwCarMenegmentCell.addShadow()
        self.btnDeleteCar.setWhiteBackground()
        self.btnDeleteCar.setTitle("הסר", for: .normal)
        self.btnSaveChanges.setTitle("שמור שיוניים", for: .normal)
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

