//
//  ErrorPopupViewController.swift
//  Mindspace
//
//  Created by inmanage on 29/06/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import SwiftyGif
import MessageUI

class ErrorPopupViewController: BasePopupViewController,TTTAttributedLabelDelegate,MFMailComposeViewControllerDelegate {
    
//    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubtTitle: RegularLabel!
    @IBOutlet weak var imgVwGif: UIImageView!
    @IBOutlet weak var lblContactUs: TTTAttributedLabel!
    
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - General
    func setupUI() {
        setupGIF()
        
        ApplicationManager.sharedInstance.stringManager.clickableStringWithColor(color: self.lblContactUs.textColor, fromString: self.lblContactUs.text! as! String, forLabel: self.lblContactUs, withDelegate: self, isUnderLine: false, font: UIFont(name: "ProximaNova-Semibold", size: 10), andPath: nil)
        
        if let aPopupInfo = self.popupInfoObj {
            if let aStrTitle = aPopupInfo.strTitle {
                self.lblSubtTitle.text = aStrTitle
            }
        }
        
    }
    
    func setupGIF() {
//        let messageImage = ApplicationManager.sharedInstance.appGD.dictImages[GifKeys.generalError]
//        
//        if let aMessageImage = messageImage {
//            let gifImage = UIImage.init(gifData: aMessageImage.imgData, levelOfIntegrity: 20)
//            let gifmanager = SwiftyGifManager(memoryLimit:20)
//            self.imgVwGif.setGifImage(gifImage, manager: gifmanager)
//            
//        }
        
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        
        if let aButtonAction = self.popupInfoObj?.secondButtonAction {
            aButtonAction()
        }
        
        if let delegate = self.popupViewControllerDelegate {
            delegate.closePopupVC!(popupVC: self)
        }
        
    }
    
    //MARK: TTTattributedLabelDeleagte
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString.count > 0 {
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            // composeVC.setToRecipients([ApplicationManager.sharedInstance.appGD.strContactEmail])
            //            composeVC.setSubject("Hello!")
            //            composeVC.setMessageBody("Hello this is my message body!", isHTML: false)
            
            // Present the view controller modally.
            ApplicationManager.sharedInstance.navigationController.present(composeVC, animated: true)
            
        }
    }
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
    
    
}
