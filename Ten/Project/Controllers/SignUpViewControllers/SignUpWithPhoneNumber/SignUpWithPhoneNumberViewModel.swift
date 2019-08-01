//
//  SignUpWithPhoneNumberViewModel.swift
//  Ten
//
//  Created by inmanage on 29/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpWithPhoneNumberViewModel: BaseViewModel {
    
    var keyboardH: CGFloat = 0
    let navigationH: CGFloat = ApplicationManager.sharedInstance.navigationController.navigationBar.frame.height
    let statusBarH: CGFloat = UIApplication.shared.statusBarFrame.height
    
    var strPhoneNumber = ""
    
    func validatePhoneNumber() -> Bool {

        return ApplicationManager.sharedInstance.inputValidationManager.isValidMobilePhoneNumber(phoneStr: self.strPhoneNumber)
        
    }
    
    func moveToTenGanrelPopup() {
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .tenGeneralPopup
        popupInfoObj.strImageName = "userIcon"
        popupInfoObj.strTitle = Translation(Translations.Titles.sending, Translations.Titles.sendingDefault)
        popupInfoObj.strSubtitle = Translation(Translations.Titles.sending, Translations.Titles.sentDefault)
        popupInfoObj.strFirstButtonTitle = Translation(Translations.Titles.sending, Translations.Titles.btnRegisterDefault)
        popupInfoObj.strSecondButtonTitle = Translation(Translations.Titles.sending, Translations.Titles.btnSkipDefault)
        popupInfoObj.secondButtonAction = {
            if let main = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: MainScreenViewController.className) as? MainScreenViewController {
                main.userConnect = false
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(main, animated: true)
            }
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
    }
}
