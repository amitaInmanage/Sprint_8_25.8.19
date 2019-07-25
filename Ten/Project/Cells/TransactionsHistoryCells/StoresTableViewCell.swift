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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

