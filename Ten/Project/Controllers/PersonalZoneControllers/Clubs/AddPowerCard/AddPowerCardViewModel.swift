//
//  AddPowerCardViewModel.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class AddPowerCardViewModel: BaseViewModel {
    
    var strIdNumber = ""
    var strPinCode = ""
    
    func moveToToolTipPopup()  {
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "createPowerCard"
        popupInfoObj.strSubtitle = Translation(Translations.Titles.tooltipSecretCodePowercard, Translations.Titles.tooltipSecretCodePowercardDefault)
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}
