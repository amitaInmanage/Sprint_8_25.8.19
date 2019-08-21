//
//  StorePaymentTableViewCell.swift
//  Ten
//
//  Created by Amit on 28/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol RemoveStorePaymentDelegate: NSObject {
    func didTapRemoveStorePayment()
}

class StorePaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCardType: UIImageView!
    @IBOutlet weak var lblCardNumber: RegularText!
    @IBOutlet weak var vwBetween: UIView!
    @IBOutlet weak var lblRemove: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnRemoveStorePayment: UIButton!
    
    weak var delegate: RemoveStorePaymentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func didTapRemoveStorePayment(_ sender: Any) {
        if let delegate = delegate {
            delegate.didTapRemoveStorePayment()
        }
    }
}
