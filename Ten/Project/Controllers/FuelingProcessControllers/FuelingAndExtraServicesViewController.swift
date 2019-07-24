//
//  FuelingAndExtraServicesViewController.swift
//  Ten
//
//  Created by shani daniel on 25/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

class FuelingAndExtraServicesViewController: UIViewController {
 
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: RegularLabel!
    @IBOutlet weak var lblTimer: MediumLabel!
    @IBOutlet weak var btnCancel: MediumButton!
    @IBOutlet weak var lblExtraServicesTitle: LightLabel!
    @IBOutlet weak var btnCallTheRefueler: TenButtonStyle!
    @IBOutlet weak var extraServicesStack: UIStackView!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblLiter: UILabel!
    @IBOutlet weak var lblTextLiter: RegularLabel!
    @IBOutlet weak var lblTextMoney: RegularLabel!
    @IBOutlet weak var extraServicesScrollView: UIScrollView!
    
    let extraServicesArr = ["בדיקת שמן מים","מילוי אוויר","בדיקת מגבים"] // TODO: temp need to get from server
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupUI()
        self.fillTextWithTrans()
    }
    
    // MARK: - Set up UI
    
    func setupUI() {

        self.extraServicesViewsInit()
        let strButtonTitle = Translation(FuelingAndExtraServicesVCTranslations.btnCancel, FuelingAndExtraServicesVCTranslations.btnCancelDefault)//"{בטל}"
        let font = UIFont.getBtnFontWithFontName(fontClass: MediumButton(), fontSize: 14)
        self.btnCancel.setAttributedTitle(ApplicationManager.sharedInstance.stringManager.getAttributeStringWithUnderlineWithRange(string: strButtonTitle, font: font), for: .normal)
        
        var originalString = "₪<0>" //TODO: temp, need to get from server
        
        if ApplicationManager.sharedInstance.stringManager.splitString(originalString: originalString).count > 1 {
            
            let firstStr = ApplicationManager.sharedInstance.stringManager.splitString(originalString: originalString)[0]
            let secondStr = ApplicationManager.sharedInstance.stringManager.splitString(originalString: originalString)[1]
            
            let firstFont =  UIFont(name: RegularLabel.getFontName(), size: 15)
            let secondFont = UIFont(name: MediumLabel.getFontName(), size: 30)
            
            self.lblMoney.attributedText = ApplicationManager.sharedInstance.stringManager.setAttributedStringWithTwoFonts(firstStr: firstStr, firstFont: firstFont!, secondStr: secondStr, secondFont: secondFont!)
            
        } else {
            self.lblMoney.text = originalString
        }
    }
    
    // MARK: - Fill text with translation
    
    func fillTextWithTrans() {
        
        self.lblTitle.text = Translation(FuelingAndExtraServicesVCTranslations.lblTitle, FuelingAndExtraServicesVCTranslations.lblTitleDefault)
        self.lblSubTitle.text = Translation(FuelingAndExtraServicesVCTranslations.lblSubTitle, FuelingAndExtraServicesVCTranslations.lblSubTitleDefault)
        self.lblExtraServicesTitle.text = Translation(FuelingAndExtraServicesVCTranslations.lblExtraServicesTitle, FuelingAndExtraServicesVCTranslations.lblExtraServicesTitle)
        self.btnCallTheRefueler.setTitle( Translation(FuelingAndExtraServicesVCTranslations.btnCallTheRefueler, FuelingAndExtraServicesVCTranslations.btnCallTheRefuelerDefault), for: .normal)
        self.lblTextMoney.text = Translation(FuelingAndExtraServicesVCTranslations.lblTextMoney, FuelingAndExtraServicesVCTranslations.lblTextMoneyDefault)
        self.lblTextLiter.text = Translation(FuelingAndExtraServicesVCTranslations.lblTextLiter, FuelingAndExtraServicesVCTranslations.lblTextLiterDefault)
    }
    
    // MARK: - Init Extra Services Views
    
    func extraServicesViewsInit() {
       
        for view in self.extraServicesStack.subviews {
            view.removeFromSuperview()
        }
        
        for index in 0..<self.extraServicesArr.count{
            print("index = \(index)")
            let serviceView = ExtraServiceCustomView()
            let currentService = self.extraServicesArr[index]
            serviceView.tag = index
            let serviceName = currentService //TODO: currentService.name
            serviceView.lblServiceName.text = serviceName
            let subviewsCount = self.extraServicesArr.count
            let maxViewsWithoutScrollFromServer = ApplicationManager.sharedInstance.appGD.maxViewsWithoutScroll
            self.extraServicesStack.reSizeSubViews(subView: serviceView, subViewsCount: subviewsCount, maxViewsWithoutScroll: maxViewsWithoutScrollFromServer, scrollView: self.extraServicesScrollView)
            serviceView.imgService.image = UIImage(named:"oil")
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            serviceView.addGestureRecognizer(tap)
            serviceView.isUserInteractionEnabled = true
            self.extraServicesStack.addArrangedSubview(serviceView)
        }
  
        //self.extraServicesStack.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
   
    // MARK: - Did tap func
    
    @IBAction func didTapCancel(_ sender: UIButton) {
      
    }
    
    // MARK: - Did tap call the refueler
    
    @IBAction func didTapCallTheRefueler(_ sender: UIButton) {
        
    }
    
    // MARK: - Handle service view tap
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        print("handleTap")
        
    }
}
















