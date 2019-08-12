//
//  PowerCardViewModel.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardViewModel: BaseViewModel {
    
    
    func showPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .exit
        popupInfoObj.strTitle = Translation(Translations.Titles.popupDisconnectPowercard, Translations.Titles.popupDisconnectPowercardDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.popupDisconnectPowercard, Translations.SubTitles.popupDisconnectPowercardDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardYes, Translations.AlertButtonsKeys.popupRemoveFuelingCardYesDefault)
        popupInfoObj.strSkipButtonTitle = Translation(Translations.AlertButtonsKeys.popupRemoveFuelingCardNo, Translations.AlertButtonsKeys.popupRemoveFuelingCardNoDefault)
        popupInfoObj.firstButtonAction = {
            ApplicationManager.sharedInstance.userAccountManager.callRemovePowerCard(requestFinishedDelegate: nil)
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}
