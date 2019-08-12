//
//  PowerCardClubTableViewCell.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardClubTableViewCell: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }

    private func initUI() {
        self.vwContent.addShadowAndCorner()
    }
}
