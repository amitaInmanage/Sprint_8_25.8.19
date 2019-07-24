//
//  TenStyleViewController.swift
//  Ten
//
//  Created by aviv-inmanage on 26/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol ActionBottomBtnDelegate {
    func didTapBottomBtn()
}

class TenStyleViewController: BaseViewController {
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var vwBlueLine: UIView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerHeightConst: NSLayoutConstraint!
    
    var vcHeight: CGFloat?
    var boxChild = Box<UIViewController>(UIViewController())
    var shouldShowBottomBtn = Box<Bool>(false)
    var delegate: ActionBottomBtnDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeBindings()
    
        self.view.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.colorWithRGBAlpha(r: 238, g: 240, b: 243, a: 1)
        self.vwBlueLine.backgroundColor = UIColor.getApplicationThemeColor()
//        self.vwContent?.addShadow()
        self.containerView?.addShadow()
        self.vwContent?.layer.cornerRadius = 2.0
        self.vwContent?.clipsToBounds = true
    }
    

    fileprivate func initializeBindings() {
        
        self.bottomBtn.setTitle(Translation(Translations.Titles.confirm, Translations.Titles.confirmDefault), for: .normal)
        self.bottomBtn.backgroundColor = UIColor.getApplicationThemeColor()
        self.bottomBtn.layer.cornerRadius = 8
        if #available(iOS 11.0, *) {
            bottomBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            print("iOS Device < 11.0")
        }
        boxChild.bind { [unowned self] (newVal) in
            //AutoResizing contraints
            newVal.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            newVal.view.frame = self.vwContent.bounds
            
            self.vwContent.addSubview(newVal.view)
            newVal.didMove(toParentViewController: self)
        }
        
        self.shouldShowBottomBtn.bind { [unowned self] (newVal) in
            self.bottomBtn.isHidden = !newVal
        }
    }
    func changeConstraint(trailingConstraint: CGFloat, bottomConstraint: CGFloat, leadingConstraint: CGFloat, containerHeightConst: CGFloat) {
        
        self.trailingConstraint.constant = trailingConstraint
        self.bottomConstraint.constant = bottomConstraint
        self.leadingConstraint.constant = leadingConstraint
        self.containerHeightConst.constant = containerHeightConst
    }
    
    func changeSize(height: CGFloat?) {
        self.vcHeight = height
    }

    @IBAction func didTapBottomBtn(_ sender: Any) {
        if self.delegate != nil {
            self.delegate?.didTapBottomBtn()
        }
    }
}


