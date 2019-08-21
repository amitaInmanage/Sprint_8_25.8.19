//
//  ViewController.swift
//  NewBaseProjectSwift
//
//  Created by Shani on 25/04/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit
import LocalAuthentication

class OnBoardingViewController: BaseViewController {
    
    var slidItem = [SlidItem]()
    
    @IBOutlet weak var topVw: UIView!
    @IBOutlet weak var btnSkip: IMButton!
    @IBOutlet weak var lblTitle: SmallText!
    @IBOutlet weak var btnSignUp: IMButton!
    @IBOutlet weak var lblSubTitle: MediumText!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true

//        ApplicationManager.sharedInstance.appGeneralManager.alertViewController.dismiss(animated: false) {
//            UIApplication.shared.keyWindow?.rootViewController?.present(ApplicationManager.sharedInstance.appGeneralManager.alertViewController, animated: false, completion: nil)

       // }

        //ApplicationManager.sharedInstance.serverPopupMessageManager.showPopupIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupLogo(enable: false)
        self.setupMenu()
    }
    
    fileprivate func initUI() {
        self.btnSkip.titleLabel?.textColor = UIColor.getApplicationTextColor()
         self.btnSkip.titleLabel?.font = UIFont(name: "Heebo-Regular", size: 18)
        self.btnSignUp.titleLabel?.font = UIFont(name: "Heebo-Regular", size: 18)
        self.topVw.backgroundColor = UIColor.getHighlightedCellColor()
        self.btnSignUp.backgroundColor = UIColor.getHighlightedCellColor()
        self.btnSignUp.tintColor = .white
        self.btnSignUp.setTitle(Translation(Translations.AlertButtonsKeys.onboardingRegister, Translations.AlertButtonsKeys.onboardingRegisterDefault), for: .normal)
        self.btnSkip.tintColor = UIColor.getHighlightedCellColor()
        self.btnSkip.setupWithBorderColor(borderColor: UIColor.getHighlightedCellColor(), andBorderWidth: 2, addCornerRadius: false)
        self.btnSkip.setTitle(Translation(Translations.AlertButtonsKeys.onboardingSkip, Translations.AlertButtonsKeys.onboardingSkipDefault), for: .normal)
        self.lblTitle.textColor = .white
        self.lblSubTitle.textColor = .white
    }
    
    //IBAction:
    @IBAction func didTapSignUpBtn(_ sender: Any) {
        if let SignUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: SignUpWithPhoneNumberViewController.className) as? SignUpWithPhoneNumberViewController {
            ApplicationManager.sharedInstance.navigationController.pushTenViewController(SignUpVC, animated: true)
        }
    }
    
    @IBAction func didTapSkipBtn(_ sender: Any) {
        
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.isHidden = !(slidItem.count > 1)
        pageControl.numberOfPages = slidItem.count
        return slidItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBordingCell", for: indexPath) as! OnBordingCell
        
        cell.slideImage.setImageWithStrURL(strURL: self.slidItem[indexPath.row].strImage, withAddUnderscoreIphone: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
        
        if self.slidItem[indexPath.row].titlePosition == "top" {
            self.lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 18)
            self.lblTitle.text = slidItem[indexPath.row].strTitle
            self.lblSubTitle.font = UIFont(name: lblSubTitle.font.fontName, size: 14)
            self.lblSubTitle.text = slidItem[indexPath.row].strContent
        } else {
            self.lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 14)
            self.lblTitle.text = slidItem[indexPath.row].strContent
            self.lblSubTitle.font = UIFont(name: lblSubTitle.font.fontName, size: 18)
            self.lblSubTitle.text = slidItem[indexPath.row].strTitle
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.frame.size
    }
}

//extension OnBoardingViewController {
//    private func fontSize(font: UIFont(name: String, size: 18)) {
//         self = UIFont(name: lblTitle.font.fontName, size: 18)
//    }
//}
