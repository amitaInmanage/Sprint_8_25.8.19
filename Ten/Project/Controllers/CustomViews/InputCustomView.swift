//
//  InputCustomView.swift
//  Ten
//
//  Created by shani daniel on 04/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.


import UIKit
import MaterialComponents.MaterialTextFields

@objc protocol InputCustomViewProtocol : NSObjectProtocol {
    
    @objc optional func didTapBtnTrailing(sender: UIButton)
}

/*@IBDesignable*/ class InputCustomView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var txtFldInput: MDCTextField!
    
    weak var inputCustomViewProtocolDelegate : InputCustomViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    func initNib() {
        let bundle = Bundle(for: InputCustomView.self)
        bundle.loadNibNamed(InputCustomView.className, owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.txtFldInput.semanticContentAttribute = .forceRightToLeft
        self.txtFldInput.leadingUnderlineLabel.semanticContentAttribute = .forceRightToLeft
        
        self.txtFldInput.clearButtonMode = .never
    }
    
    func addTrailingView(delegate: InputCustomViewProtocol?, strImage: String = "invalidName") {
        let btnTrailing = UIButton(type: .custom)   
        btnTrailing.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        btnTrailing.setImage(UIImage(named: strImage), for: .normal)
        btnTrailing.addTarget(self, action: #selector(didTapBtnTrailing(_:)), for: .touchUpInside)
        self.txtFldInput.trailingView = btnTrailing
        self.txtFldInput.trailingViewMode = .always
        
        self.inputCustomViewProtocolDelegate = delegate
    }
    
    @objc func didTapBtnTrailing(_ sender: UIButton) {
        
        if let delegate = self.inputCustomViewProtocolDelegate {
            if delegate.responds(to: #selector(BaseFormViewController.didTapBtnTrailing(sender:))) {
                delegate.didTapBtnTrailing!(sender: sender)
            }
        }
    }
    
}


