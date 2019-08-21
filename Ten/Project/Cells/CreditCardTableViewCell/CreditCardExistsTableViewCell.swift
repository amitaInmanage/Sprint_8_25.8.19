//
//  CreditCardExistsTableViewCell.swift
//  Ten
//
//  Created by Amit on 04/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CreditCardExistsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var lblCardNumber: RegularText!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
