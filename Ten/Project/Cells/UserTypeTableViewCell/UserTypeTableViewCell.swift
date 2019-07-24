//
//  UserTypeCellTableViewCell.swift
//  Ten
//
//  Created by shani daniel on 13/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class UserTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
