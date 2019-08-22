//
//  ClubsTableViewCell.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TenClubsTableViewCell: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblTitle: RegularText!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }

    fileprivate func initUI() {
        self.vwContent.addShadowAndCorner()
        self.lblTitle.text = Translation(Translations.Titles.rowClubsDelekTen, Translations.Titles.rowClubsDelekTenDefault)
    }
}
