
//
//  AppGeneralManager.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 27/09/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class AppGeneralManager: BaseManager {

    static var sharedInstance = AppGeneralManager()

    private var factIndex = 0
    
    private var gameAreaBoardId = ""
    private var isGameAreaFromHomePage = false
    
    var alertViewController = UIAlertController()
    // MARK: Homepage helper
    

    // MARK: Requests
    
   
    // MARK: RequestFinishedProtocol
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
      
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }

    // MARK: General

    func openResetPasswordPopup(token: String) {
        
        let popupInfoObj = PopupInfoObj()
        popupInfoObj.popupType = .resetPassword
        popupInfoObj.dataObject = token
        popupInfoObj.firstButtonAction = {
            
        }
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        
    }
 
   

}
