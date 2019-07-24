//
//  PopupManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//



class PopupManager: BaseManager {
    
    var arrPopupVCs = [BasePopupViewController]()
    private var arrKLCPopups = [KLCPopup]()
    
    //MARK: Public functions
    // Returns the appropriate popup type for a request's response
    func getPopupTypeForRequestName(requestName: String, withIsSuccess isSuccess: Bool) -> (PopupType) {
        
        if isSuccess {
            return .requestSuccess
        } else {
            return .requestFailure
        }
        
    }
    
    // Convenience method for showing popups after a request's response has been received (can replace a response message title received from server if necessary, or add one)
    func handleShowPopupVCForRequestName(requestName: String, withStrMessage strMessage: String, andStrFirstButtonTitle strFirstButtonTitle: String?, andCloseButtonAction closeButtonAction: (() -> ())?, andFirstButtonAction firstButtonAction: (() -> ())?, andIsSuccess isSuccess:Bool, andPopupViewControllerDelegate popupViewControllerDelegate: PopupViewControllerDelegate?) {
        
        let popupType = getPopupTypeForRequestName(requestName: requestName, withIsSuccess: isSuccess)
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.popupType = popupType
        popupInfoObj.strTitle = strMessage
        popupInfoObj.strFirstButtonTitle = strFirstButtonTitle
        popupInfoObj.firstButtonAction = firstButtonAction
        popupInfoObj.closeButtonAction = closeButtonAction
        
        
        createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: popupViewControllerDelegate)
        
    }
    
    // Creates a popup VC based on the received PopupType (in popupInfoObj), and attaches it's view to a KLCPopup to be shown in the keyWindow
    
    func createPopupVCWithPopupInfoObj(popupInfoObj: PopupInfoObj, andPopupViewControllerDelegate popupViewControllerDelegate: PopupViewControllerDelegate?, subtitleAlignment: SubtitleAlignment = .center) {
        
        var popupVC = UIViewController()
        
        let sb = UIStoryboard.init(name: "Popups", bundle: nil)
        
        switch popupInfoObj.popupType {
            
        case .requestFailure:
            
            if !(popupInfoObj.strTitle?.isEmpty)! {
                popupVC = sb.instantiateViewController(withIdentifier: GeneralPopupViewController.className) as! GeneralPopupViewController
                popupInfoObj.strFirstButtonTitle = "אישור"
            } else {
                return
            }
            
        case .loginOrSignup:
            popupVC = sb.instantiateViewController(withIdentifier: GeneralPopupViewController.className) as! GeneralPopupViewController
            
        case .general:
            popupVC = sb.instantiateViewController(withIdentifier: GeneralPopupViewController.className) as! GeneralPopupViewController
            if let vc = popupVC as? GeneralPopupViewController {
                vc.subtitleAlignment = subtitleAlignment
            }
            
        case .secondaryGeneral:
            popupVC = sb.instantiateViewController(withIdentifier: SecondaryGeneralPopupViewController.className) as! SecondaryGeneralPopupViewController
            if let vc = popupVC as? SecondaryGeneralPopupViewController {
                vc.subtitleAlignment = subtitleAlignment
            }
            
        case .buttonSwitchColor:
            popupVC = sb.instantiateViewController(withIdentifier: ButtonSwitchColorPopupViewController.className) as! ButtonSwitchColorPopupViewController
            if let vc = popupVC as? ButtonSwitchColorPopupViewController {
                vc.subtitleAlignment = subtitleAlignment
            }
            
        case .input:
            popupVC = sb.instantiateViewController(withIdentifier: InputPopupViewController.className) as! InputPopupViewController
            if let vc = popupVC as? InputPopupViewController {
                vc.subtitleAlignment = subtitleAlignment
            }
            
        case .pin:
            popupVC = sb.instantiateViewController(withIdentifier: IdentificationPinCodePopupViewController.className) as! IdentificationPinCodePopupViewController
            if let vc = popupVC as? IdentificationPinCodePopupViewController {
                vc.subtitleAlignment = subtitleAlignment
            }
            
        case .pickObligo:
            popupVC = sb.instantiateViewController(withIdentifier: PickPumpObligoLiterPopupViewController.className) as! PickPumpObligoLiterPopupViewController
            if let vc = popupVC as? PickPumpObligoLiterPopupViewController {
                vc.subtitleAlignment = subtitleAlignment
            }
            
        case .changeStation:
            popupVC = sb.instantiateViewController(withIdentifier: ChangeStationViewController.className) as! ChangeStationViewController
            if let vc = popupVC as? ChangeStationViewController {
            }
            
        case .table:
            popupVC = sb.instantiateViewController(withIdentifier: PickPumpWhichCarPopupViewController.className) as! PickPumpWhichCarPopupViewController

        case .tenGeneralPopup:
            popupVC = sb.instantiateViewController(withIdentifier: TenGanrelPopupViewController.className) as! TenGanrelPopupViewController
            
        case .toolTips:
               popupVC = sb.instantiateViewController(withIdentifier: ToolTipsViewController.className) as! ToolTipsViewController
            
        case .invocingNumber:
            popupVC = sb.instantiateViewController(withIdentifier: InvoicingNumberViewController.className) as! InvoicingNumberViewController
            
        case .exit:
            popupVC = sb.instantiateViewController(withIdentifier: ExitViewController.className) as! ExitViewController

        case .identifying:
            popupVC = sb.instantiateViewController(withIdentifier: IdentifyingStoreViewController.className) as! IdentifyingStoreViewController

        default:
            print("default")
            return
        }
        
        self.showPopupVC(popupVC: popupVC as! BasePopupViewController, withPopupInfoObj: popupInfoObj, andPopupViewControllerDelegate: popupViewControllerDelegate)
    }
    
    // Shows the popupVC's view inside a KLCPopup on the keyWindow
    func showPopupVC(popupVC :BasePopupViewController, withPopupInfoObj popupInfoObj: PopupInfoObj, andPopupViewControllerDelegate popupViewControllerDelegate: PopupViewControllerDelegate?) {
        
        var popupViewControllerDelegateA = popupViewControllerDelegate
        
        if popupViewControllerDelegate == nil {
            popupViewControllerDelegateA = self
        }
        
        popupVC.popupViewControllerDelegate = popupViewControllerDelegateA
        popupVC.popupInfoObj = popupInfoObj
        
        self.arrPopupVCs.append(popupVC)
        
        let layout = KLCPopupLayoutMake(.center, popupInfoObj.popupVerticalLayout)
        
        let kLCPopup = KLCPopup(contentView: popupVC.view, showType: popupInfoObj.popupShowType, dismissType: popupInfoObj.popupDismissType, maskType: .dimmed, dismissOnBackgroundTouch: popupInfoObj.dismissOnBackgroundTouch, dismissOnContentTouch: false)
        
        if let aKLCPopup = kLCPopup {
            
            weak var weakKLCPopup = aKLCPopup
            
            popupVC.kLCPopup = weakKLCPopup
            
            // Whenever a popup is removed from the keyWindow - remove the reference to it's VC from the array
            aKLCPopup.didFinishDismissingCompletion = {
                
                self.arrKLCPopups.removeObject(object: weakKLCPopup!)
                
            }
            self.arrKLCPopups.append(aKLCPopup)
            aKLCPopup.show(with: layout)
        }
        
    }
    
    func isAppShowingPopups() -> (Bool) {
        return self.arrKLCPopups.count > 0
    }
    
    // Convenience method for dismissing all KLCPopups at once
    func dismissAllPopups() {
        
        for kLCPopup in self.arrKLCPopups {
            kLCPopup.dismiss(true)
        }
        
        self.arrPopupVCs.removeAll()
        
    }
    
    override func reset() {
    }
    
}

//MARK: PopupViewControllerDelegate

extension PopupManager:PopupViewControllerDelegate {
    
    func closePopupVC(popupVC: BasePopupViewController) {
        
        popupVC.kLCPopup?.dismiss(true)
        
        self.arrPopupVCs.removeObject(object: popupVC)
        
    }
    
}






