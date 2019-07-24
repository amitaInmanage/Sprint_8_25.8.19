//
//  MySavingsTableViewCell.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class MySavingsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSeving: UIImageView!
    @IBOutlet weak var imgTenVip: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var contantView: UIView!
    @IBOutlet weak var vw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vw.addShadow()
        self.initUI()
    }
    
    fileprivate func initUI() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.lblDetails.text = Translation(Translations.Titles.rowSaving, Translations.Titles.rowSavingDefault)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
