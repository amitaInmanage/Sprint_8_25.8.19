//
//  UsageDataGraphCollectionViewCell.swift
//  Ten
//
//  Created by Amit on 20/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class UsageDataGraphCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblNis: SmallText!
    @IBOutlet weak var lblMonth: SmallText!
    @IBOutlet weak var lblYear: SmallText!
    @IBOutlet weak var graphHeightConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.graphHeightConstraint.constant = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.graphHeightConstraint.constant = 0
    }
}
