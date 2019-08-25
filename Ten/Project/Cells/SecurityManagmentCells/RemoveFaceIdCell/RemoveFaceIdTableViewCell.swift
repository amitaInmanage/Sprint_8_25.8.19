//
//  RemoveFaceIdTableViewCell.swift
//  Ten
//
//  Created by Amit on 25/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol RemoveFaceIdDelegate: NSObject {
    func didTapRemoveFaceId()
}

class RemoveFaceIdTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: RegularText!
    @IBOutlet weak var lblRemoveFaceId: SmallText!
    
    weak var delegate: RemoveFaceIdDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblRemoveFaceId.textColor = UIColor.getApllicationErrorColor()
          self.lblRemoveFaceId.text = Translation(Translations.AlertButtonsKeys.securityManagementRemovePinCode, Translations.AlertButtonsKeys.securityManagementRemovePinCodeDefault)
        self.lblTitle.text = Translation(Translations.Titles.faceIdTitle, Translations.Titles.faceIdTitleDefault)

    }

    @IBAction func didTapRemoveFaceId(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "Biomatric")
        
        if let delegate = delegate {
            delegate.didTapRemoveFaceId()
        }

    }
}
