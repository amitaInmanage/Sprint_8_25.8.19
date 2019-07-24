//
//  LocalNotificationManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

private let NotificationCategoryIdent   = "NotificationCategoryIdent"
private let NotificationActionOneIdent  = "ACTION_ONE"
private let NotificationActionTwoIdent  = "ACTION_TWO"

class LocalNotificationManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = LocalNotificationManager()
    
    
    // MARK: - Local Notif Creation
    
    // Creates a standard local notification
    func createLocalNotificationWithTitle(title: String, andActionTitle actionTitle: String, andUserInfo userInfo: [String:Any], andFireDate fireDate: Date, andShouldSchedule shouldSchedule: Bool) -> (UILocalNotification) {
        
        let localNotif = UILocalNotification()
        
        localNotif.alertBody = title
        localNotif.alertAction = actionTitle
        localNotif.userInfo = userInfo
        localNotif.fireDate = fireDate
        localNotif.soundName = UILocalNotificationDefaultSoundName
        localNotif.applicationIconBadgeNumber = 1
        
        if shouldSchedule {
            UIApplication.shared.scheduledLocalNotifications?.append(localNotif)
        }
        
        return localNotif
    }
    
    // Creates an actionable local notification (i.e pulldown on the the received local notif shows actions/buttons)
    func createActionableLocalNotificationWithTitle(title: String, andActionTitle actionTitle: String, andUserInfo userInfo: [String:Any], andFireDate fireDate: Date, andUserNotificationActionOneTitle userNotificationActionOneTitle: String, andUserNotificationActionTwoTitle userNotificationActionTwoTitle: String, andShouldSchedule shouldSchedule: Bool) -> (UILocalNotification?) {
        
        var userNotificationActionOne = UIMutableUserNotificationAction()
        var userNotificationActionTwo = UIMutableUserNotificationAction()
        
        if !userNotificationActionOneTitle.isEmpty {
            
            userNotificationActionOne = self.createUserNotificationActionWithTitle(title: userNotificationActionOneTitle, andIdentifier: NotificationActionOneIdent)
            
            if !userNotificationActionTwoTitle.isEmpty {
                
                userNotificationActionTwo = self.createUserNotificationActionWithTitle(title: userNotificationActionTwoTitle, andIdentifier: NotificationActionTwoIdent)
                
            }
            
            let userNotificationCategory = UIMutableUserNotificationCategory()
            userNotificationCategory.identifier = NotificationCategoryIdent
            
            var actions = [UIMutableUserNotificationAction]()
            
            if !userNotificationActionTwoTitle.isEmpty {
                actions = [userNotificationActionOne,userNotificationActionTwo]
            } else {
                actions = [userNotificationActionOne]
            }
            
            userNotificationCategory.setActions(actions, for: .default)
            
            let categories = NSSet(object: userNotificationCategory)
            
            let settings = UIUserNotificationSettings(types: [.alert,.sound,.badge], categories: categories as? Set<UIUserNotificationCategory>)
            
            UIApplication.shared.registerUserNotificationSettings(settings)
            
            let localNotif = self.createLocalNotificationWithTitle(title: title, andActionTitle: actionTitle, andUserInfo: userInfo, andFireDate: fireDate, andShouldSchedule: false)
            
            // Same as userNotificationCategory identifier
            localNotif.category = NotificationCategoryIdent
            
            if shouldSchedule {
                UIApplication.shared.scheduledLocalNotifications?.append(localNotif)
            }

            return localNotif
            
        }
        
        return nil
        
    }
    
    
    func createUserNotificationActionWithTitle(title: String, andIdentifier identifier: String) -> (UIMutableUserNotificationAction) {
        
        let userNotificationAction = UIMutableUserNotificationAction()
        
        userNotificationAction.activationMode = .background
        userNotificationAction.title = title
        userNotificationAction.identifier = identifier
        userNotificationAction.isDestructive = false
        userNotificationAction.isAuthenticationRequired = false
        
        return userNotificationAction
        
    }
    
    override func reset() {
        LocalNotificationManager.sharedInstance = LocalNotificationManager()
    }
    
    
}
