//
//  ServerPopupMessageManager.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 24/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ServerPopupMessageManager: BaseManager {
    
    static var sharedInstance = ServerPopupMessageManager()
    
    static let keyServerPopupMsgs = "keyServerPopupMsgs"
    
    var arrPopupMessages = [PopupMessage]()
    private var popupTimer : Timer?
    
    func addPopupMessages(arrPopupMessages: [PopupMessage]!) {
        
        if !arrPopupMessages.isEmpty {
            self.arrPopupMessages += arrPopupMessages
        }
        
        showPopupIfNeeded()
    }
    
    func showPopupIfNeeded() {
        if isAllowShowingPopup() {
            startNextPopupTimer()
        }
    }
    
    func isAllowShowingPopup() -> Bool{
        if !ApplicationManager.sharedInstance.navigationController.viewControllers.isEmpty && !arrPopupMessages.isEmpty {
            return true
        }
        return false
    }
    
    func startNextPopupTimer() {
        
        if self.popupTimer == nil && !self.arrPopupMessages.isEmpty{
            self.popupTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(showPopupMessage), userInfo: nil, repeats: false)
        }
    }
    
    @objc func showPopupMessage() {
        
        if isAllowShowingPopup() && isPopupValid(popupMessage: self.arrPopupMessages.first) {
            createNewPopupMessage(popupMessage: self.arrPopupMessages.first)
            self.arrPopupMessages.remove(at: 0)
            stopPopupTimer()
        }
    }
    
    func createNewPopupMessage(popupMessage: PopupMessage!) {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.popupType = .general
        
        popupInfoObj.strTitle = popupMessage.strTitle
        popupInfoObj.strSubtitle = popupMessage.strSubtitle
        popupInfoObj.strDescription = popupMessage.strContent
        popupInfoObj.strImageURL = popupMessage.strImg
        
        for i in 0..<popupMessage.arrButtons.count {
            
            if i == 0 {
                let firstBtn = popupMessage.arrButtons[0]
                popupInfoObj.strFirstButtonTitle = firstBtn.strTitle
                
                popupInfoObj.firstButtonAction = {
                    self.btnClicked(strDeeplink: firstBtn.strDeeplink)
                }
                
            } else if i == 1 {
                let secondBtn = popupMessage.arrButtons[1]
                popupInfoObj.strSecondButtonTitle = secondBtn.strTitle
                
                popupInfoObj.secondButtonAction = {
                    self.btnClicked(strDeeplink: secondBtn.strDeeplink)
                }
            }
        }
        
        popupInfoObj.closeButtonAction = {
            self.btnClicked(strDeeplink: nil)
        }
        
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        
        savePopupMessageKeyToDisk(strKey: popupMessage.strKey)
    }
    
    func isPopupValid(popupMessage: PopupMessage!) -> Bool {
        
        if let dictMsgKeys = ApplicationManager.sharedInstance.keychainManager.retrieveDictFromKeychain(key: ServerPopupMessageManager.keyServerPopupMsgs) {
            if dictMsgKeys[popupMessage.strKey] != nil {
                self.arrPopupMessages.removeObject(object: popupMessage)
                stopPopupTimer()
                startNextPopupTimer()
                return false
            }
        }
        return true
    }
    
    func savePopupMessageKeyToDisk(strKey: String) {
        var dictMsgKeys = [String: String]()
        
        if let tempDictMsgKeys = ApplicationManager.sharedInstance.keychainManager.retrieveDictFromKeychain(key: ServerPopupMessageManager.keyServerPopupMsgs) {
            dictMsgKeys = tempDictMsgKeys
        } else {
            dictMsgKeys = [String: String]()
        }
        
        dictMsgKeys[strKey] = "-1"
        
        ApplicationManager.sharedInstance.keychainManager.saveDictToKeychain(dictMsgKeys, forKey: ServerPopupMessageManager.keyServerPopupMsgs)
    }
    
    func stopPopupTimer() {
        self.popupTimer?.invalidate()
        self.popupTimer = nil
    }
    
    func btnClicked(strDeeplink: String?) {
        
        if let aStrDeeplink = strDeeplink {
            
            ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(strFullDeeplink: aStrDeeplink, dataObject: nil, animated: false, completionHandler: {
                
            })
        }
        
        stopPopupTimer()
        startNextPopupTimer()
    }
    
    override func reset() {
        ServerPopupMessageManager.sharedInstance = ServerPopupMessageManager()
    }
}
