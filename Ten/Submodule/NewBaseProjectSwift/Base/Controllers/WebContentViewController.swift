//
//  WebContentViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 21/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MBProgressHUD

class WebContentViewController: BaseViewController,UIWebViewDelegate {
    
    @IBOutlet weak var wbVwContent: IMWebView!
    @IBOutlet weak var lblTitle: BoldLabel!
    var contentPage: ContentPage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wbVwContent.delegate = self
        
        if let aContentPage = contentPage {
            
            if let aURLString = aContentPage.urlString {
                
                if !aURLString.absoluteString.isEmpty {
                    self.wbVwContent.loadRequest(URLRequest(url: aURLString))
                }
                
            } else if let aStrHtmlContent = aContentPage.strHTMLContent {
                
                if !aStrHtmlContent.isEmpty {
                    let strContent = "<style>body {margin:0px; padding:12px;}</style> \(aStrHtmlContent)"
                    
                    self.wbVwContent.loadHTMLString(strString: strContent, withBaseURL: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getGANTScreenName() -> (String) {
        return self.className
    }

    // MARK: - UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        LogMsg("webViewDidStartLoadWith requestUrlStr: \(String(describing: webView.request?.url?.absoluteString))")
        MBProgressHUD.hide(for: self.view, animated: true)
        MBProgressHUD.showAdded(to: self.view, animated: true)

        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        LogMsg("didFailLoadWithRequestUrlStr: \(String(describing: webView.request?.url?.absoluteString)) andWithError: \(error)")
        MBProgressHUD.hide(for: self.view, animated: true)

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        LogMsg("webViewDidFinishLoad requestUrlStr: \(String(describing: webView.request?.url?.absoluteString))")
        MBProgressHUD.hide(for: self.view, animated: true)

    }
    
    

}
