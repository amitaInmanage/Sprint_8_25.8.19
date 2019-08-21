//
//  PowerCardTableViewCell.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDetails: SmallText!
    @IBOutlet weak var imgPowerCard: UIImageView!
    @IBOutlet weak var vw: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
    
    fileprivate func initUI() {
        self.selectionStyle = .none
        
        
        self.lblDetails.text = StringManager.sharedInstance.replaceString(originalString:   Translation(Translations.SubTitles.rowPowercardTitle, Translations.SubTitles.rowPowercardTitleDefault), replacement: ApplicationManager.sharedInstance.userAccountManager.user.powerCardArr.strBudget)
            
            
        
        self.vw.addShadow()
    }
}
