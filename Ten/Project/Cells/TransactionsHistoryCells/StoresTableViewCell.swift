//
//  ATableViewCell.swift
//  Ten
//
//  Created by Amit on 25/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class StoresTableViewCell: UITableViewCell {

    @IBOutlet weak var stackViewAccunulation: UIStackView!
    @IBOutlet weak var stackViewUsage: UIStackView!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: IMLabel!
    @IBOutlet weak var lblTime: IMLabel!
    @IBOutlet weak var lblAccumulationAmount: IMLabel!
    @IBOutlet weak var lblUsageAmount: IMLabel!
    @IBOutlet weak var lblAmount: IMLabel!
    @IBOutlet weak var imgUp: UIImageView!
    @IBOutlet weak var dropDown: UIView!
    @IBOutlet weak var vwHistory: UIView!
    @IBOutlet weak var dropDownConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var imgCar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vwHistory.addShadow()
        self.dropDown.isHidden = true
        self.dropDown.addShadow()
        self.historyBottomConstraint.constant = 129.5
      //  self.historyBottomConstraint.constant = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

