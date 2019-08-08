//
//  ATableViewCell.swift
//  Ten
//
//  Created by Amit on 25/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StoresTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var stackViewAccunulation: UIStackView!
    @IBOutlet weak var stackViewUsage: UIStackView!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: IMLabel!
    @IBOutlet weak var lblTime: IMLabel!
    @IBOutlet weak var lblAccumulationAmount: IMLabel!
    @IBOutlet weak var lblUsageAmount: IMLabel!
    @IBOutlet weak var lblAmount: IMLabel!
    @IBOutlet weak var vwDropDown: UIView!
    @IBOutlet weak var vwHistory: UIView!
    @IBOutlet weak var dropDownConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var imgCar: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.lblTitle.text = ""
        self.lblDate.text = ""
        self.lblTime.text = ""
        self.lblAccumulationAmount.text = ""
        self.lblAmount.text = ""
        self.imgCar.image = nil
        self.imgType.image = nil
        self.imgFuelType.image = nil
        self.imageView?.image = nil
        self.btnDropDown.isHidden = false
        self.vwDropDown.isHidden = true
        self.historyBottomConstraint.constant = 95

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwHistory.addShadow()
        self.vwDropDown.isHidden = true
        self.vwDropDown.addShadow()
        self.historyBottomConstraint.constant = 129.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

