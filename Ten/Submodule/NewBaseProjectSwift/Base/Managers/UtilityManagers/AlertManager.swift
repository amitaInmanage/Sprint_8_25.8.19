//
//  AlertManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class AlertManager: BaseManager {
    
    var arrAlertViews : [UIAlertView]?
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = AlertManager()
    
    func showAlertWithAlertDisplayInViewType(alertDisplayInViewType: AlertDisplayInViewType, andTitle title: String, andMessage message: String?, andArrRIButtonItems arrRIButtonItems: [RIButtonItem]) {
        
        var aAlertViewType = alertDisplayInViewType
        
        //Verify that if iphone version is 10 and above , should you alertController (AlertView is deprecated)
        if iPhoneIOSVersion.IS_IOS_10_OR_LATER {
            aAlertViewType = .alertControllerAlert
        }
        
        switch aAlertViewType {
            
        case .alertControllerAlert :
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            for buttonItem in arrRIButtonItems {
                
                let alertAction = UIAlertAction(title: buttonItem.label, style: buttonItem.style, handler: { (action) in
                    
                    if buttonItem.action != nil {
                        buttonItem.action()
                    }
                    
                })
                
                alertController.addAction(alertAction)
                
            }
            
            if iPhoneIOSVersion.IS_IOS_8_OR_LATER && (UIDevice.current.systemVersion as NSString).floatValue <= 8.2 {
                alertController.view.frame = UIScreen.main.bounds
            }
            
//            ApplicationManager.sharedInstance.navigationController.present(alertController, animated: true, completion: nil)
            ApplicationManager.sharedInstance.appGeneralManager.alertViewController = alertController
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            

            
        case .alertControllerActionSheet :
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            for buttonItem in arrRIButtonItems {
                
                let alertAction = UIAlertAction(title: buttonItem.label, style: buttonItem.style, handler: { (action) in
                    
                    if buttonItem.action != nil {
                        buttonItem.action()
                    }
                    
                })
                
                alertController.addAction(alertAction)
                
            }

//            ApplicationManager.sharedInstance.navigationController.present(alertController, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)

            
        case .alertView :
            
            if arrRIButtonItems.count == 1 {
                
            }
            
   
        default:
            LogMsg("Not alertControllerAlert type")
        }
    
        
    }
    
    func showTwoButtonAlertWithAlertDisplayInViewType(alertDisplayInViewType :AlertDisplayInViewType, andTwoButtonAlertType twoButtonAlertType: TwoButtonAlertType, andTitle title: String, andMessage message: String?, andCancelAction cancelAction: (() -> ())?, andOkAction okAction: (() -> ())?) {
        
        var strCancelOrNo = ""
        var strOKOrYes = ""
        
        if twoButtonAlertType == .yesOrNo {
            
            strCancelOrNo = Translation(Translations.AlertButtonsKeys.no, Translations.AlertButtonsKeys.noDefault)
            strOKOrYes = Translation(Translations.AlertButtonsKeys.yes, Translations.AlertButtonsKeys.yesDefault)
            
        } else {
            
            strCancelOrNo = Translation(Translations.AlertButtonsKeys.cancel, Translations.AlertButtonsKeys.cancelDefault)
            strOKOrYes = Translation(Translations.AlertButtonsKeys.ok, Translations.AlertButtonsKeys.okDefault)
            
        }
        
        let arrRIButtonItems = [RIButtonItem.item(withLabel: strCancelOrNo, style: .cancel, action: cancelAction),RIButtonItem.item(withLabel: strOKOrYes, style: .default, action: okAction)]
        
        if let msg = message {
            
            self.showAlertWithAlertDisplayInViewType(alertDisplayInViewType: alertDisplayInViewType, andTitle: title, andMessage: msg, andArrRIButtonItems: arrRIButtonItems as! [RIButtonItem])
            
        } else {
            
            self.showAlertWithAlertDisplayInViewType(alertDisplayInViewType: alertDisplayInViewType, andTitle: title, andMessage: nil, andArrRIButtonItems: arrRIButtonItems as! [RIButtonItem])
        }
        
        
    }
    
    
    func showOneButtonOKAlertWithAlertDisplayInViewType(alertDisplayInViewType: AlertDisplayInViewType, andTitle title: String, andMessage message: String?, andAction action: (() -> ())?) {
        
        if alertDisplayInViewType == .alertCustomView {
            return
        }
        
        let arrRIButtonItems = [RIButtonItem.item(withLabel: Translation(Translations.AlertButtonsKeys.ok, Translations.AlertButtonsKeys.okDefault), style: .default, action: action)]
        
        if let msg = message {
            
            self.showAlertWithAlertDisplayInViewType(alertDisplayInViewType: alertDisplayInViewType, andTitle: title, andMessage: msg, andArrRIButtonItems: arrRIButtonItems as! [RIButtonItem])
            
        } else {
            
             self.showAlertWithAlertDisplayInViewType(alertDisplayInViewType: alertDisplayInViewType, andTitle: title, andMessage: nil, andArrRIButtonItems: arrRIButtonItems as! [RIButtonItem])
        }
        
  
    }
    
    
    
    //MARK: General
    
    // For app restarting purposes
   @discardableResult func isAppShowingAlertViews() -> (Bool) {
        
        if let aArrAlertViews = self.arrAlertViews {
            
            if aArrAlertViews.count > 0 {
                
                for aAlertView in aArrAlertViews {
                    
                    aAlertView.dismiss(withClickedButtonIndex: -1, animated: false)
                    
                }
                
                return true
            }
        }
        
        return false
    }
    
    func addAlertView(alertView: UIAlertView) {
        
        if self.arrAlertViews == nil {
            self.arrAlertViews = [UIAlertView]()
        }
        
        let weakAlertView = alertView
        
        self.arrAlertViews?.append(weakAlertView)
        
    }
    
    
    func removeAlertView(alertView: UIAlertView) {
        
        if self.arrAlertViews != nil && !(self.arrAlertViews?.isEmpty)! {
            
            if let index = self.arrAlertViews?.index(of:alertView) {
                self.arrAlertViews?.remove(at: index)
            }
            
        }
        
    }
    
    override func reset() {
        AlertManager.sharedInstance = AlertManager()
    }
    
}
