//
//  ProcessFinishedProtocol.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 23/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation
enum ProcessFinishedStatus{
    case ProcessFinishedStatusSuccess
    case ProcessFinishedStatusFailure
}

typealias ProcessCompletion = (BaseProcessManager,ProcessFinishedStatus) -> ()

protocol ProcessFinishedProtocol{
    
    func processFinished(processManager:BaseProcessManager, processFinishedStatus:ProcessFinishedStatus, processCompletion:ProcessCompletion)
}
