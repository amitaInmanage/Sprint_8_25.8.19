//
//  RemoveTouchIdTableViewCell.swift
//  Ten
//
//  Created by Amit on 25/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol RemoveTouchIdDelegate: NSObject {
    func didTapRemoveTouchId()
}

class RemoveTouchIdTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRemoveTouchId: SmallText!
    @IBOutlet weak var lblTitle: RegularText!
    
    weak var delegate: RemoveTouchIdDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblRemoveTouchId.text = Translation(Translations.AlertButtonsKeys.securityManagementRemovePinCode, Translations.AlertButtonsKeys.securityManagementRemovePinCodeDefault)
        self.lblTitle.text = Translation(Translations.Titles.touchIdTitle, Translations.Titles.touchIdTitleDefault)
        self.lblRemoveTouchId.textColor = UIColor.getApllicationErrorColor()
    }

   
    @IBAction func didTapRemoveTouchId(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "Biomatric")

        if let delegate = delegate {
            delegate.didTapRemoveTouchId()
        }
    }
}
