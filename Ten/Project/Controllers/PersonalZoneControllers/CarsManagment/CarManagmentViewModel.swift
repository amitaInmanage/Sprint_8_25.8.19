//
//  CarManagmentViewModel.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class CarManagmentViewModel: BaseViewModel {
 
    func moveToTenGanrelPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "carAdd"
        popupInfoObj.strTitle = Translation(Translations.Titles.addFuelingCardSuccess, Translations.Titles.addFuelingCardSuccessDefault)
        popupInfoObj.strSubtitle = Translation(Translations.SubTitles.addFuelingCardSuccess, Translations.SubTitles.addFuelingCardSuccessDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.addFuelingCardSucces, Translations.AlertButtonsKeys.addFuelingCardSuccesDefault)
        
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}
