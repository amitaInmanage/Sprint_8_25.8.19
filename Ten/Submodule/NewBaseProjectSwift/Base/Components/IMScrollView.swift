//
//  IMScrollView.swift
//  Mindspace
//
//  Created by Amir-inManage on 17/07/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit

protocol IMScrollViewDelegate: NSObjectProtocol {
    func didTapEndEditingScrollView()
}

class IMScrollView: UIScrollView {
    
    weak var imScrollViewdelegate: IMScrollViewDelegate?

    func initialize() {
        self.delaysContentTouches = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        
//        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapEndEditingScrollView))
//        self.addGestureRecognizer(secondTapGestureRecognizer)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func didTapEndEditingScrollView() {
        
        if let aDelegate = imScrollViewdelegate {
            aDelegate.didTapEndEditingScrollView()
        }
        
        self.endEditing(true)
        
    }
    
    
}
