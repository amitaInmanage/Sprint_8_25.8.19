//
//  PowerCardTableViewCell.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var imgPowerCard: UIImageView!
    @IBOutlet weak var vw: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
    
    fileprivate func initUI() {
        self.selectionStyle = .none
        self.lblDetails.text = Translation(Translations.SubTitles.rowPowercardTitle, Translations.SubTitles.rowPowercardTitleDefault)
        self.vw.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
