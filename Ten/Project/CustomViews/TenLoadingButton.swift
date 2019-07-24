//
//  TenLoadingButton.swift
//  Ten
//
//  Created by inmanage on 16/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class TenLoadingButton: IMButton {

    var strSendingHeb = Translation(Translations.Titles.sendingHeb, Translations.Titles.sendingHeb)
    var steSending = Translation(Translations.Titles.sending, Translations.Titles.sendingDefault)

    
    override func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle(strSendingHeb, for: .normal)
        
        if (activityIndicator == nil) {
            self.activityIndicator = self.createActivityIndicator()
        }
        
        self.showSpinning()
    }
}
