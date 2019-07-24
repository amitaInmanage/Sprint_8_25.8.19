//
//  CustomBackDelegate.swift
//  WelcomeInSwift
//
//  Created by inmanage on 02/04/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

@objc protocol CustomBackDelegate: NSObjectProtocol {
    //func didTapBack(sender: UIButton)
    func didTapBack(sender: UIBarButtonItem)
}
