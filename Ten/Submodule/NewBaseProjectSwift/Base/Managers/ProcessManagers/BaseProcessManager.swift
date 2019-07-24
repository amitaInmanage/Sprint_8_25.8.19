//
//  BaseProcessManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class BaseProcessManager: BaseManager {
    
    override init() {
        super.init()
    }
    
    var processType: ProcessType!
    var processObj: BaseProcessObj?
    var processFinishedDelegate: ProcessFinishedProtocol?
    var processCompletion: ProcessCompletion?
    
    
    func startProcess(processType: ProcessType, processObj:BaseProcessObj?, processFinishedDelegate: ProcessFinishedProtocol?, processCompletion:@escaping ProcessCompletion ){
        self.processType = processType
        self.processObj = processObj
        self.processFinishedDelegate = processFinishedDelegate
        self.processCompletion = processCompletion
        
    }
    
    
    func finishProcessWithStatus(processFinishedStatus:ProcessFinishedStatus){
        
        if ApplicationManager.sharedInstance.mainViewController != nil {
        
            let sidemenuVC = ApplicationManager.sharedInstance.mainViewController.sideMenuTableViewController
            sidemenuVC.refreshTable()
        }
        
        if self.processCompletion != nil {
            self.processCompletion!(self,processFinishedStatus)
            
        } else if(self.processFinishedDelegate != nil) {
            
            self.processFinishedDelegate?.processFinished(processManager: self, processFinishedStatus: processFinishedStatus, processCompletion: self.processCompletion!)
            
        }
    }
    
}
