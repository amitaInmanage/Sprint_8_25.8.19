//
//  ScreensManager.swift
//  Ten
//
//  Created by Shani on 26/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class ScreensManager: BaseManager {

    static var sharedInstance = ScreensManager()
    
    override init(){
        // init all properties
        super.init()
        
    }
    
    //MARK: General

//    func moveToNextScreen() {
//        
//        if let nextScreen = ApplicationManager.sharedInstance.userAccountManager.arrScreens.first {
//            
//            switch nextScreen.screenName {
//            case ScreensNames.personalInformation.rawValue:
//                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: PersonalInformationViewController.className) as? PersonalInformationViewController {
//                    ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//                }
//            case ScreensNames.customerType.rawValue:
//                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CustomerTypeViewController.className) as? CustomerTypeViewController {
//                    ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//                }
//            case ScreensNames.carInformationClub.rawValue:
//                print("carInformationClub")
//            case ScreensNames.carInformationPrivate.rawValue:
//                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: FuelingCardViewController.className) as? FuelingCardViewController {
//                    ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//                }
//            case ScreensNames.carInformationDalkan.rawValue:
//                print("carInformationDalkan")
//            case ScreensNames.creditCard.rawValue:
//                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CreditCardViewController.className) as? CreditCardViewController {
//                    vc.strUrl = nextScreen.strUrl
//                    ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//                }
//            case ScreensNames.fuelingCardPrivate.rawValue:
//                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CarInformationFcPrivateViewController.className) as? CarInformationFcPrivateViewController {
//                    ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//                }
//            case ScreensNames.fuelingCardBusiness.rawValue:
//                if let vc = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: CarInformationFcBusinessViewController.className) as? CarInformationFcPrivateViewController {
//                    ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//                }
//            case ScreensNames.extraSecurity.rawValue:
//                print("extraSecurity")
//            case ScreensNames.pinCode.rawValue:
//                print("pinCode")
//            default:
//                print("none")
//            }
//            
//            ApplicationManager.sharedInstance.userAccountManager.arrScreens.removeFirst()
//        } else {
//            ApplicationManager.sharedInstance.userAccountManager.moveToHomePage()
//        }
//    }
    
    //MARK: reset
    
    override func reset() {
        ScreensManager.sharedInstance = ScreensManager()
    }
    
}
