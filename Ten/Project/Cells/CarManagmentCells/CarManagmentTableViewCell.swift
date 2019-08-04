//
//  CarManagmentTableViewCell.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CarManagmentTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblCarNumber: RegularLabel!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var lblCreditCardNumber: RegularLabel!
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var vwCarMenegmentCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }

    fileprivate func initUI() {
        self.vwCarMenegmentCell.addShadow()
    }
}
