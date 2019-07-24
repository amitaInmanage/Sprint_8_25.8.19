//
//  StationTableViewCell.swift
//  Ten
//
//  Created by shani daniel on 10/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgIsOpen: UIImageView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgSelected.isHidden = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
