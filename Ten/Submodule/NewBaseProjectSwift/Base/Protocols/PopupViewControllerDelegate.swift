//
//  PopupViewControllerDelegate.swift
//  WelcomeInSwift
//
//  Created by inmanage on 12/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

@objc protocol PopupViewControllerDelegate : NSObjectProtocol {
    
    @objc optional func closePopupVC(popupVC: BasePopupViewController)
    
}
