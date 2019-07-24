//
//  FaceIdTableViewCell.swift
//  Ten
//
//  Created by Amit on 21/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//


import UIKit
import LocalAuthentication

class FaceIdTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblRemoveFaceId: UILabel!
    @IBOutlet weak var lblFaceId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
        
    }
    
    fileprivate func initUI() {
        self.vwContent.addShadow()
    }
    
    //IBAction:
    @IBAction func didTapCreateFaceId(_ sender: Any) {
        let context = LAContext()
        let reason = "We need this to protect your payments." // add your own message explaining why you need this authentication method
        
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    // User authenticated successfully
                } else {
                    // User did not authenticate successfully
                }
            }
        } else {
            // Handle Error
        }
    }
    @IBAction func ddiTapRemoveFaceId(_ sender: Any) {
        
    }
}
