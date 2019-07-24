//
//  ApplicationManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 06/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class ApplicationManager: BaseManager {
    
    var requestManager: RequestManager
    var generalRequestsManager: GeneralRequestsManager
    //
    //// ApplicationEventManagers
    var alertManager: AlertManager
    var errorManager: ErrorManager
    var localNotificationManager: LocalNotificationManager
    var locationManager: LocationManager
    var remoteNotificationAndDeepLinkManager: RemoteNotificationAndDeepLinkManager
    //
    //// CrashReportLoggingAndDebugManagers
    var crashAndReportsLogManager: CrashAndReportsLogManager
    var debugAndDevEnviromentManager: DebugAndDevEnviromentManager
    var gANTManager: GANTManager
    //
    //// ProcessManagers
    var facebookManager: FacebookManager
    var startupManager: StartupManager
    var userAccountManager: UserAccountManager
   
    //
    //// UtilityManagers
    var fileManager: FileIMManager
    var gUIManager: GUIManager
    var imageCacheManager: ImageCacheManager
    var inputValidationManager: InputValidationManager
    var openURLManager: OpenURLManager
    var popupManager: AppPopupManager
    var serverPopupMessageManager: ServerPopupMessageManager
    var shareManager: ShareManager
    var sideMenuAndContentPageManager: SideMenuAndContentPageManager
    var stringManager: StringManager
    var timeManager: TimeManager
    var translationManager: TranslationManager
    var tabsManager: TabBarManager
    var keychainManager: KeychainManager
    var loginAndSignupManager: LoginAndSignupManager

    //// Controllers
    var splashViewController: SplashViewController!
    var mainViewController: HomeViewController!
    var navigationController = MainNavigationController()
    var tabBarController = MainTabBarViewController()
    //
    
    //Ten Managers
    var appGeneralManager: AppGeneralManager
    var screensManager: ScreensManager
    
    
    //// General
    var appGD: AppGeneralDeclarationResponse
    //
    var arrFAQ: [Any]
    //
    var appShouldRestart: Bool
    //
    
    var restartAppBlockToExecute: (()->())?
    
    override init(){
        // init all properties
        
        requestManager                       = RequestManager.sharedInstance
        generalRequestsManager               = GeneralRequestsManager.sharedInstance
        
        // ApplicationEventManagers
        alertManager                         = AlertManager.sharedInstance
        errorManager                         = ErrorManager.sharedInstance
        localNotificationManager             = LocalNotificationManager.sharedInstance
        locationManager                      = LocationManager.sharedInstance
        remoteNotificationAndDeepLinkManager = RemoteNotificationAndDeepLinkManager.sharedInstance
        
        // CrashReportLoggingAndDebugManagers
        crashAndReportsLogManager            = CrashAndReportsLogManager.sharedInstance
        debugAndDevEnviromentManager         = DebugAndDevEnviromentManager.sharedInstance
        gANTManager                          = GANTManager.sharedInstance
        
        // ProcessManagers
        facebookManager                      = FacebookManager.sharedInstance
        startupManager                       = StartupManager.sharedInstance
        userAccountManager                   = UserAccountManager.sharedInstance
       self.loginAndSignupManager = LoginAndSignupManager.sharedInstance
        
        // UtilityManagers
        fileManager                          = FileIMManager.sharedInstance
        gUIManager                           = GUIManager.sharedInstance
        imageCacheManager                    = ImageCacheManager.sharedInstance
        inputValidationManager               = InputValidationManager.sharedInstance
        openURLManager                       = OpenURLManager.sharedInstance
        popupManager                         = AppPopupManager.sharedInstance
        serverPopupMessageManager            = ServerPopupMessageManager.sharedInstance
        shareManager                         = ShareManager.sharedInstance
        sideMenuAndContentPageManager        = SideMenuAndContentPageManager.sharedInstance
        stringManager                        = StringManager.sharedInstance
        timeManager                          = TimeManager.sharedInstance
        translationManager                   = TranslationManager.sharedInstance
        tabsManager                          = TabBarManager.sharedInstance
        keychainManager                      = KeychainManager.sharedInstance
    
        // General
        arrFAQ = []
        appShouldRestart = false
        appGD = AppGeneralDeclarationResponse()
        
        //Ten Managers
        appGeneralManager = AppGeneralManager.sharedInstance
        screensManager = ScreensManager.sharedInstance
        
        super.init()
        
    }
    
    static var sharedInstance = ApplicationManager()
    
    func didLanch() {
        if UserDefaults.standard.object(forKey: DiskKeys.firstRun) == nil {
            UserDefaults.standard.set(true, forKey: DiskKeys.firstRun)
            ApplicationManager.sharedInstance.keychainManager.removeKeychain()
        }
    }
    
    func restartAppWithBlockToExecute(blockToExecute:@escaping ()->()){
        
        // If app is showing alertViews, they will be dismissed and the ApplicationManager will get a callback (i.e. alertViewWasRemoved) in order to continue restarting app
        if self.alertManager.isAppShowingAlertViews() {

            self.restartAppBlockToExecute = blockToExecute
            self.appShouldRestart = true
            return

        }
        
        self.performRestartAppWithBlockToExecute(blockToExecute: blockToExecute)
        
    }
    
    func performRestartAppWithBlockToExecute(blockToExecute: @escaping ()->()) {
        
        // Removes any presented view controller (including UIAlertController) before restarting app
        if (self.navigationController.presentedViewController != nil) {
            
            self.navigationController.dismiss(animated: false, completion: { 
                self.resetAndRestartAppWithBlockToExecute(blockToExecute: blockToExecute)
            })
            
        } else {
            self.resetAndRestartAppWithBlockToExecute(blockToExecute: blockToExecute)
        }

    }
    
    func resetAndRestartAppWithBlockToExecute(blockToExecute : ()->()) {
        
        self.timeManager.refreshLastCallToServerTimestamp()
        
        self.reset()
        
        // After the above command (reset), properties needed to be initialized to a value will get that here
        blockToExecute()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let window = UIApplication.shared.keyWindow
        
        // Setting the rootViewController of the keyWindow should dealloc anything currently shown there (i.e popup...)
        if let aWindow = window {
            aWindow.rootViewController = sb.instantiateInitialViewController()
        }
        
    }
    
    override func reset() {
        
        for key in self.propertyNames() {
            
            LogMsg("\(key)")
            
            if let prop = self.value(forKey: key) as? BaseManager {
                
                if prop.responds(to: #selector(BaseManager.reset)) {
                    prop.reset()
                }
            }
        }
      
        ApplicationManager.sharedInstance = ApplicationManager()
        
    }
    
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
}





