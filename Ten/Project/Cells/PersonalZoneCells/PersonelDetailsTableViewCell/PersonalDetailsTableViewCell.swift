//
//  PeresonelDetailsTableViewCell.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var stckVw: UIStackView!
    @IBOutlet weak var vw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vw.addShadow()
    }

    func setUpData(didTapItem:DidTapItem ) {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        var horizontalStck = UIStackView()
        horizontalStck.axis = .horizontal
        horizontalStck.distribution = .fillEqually
        for (index,menu) in ApplicationManager.sharedInstance.userAccountManager.user.personelAreaMenuArr.enumerated() {
            if index % 3 == 0 {
            
                if index != 0 {
                 
                  stckVw.addArrangedSubview(horizontalStck)
                }
                
                horizontalStck = UIStackView()
                horizontalStck.distribution = .fillEqually
                self.addItemToStack(horizontalStck: horizontalStck, menu: menu, didTapItem: didTapItem)
                
            } else {
                self.addItemToStack(horizontalStck: horizontalStck, menu: menu, didTapItem: didTapItem)
            }
        }
        
        stckVw.addArrangedSubview(horizontalStck)
        horizontalStck.distribution = .fillEqually
        
    }
    
    func addItemToStack(horizontalStck: UIStackView, menu: PersonalAreaMenuItem, didTapItem: DidTapItem) {
        let personalDetailsCVW = PersonalDetailCustomView()
        personalDetailsCVW.didTapItem = didTapItem
        personalDetailsCVW.setDataWith(menuItem: menu)
        personalDetailsCVW.action = {
            if !ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(strFullDeeplink: menu.strDeepLink, dataObject: nil, animated: true, completionHandler: nil) {
                ApplicationManager.sharedInstance.openURLManager.openSFSafari(strLink: menu.strDeepLink)
            }
        }
        horizontalStck.addArrangedSubview(personalDetailsCVW)
    }
}
