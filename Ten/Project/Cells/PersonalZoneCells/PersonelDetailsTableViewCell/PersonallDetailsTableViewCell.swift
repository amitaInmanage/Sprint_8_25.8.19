//
//  PeresonelDetailsTableViewCell.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
