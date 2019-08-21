//
//  IMText.swift
//  Ten
//
//  Created by Amit on 21/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class IMText: UILabel {
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    func initialize() {
        self.minimumScaleFactor = 0.5
        self.textColor = UIColor.getApplicationIMLabelColor()
    }
}


class RegularText: IMText {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Regular", size: 16)
    }
}

class MediumText : IMText {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Regular", size: 18)
    }
}

class BoldText : IMText {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Bold", size: 16)
    }
}

class SmallTextBold : IMText {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Bold", size: 14)
    }
}

class SmallText : IMText {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Regular", size: 14)
    }
}

class SemiBoldText : IMText {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Medium", size: 16)
    }
}


class ErrorText: IMLabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont.init(name: "Heebo-Regular", size: 16)
        self.textColor = UIColor.getApllicationErrorColor()
    }
}
