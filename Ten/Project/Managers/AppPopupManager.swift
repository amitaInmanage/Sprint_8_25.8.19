//
//  TenPopupManager.swift
//  Ten
//
//  Created by Shani on 09/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class AppPopupManager: PopupManager {
    
    static var sharedInstance = AppPopupManager()
    
    override func reset() {
        AppPopupManager.sharedInstance = AppPopupManager()
    }
    
    func openUserBlockedPopup() {
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.strTitle = Translation(UserBlockedPopup.lblTitle, UserBlockedPopup.lblTitleDefault)
        popupInfoObj.strSubtitle = Translation(UserBlockedPopup.lblSubtitle, UserBlockedPopup.lblSubtitleDefault)
        popupInfoObj.strImageName = "block_card"
        popupInfoObj.strFirstButtonTitle = Translation(UserBlockedPopup.btnTitle, UserBlockedPopup.btnTitleDefault)
        popupInfoObj.firstButtonAction = {
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - SuccessfulRegistrationPopup
    
    func openSuccessfulRegistrationPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(SuccessfulRegistrationPopupTranslations.lblTitle , SuccessfulRegistrationPopupTranslations.lblTitleDefault)
        popupInfoObj.strSubtitle = Translation(SuccessfulRegistrationPopupTranslations.lblSubtitle , SuccessfulRegistrationPopupTranslations.lblSubtitleDefault)
        popupInfoObj.strImageName = "user_confeti"
        
        popupInfoObj.strFirstButtonTitle = Translation(SuccessfulRegistrationPopupTranslations.btnGotItTitle , SuccessfulRegistrationPopupTranslations.btnGotItTitleDefault)
        popupInfoObj.firstButtonAction = {
        }
        popupInfoObj.strSecondButtonTitle = Translation(SuccessfulRegistrationPopupTranslations.btnAddCarTitle , SuccessfulRegistrationPopupTranslations.btnAddCarTitleDefault)
        popupInfoObj.strSecondButtonImage = "plus"
        
        popupInfoObj.secondButtonAction = {
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - ToolTipsPopup
    
    func openToolTipsPopup() {
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.strTitle = Translation(ToolTipsPopup.lblTitle , ToolTipsPopup.lblTitleDefault)
        popupInfoObj.strSubtitle = Translation(ToolTipsPopup.lblSubtitle , ToolTipsPopup.lblSubtitleDefault)
        
        popupInfoObj.strImageName = "cardCvv"
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - PleaseEnterDetailsPopup
    
    func openPleaseEnterDetailsPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(PleaseEnterDetailsPopupTranslations.lblTitle , PleaseEnterDetailsPopupTranslations.lblTitleDefault)
        popupInfoObj.strSubtitle = Translation(PleaseEnterDetailsPopupTranslations.lblSubtitle , PleaseEnterDetailsPopupTranslations.lblSubtitleDefault)
        popupInfoObj.strImageName = "sign_in"
        popupInfoObj.strSkipButtonTitle = Translation(PleaseEnterDetailsPopupTranslations.btnSkip , PleaseEnterDetailsPopupTranslations.btnSkipDefault)
        popupInfoObj.skipButtonAction = {
        }
        popupInfoObj.strFirstButtonTitle = Translation(PleaseEnterDetailsPopupTranslations.btnRegister , PleaseEnterDetailsPopupTranslations.btnRegisterDefault)
        popupInfoObj.firstButtonAction = {
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - HaveAnotherCreditCardPopup
    
    func openHaveAnotherCreditCardPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(HaveAnotherCreditCardPopupTranslations.lblTitle , HaveAnotherCreditCardPopupTranslations.lblTitleDefault)
        
        let originalString = Translation(HaveAnotherCreditCardPopupTranslations.lblSubtitle , HaveAnotherCreditCardPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.strSubtitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserPhoneNumber","strUserCarType")
        
        popupInfoObj.strImageName = "sign_in_vip"
        
        popupInfoObj.strSkipButtonTitle = Translation(HaveAnotherCreditCardPopupTranslations.btnSkip , HaveAnotherCreditCardPopupTranslations.btnSkipDefault)
        popupInfoObj.skipButtonAction = {
        }
        popupInfoObj.strFirstButtonTitle = Translation(HaveAnotherCreditCardPopupTranslations.btnAdd , HaveAnotherCreditCardPopupTranslations.btnAddDefault)
        popupInfoObj.firstButtonAction = {
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - WelcomeBackPopup
    
    func openWelcomeBackPopup() {
        
        let popupInfoObj = PopupInfoObj()
        let originalString = Translation(WelcomeBackPopupTranslations.lblTitle , WelcomeBackPopupTranslations.lblTitleDefault)
        popupInfoObj.strSubtitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserName")
        popupInfoObj.strImageName = "welcome"
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - ShowCvvNumberLocationPopup
    
    func openShowCvvNumberLocationPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        let originalString = Translation(ShowCvvNumberLocationPopupTranslations.lblTitle , ShowCvvNumberLocationPopupTranslations.lblTitleDefault)
        popupInfoObj.strSubtitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserName")
        popupInfoObj.strSubtitle = Translation(ShowCvvNumberLocationPopupTranslations.lblSubtitle , ShowCvvNumberLocationPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.strImageName = "card_cvv"
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - GpsLocationProblemPopup
    
    func openGpsLocationProblemPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(GpsLocationProblemPopupTranslations.lblTitle , GpsLocationProblemPopupTranslations.lblTitleDefault)
        
        popupInfoObj.strSubtitle = Translation(GpsLocationProblemPopupTranslations.lblSubtitle , GpsLocationProblemPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.strImageName = "telescope"
        
        popupInfoObj.strFirstButtonTitle = Translation(GpsLocationProblemPopupTranslations.btnNo , GpsLocationProblemPopupTranslations.btnNoDefault)
        popupInfoObj.firstButtonAction = {
           
        }
        
        popupInfoObj.secondBtnIsReverseColor = false
        
        popupInfoObj.strSecondButtonTitle = Translation(GpsLocationProblemPopupTranslations.btnYes , GpsLocationProblemPopupTranslations.btnYesDefault)
        popupInfoObj.secondButtonAction = {
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - ObligoBalanceIsOverPopup
    
    func openObligoBalanceIsOverPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(ObligoBalanceIsOverPopupTranslations.lblTitle , ObligoBalanceIsOverPopupTranslations.lblTitleDefault)
        
        let originalString = Translation(ObligoBalanceIsOverPopupTranslations.lblSubtitle , ObligoBalanceIsOverPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.strSubtitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "cardNumber")
        
        popupInfoObj.strImageName = "cardOver"
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - GpsPermissionIsMissingPopup
    
    func openGpsPermissionIsMissingPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        let originalString = Translation(GpsPermissionIsMissingPopupTranslations.lblTitle , GpsPermissionIsMissingPopupTranslations.lblTitleDefault)
    
        popupInfoObj.strTitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserName")
        
        popupInfoObj.strSubtitle = Translation(GpsPermissionIsMissingPopupTranslations.lblSubtitle , GpsPermissionIsMissingPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.strImageName = "settings"
        
        popupInfoObj.strSkipButtonTitle = Translation(GpsPermissionIsMissingPopupTranslations.btnSkip , GpsPermissionIsMissingPopupTranslations.btnSkipDefault)
        popupInfoObj.skipButtonAction = {
        }
        popupInfoObj.strFirstButtonTitle = Translation(GpsPermissionIsMissingPopupTranslations.btnDefinitions , GpsPermissionIsMissingPopupTranslations.btnDefinitionsDefault)
        popupInfoObj.firstButtonAction = {
            let url = ApplicationManager.sharedInstance.openURLManager.createUrlFromString(strUrl: UIApplicationOpenSettingsURLString)
            ApplicationManager.sharedInstance.openURLManager.openUrl(url: url)
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - EmailSentSuccessfullyPopup
    
    func openEmailSentSuccessfullyPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        let originalString = Translation(EmailSentSuccessfullyPopupTranslations.lblTitle , EmailSentSuccessfullyPopupTranslations.lblTitleDefault)
        popupInfoObj.strTitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "email address")
        
        popupInfoObj.strImageName = "mail"
        
        popupInfoObj.strFirstButtonTitle = Translation(EmailSentSuccessfullyPopupTranslations.btnConfirm, EmailSentSuccessfullyPopupTranslations.btnConfirmDefault)
        popupInfoObj.firstButtonAction = {
        }
        
        self.openGeneralPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - EnsureSwitchFromTenCardPopup
    
    func openEnsureSwitchFromTenCardPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        let originalString = Translation(EnsureSwitchFromTenCardPopupTranslations.lblTitle , EnsureSwitchFromTenCardPopupTranslations.lblTitleDefault)
        popupInfoObj.strTitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserName")
        
        popupInfoObj.strSubtitle = Translation(EnsureSwitchFromTenCardPopupTranslations.lblSubtitle , EnsureSwitchFromTenCardPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.strImageName = "changeCard"
        
        popupInfoObj.strSkipButtonTitle = Translation(EnsureSwitchFromTenCardPopupTranslations.btnSkip , EnsureSwitchFromTenCardPopupTranslations.btnSkipDefault)
        popupInfoObj.skipButtonAction = {
            
        }
        popupInfoObj.strConfirmButtonTitle  = Translation(EnsureSwitchFromTenCardPopupTranslations.btnSwitch , EnsureSwitchFromTenCardPopupTranslations.btnSwitchDefault)
        popupInfoObj.confirmButtonAction = {
        }
        
        self.openSecondaryGenerallPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - PointsHowItWorkPopup
    
    func openPointsHowItWorkPopup() { 
        
        let popupInfoObj = PopupInfoObj() 
        
        popupInfoObj.strTitle = Translation(PointsHowItWorkPopupTranslations.lblTitle , PointsHowItWorkPopupTranslations.lblTitleDefault)
        
        popupInfoObj.strSubtitle = Translation(PointsHowItWorkPopupTranslations.lblSubtitle , PointsHowItWorkPopupTranslations.lblSubtitleDefault)
    
        popupInfoObj.strImageName = "customerCard"
        
        let originalString = Translation(PointsHowItWorkPopupTranslations.lblBottomText , PointsHowItWorkPopupTranslations.lblBottomTextDefault)
        
        popupInfoObj.strBottomText = ApplicationManager.sharedInstance.stringManager.setTwoLanguagesStringIntegrat(originalString: originalString)
        
        self.openSecondaryGenerallPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - EnsureCorrectPumpPopup
    
    func openEnsureCorrectPumpWithSelfServicePopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        var originalString = Translation(EnsureCorrectPumpPopupTranslations.lblTitle , EnsureCorrectPumpPopupTranslations.lblTitleDefault)
        
        originalString = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserName")
        
        popupInfoObj.strTitle = ApplicationManager.sharedInstance.stringManager.setTwoLanguagesStringIntegrat(originalString: originalString)
        
        popupInfoObj.strSubtitle = Translation(EnsureCorrectPumpPopupTranslations.lblSubtitle , EnsureCorrectPumpPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.btnConfirmColor = BtnConfirmColors.Blue
        
        let strBtnSelfService = Translation(EnsureCorrectPumpPopupTranslations.btnSelfService , EnsureCorrectPumpPopupTranslations.btnSelfServiceDefault)
        
        popupInfoObj.strConfirmButtonTitle  = strBtnSelfService
        popupInfoObj.confirmButtonAction = {
        }
        self.openButtonSwitchColorPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - EnsureCorrectPumpWithFullServicePopup
    
    func openEnsureCorrectPumpWithFullServicePopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        let originalString = Translation(EnsureCorrectPumpPopupTranslations.lblTitle , EnsureCorrectPumpPopupTranslations.lblTitleDefault)
        popupInfoObj.strTitle = ApplicationManager.sharedInstance.stringManager.replaceString(originalString: originalString, replacement: "strUserName")
        
        popupInfoObj.strSubtitle = Translation(EnsureCorrectPumpPopupTranslations.lblSubtitle , EnsureCorrectPumpPopupTranslations.lblSubtitleDefault)
        
        popupInfoObj.btnConfirmColor = BtnConfirmColors.Green
        
        let strBtnFullService = Translation(EnsureCorrectPumpPopupTranslations.btnFullService , EnsureCorrectPumpPopupTranslations.btnFullServiceDefault)
        
        
        popupInfoObj.strConfirmButtonTitle  = strBtnFullService
        popupInfoObj.confirmButtonAction = {
            
        }
        self.openButtonSwitchColorPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - InsertYourEmailAddressPopup
    
    func openInsertYourEmailAddressPopup () {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(InsertYourEmailAddressPopupTranslations.lblTitle , InsertYourEmailAddressPopupTranslations.lblTitleDefault)
        
        popupInfoObj.strEmailPlaceHolder = Translation(InsertYourEmailAddressPopupTranslations.emailPlaceHolder, InsertYourEmailAddressPopupTranslations.emailPlaceHolderDefault)
        
        popupInfoObj.strErrorEmail = Translation(InsertYourEmailAddressPopupTranslations.emailError, InsertYourEmailAddressPopupTranslations.emailErrorDefault)
        
        popupInfoObj.strConfirmButtonTitle  = Translation(InsertYourEmailAddressPopupTranslations.btnConfirm , InsertYourEmailAddressPopupTranslations.btnConfirmDefault)
        popupInfoObj.confirmButtonAction = {
            
        }
        
        self.openInputPopup(popupInfoObj: popupInfoObj)
    }
    
    // MARK: - PickPumpObligoLiterPopup
    
    func openPickPumpObligoLiterPopup () {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(PickPumpObligoLiterPopupTranslations.lblTitle, PickPumpObligoLiterPopupTranslations.lblTitleDefault)
        
        popupInfoObj.strLimitInputTitle = Translation(PickPumpObligoLiterPopupTranslations.limitInputTitle, PickPumpObligoLiterPopupTranslations.limitInputTitleDefault)
        
        popupInfoObj.strPickLimitFormatTitle = Translation(PickPumpObligoLiterPopupTranslations.pickLimitFormatTitle, PickPumpObligoLiterPopupTranslations.pickLimitFormatTitleDefault)
        
        popupInfoObj.strLiterTxt = Translation(PickPumpObligoLiterPopupTranslations.lblLiter, PickPumpObligoLiterPopupTranslations.lblLiterDefault)
        
        popupInfoObj.strMoneyTxt = Translation(PickPumpObligoLiterPopupTranslations.lblMoney, PickPumpObligoLiterPopupTranslations.lblMoneyDefault)
        
        popupInfoObj.strLiterFuelingLimitDefault = String(ApplicationManager.sharedInstance.appGD.literFuelingLimitDefault)
        popupInfoObj.strLiterFuelingLimitDefault = String(ApplicationManager.sharedInstance.appGD.moneyFuelingLimitDefault)
        
        popupInfoObj.strInitButtonTitle  = Translation(PickPumpObligoLiterPopupTranslations.btnInit, PickPumpObligoLiterPopupTranslations.btnInitDefault)
        popupInfoObj.initButtonAction = {
            
        }
        
        popupInfoObj.strConfirmButtonTitle  = Translation(PickPumpObligoLiterPopupTranslations.btnConfirm, PickPumpObligoLiterPopupTranslations.btnConfirmDefault)
        popupInfoObj.confirmButtonAction = {
            
        }
        
        self.openpickObligoPopup(popupInfoObj: popupInfoObj)
    }
    
    ///////////////////////  ChangeStation
    
    
    func openChangeStationPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        
        self.openChangeStationPopup(popupInfoObj: popupInfoObj)
    }
    
    func openChangeStationPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .changeStation
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    
    
    
    
    //////////////////////
    
    
    func openPinCodePopupPopup () {
        
        let popupInfoObj = PopupInfoObj()
        
        //
        
        self.openpickObligoPopup(popupInfoObj: popupInfoObj)
    }
   
    func openPinCodePopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .pin
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    func openSecondaryGenerallPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .secondaryGeneral
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    func openpickObligoPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .pickObligo
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    func openPickPumpWhichCarPopup() {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.strTitle = Translation(PickPumpWhichCarPopupTranslations.lblTitle , PickPumpWhichCarPopupTranslations.lblTitleDefault)
        popupInfoObj.popupShowType = KLCPopupShowType.slideInFromBottom
        
        self.openTableViewPopup(popupInfoObj: popupInfoObj)
        
    }
    
    func openTableViewPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .table
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    func openInputPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .input
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    func openButtonSwitchColorPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .buttonSwitchColor
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }
    
    func openGeneralPopup(popupInfoObj: PopupInfoObj) {
        
        popupInfoObj.popupType = .general
        
        self.openPopup(popupInfoObj: popupInfoObj, popupViewControllerDelegate: nil)
    }

    func openPopup(popupInfoObj: PopupInfoObj, popupViewControllerDelegate: PopupViewControllerDelegate?) {
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: popupViewControllerDelegate)

    }
    
    
  
}
























