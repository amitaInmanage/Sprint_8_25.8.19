//
//  PumpWhichCarTableViewCell.swift
//  Ten
//
//  Created by shani daniel on 18/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class PumpWhichCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var imgCard: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
