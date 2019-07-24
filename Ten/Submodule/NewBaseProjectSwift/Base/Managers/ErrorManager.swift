//
//  ErrorManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ErrorManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = ErrorManager()
    
    func handleErrorWithID(intErrorID: Int, strFailureMessage: String?) ->(ErrorAlertImpactType) {
        
        var errorAlertImpactType = ErrorAlertImpactType.none
        
        if ApplicationManager.sharedInstance.navigationController.viewControllers.isEmpty {
            return errorAlertImpactType
        }
        
        let errorType = self.getErrorTypeForErroID(intErrorID: intErrorID)
        
        switch errorType {
            
        case .homePage :
            
            errorAlertImpactType = .disableAlertActions
            
            if ApplicationManager.sharedInstance.navigationController.presentedViewController != nil {
                
                ApplicationManager.sharedInstance.navigationController.dismiss(animated: false, completion: {
                    ApplicationManager.sharedInstance.navigationController.popToRootViewController(animated: false)
                })
                
            } else {
                ApplicationManager.sharedInstance.navigationController.popToRootViewController(animated: false)
            }
            
        case .login :
            
            if ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn {
                return errorAlertImpactType
            }
            
            errorAlertImpactType = .disableAlert
            
            let popupInfoObj = PopupInfoObj()
            
            popupInfoObj.popupType = .general
            
            if let title = strFailureMessage {
                popupInfoObj.strTitle = title
            }
            
            popupInfoObj.strFirstButtonTitle = "התחברות"
            popupInfoObj.strSecondButtonTitle = "סגור"
            
            popupInfoObj.firstButtonAction = {
                
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
                
                ApplicationManager.sharedInstance.tabBarController.pushViewController(viewController: loginVC, animated: true)
            }
            
            ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
            
        case .restart :
            
            errorAlertImpactType = .disableAlert
            
            ApplicationManager.sharedInstance.restartAppWithBlockToExecute(blockToExecute: { })
            
        case .none :
            
            LogMsg("none error case")
        
        case .register:
            //register
            LogMsg("case register")

        }
        
        return errorAlertImpactType
        
    }
    
    
    private func getErrorTypeForErroID(intErrorID: Int) -> (ErrorType) {
        
        var type = ErrorType.none
        
        for strID in ApplicationManager.sharedInstance.appGD.arrThrowErrors {
            
            if(Int(strID) == intErrorID) {
                type = .restart
                break
            }
            
        }
        
        for strID in ApplicationManager.sharedInstance.appGD.arrToMenuErrors {
            
            if(Int(strID) == intErrorID) {
                type = .homePage
                break
            }
            
        }
        
        
        for strID in ApplicationManager.sharedInstance.appGD.arrToRegistrationErrors {
            
            if(Int(strID) == intErrorID) {
                type = .register
                break
            }
            
        }
        
        for strID in ApplicationManager.sharedInstance.appGD.arrToLoginErrors {
            
            if(Int(strID) == intErrorID) {
                type = .login
                break
            }
            
        }
        
        return type
        
    }
    
    
    override func reset() {
        ErrorManager.sharedInstance = ErrorManager()
    }
    
}
