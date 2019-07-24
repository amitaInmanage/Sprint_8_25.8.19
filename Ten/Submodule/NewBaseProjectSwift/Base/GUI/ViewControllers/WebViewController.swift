//
//  WebViewController.swift
//  Maccabi_Haifa
//
//  Created by shani daniel on 01/10/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var webVw: IMWebView!
    @IBOutlet weak var imgHaifa: UIImageView!
    
    @IBOutlet weak var lblHaifa: RegularLabel!
    
    var imageName = ""
    var emptyContentTitle = ""
    
    var content = ""
    var navBarTitle = ""
    var shareObj = ShareObj()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupWebVw()
        self.updateWebVw(content: content)

     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if !navBarTitle.isEmpty {
            ApplicationManager.sharedInstance.mainViewController.setNavbarTitle(strTitle: navBarTitle)

        }
        
        if !self.imageName.isEmpty && !self.emptyContentTitle.isEmpty {
            self.imgHaifa.image = UIImage(named: self.imageName)
            self.lblHaifa.text = self.emptyContentTitle
        } else {
            self.imgHaifa.isHidden = true
            self.lblHaifa.isHidden = true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupWebVw() {
        
        self.webVw.delegate = self
        self.webVw.scrollView.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.webVw.scrollView.subviews[0].transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    func updateWebVw(content: String) {
        
        self.webVw.loadHTMLString(strString: content, withBaseURL: nil)
    }

    //MARK: UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == .linkClicked {
            let desc = request.description
            if desc.contains("share=1") {
                if !shareObj.title.isEmpty || !shareObj.link.isEmpty {
                    
                    ApplicationManager.sharedInstance.shareManager.showActivityShareWithItemsToShare(arr: [shareObj.title, shareObj.link], andActivityCompletionHandler: nil, subjectTitle: "");
                    
                    return false;
                }
            } else {
                if !ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(strFullDeeplink: desc, dataObject: nil, animated: true, completionHandler: nil) {
                    ApplicationManager.sharedInstance.openURLManager.openSFSafari(strLink: desc)
                }
            }
            
        }
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

    }

}

