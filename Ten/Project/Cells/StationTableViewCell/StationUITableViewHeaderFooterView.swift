//
//  StationUITableViewHeaderFooterView.swift
//  Ten
//
//  Created by shani daniel on 10/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class StationUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblHeaderTitle: RegularLabel!
    @IBOutlet weak var btnCancel: UIButton!
    
    var cancelDelegate: cancelPopupDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        
        if let delegate = self.cancelDelegate {
            
            delegate.didTapCancel()
        }
    }
    
}





