//
//  PopupInfoObj.swift
//  WelcomeInSwift
//
//  Created by inmanage on 12/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class PopupInfoObj : NSObject {
    
    override init() {
        super.init()
        
        self.popupShowType = KLCPopupShowType.fadeIn
        self.popupDismissType = KLCPopupDismissType.fadeOut
        self.popupVerticalLayout = KLCPopupVerticalLayout.center
        self.dismissOnBackgroundTouch = false
    }
    
    var popupType: PopupType = .none;
    var strTitle: String?
    
    var strPickLimitFormatTitle: String?
    var strLimitInputTitle: String?

    //PickPumpObligoLiter
    var strLiterFuelingLimitDefault: String?
    var strMoneyFuelingLimitDefault: String?
    var strLiterTxt: String?
    var strMoneyTxt: String?

    var strInitButtonTitle: String?
    var strEmailPlaceHolder: String?
    var strErrorEmail: String?
   
    var btnConfirmColor: BtnConfirmColors? 
    var strSubtitle: String?
    var strBottomText: String?
    var strDescription: String?
    var strTxtFldPlaceholder: String?
    var strTxtFldError: String?

    var strImageURL: String?
    var strImageName: String?
    var strSecondButtonImage: String?
    var strHeaderTitle: String?
    var dataObject: Any?
    
    var popupShowType: KLCPopupShowType!
    var popupDismissType: KLCPopupDismissType!
    var popupVerticalLayout: KLCPopupVerticalLayout!
    var dismissOnBackgroundTouch: Bool!
    
    // Close button action if needed.
    var closeButtonAction: (() -> ())?
    var closeButtonActionWithObj: ((_ dataObject :Any) -> ())?
    
    // Buttons are in the order of top to bottom / left to right - Actions/Titles
    var secondBtnIsReverseColor: Bool? = true
    var shouldHaveCloseBtn:Bool? = true
    var strFirstButtonTitle: String?
    var strSecondButtonTitle: String?
    var strSkipButtonTitle: String?
    
    var strConfirmButtonTitle: String?

    var hideFirstButton: Bool?
    var hideSecondButton: Bool?
    var firstButtonAction: (() -> ())?
    var firstButtonActionWithObj: ((_ dataObject :Any) -> ())?
    var secondButtonAction: (() -> ())?
    var secondButtonActionWithObj: ((_ dataObject :Any) -> ())?

    var skipButtonAction: (() -> ())?
    var skipButtonActionWithObj: ((_ dataObject :Any) -> ())?
    
    var confirmButtonAction: (() -> ())?
    var confirmButtonActionWithObj: ((_ dataObject :Any) -> ())?
    
    var initButtonAction: (() -> ())?
    var initButtonActionWithObj: ((_ dataObject :Any) -> ())?
  
}
