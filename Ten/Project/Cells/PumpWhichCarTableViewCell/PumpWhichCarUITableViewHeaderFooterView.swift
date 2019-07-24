//
//  PumpWhichCarUITableViewHeaderFooterView.swift
//  Ten
//
//  Created by shani daniel on 18/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

protocol cancelPopupDelegate {
    
    func didTapCancel()
}

class PumpWhichCarUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblHeaderTitle: RegularLabel!
    
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
