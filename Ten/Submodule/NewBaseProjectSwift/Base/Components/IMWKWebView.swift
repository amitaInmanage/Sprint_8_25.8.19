//
//  IMWKWebView.swift
//  Maccabi_Haifa
//
//  Created by Aviv Frenkel on 09/11/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD
import SafariServices

class IMWKWebView: UIView, WKNavigationDelegate {

    var wkWebView = WKWebView()
    
    func initialize() {
        self.wkWebView.scrollView.alwaysBounceVertical = false
        self.wkWebView.navigationDelegate = self
        self.wkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.wkWebView)
        
        NSLayoutConstraint(item: wkWebView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: wkWebView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: wkWebView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: wkWebView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1.0, constant: 0).isActive = true
        
        self.layoutIfNeeded()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    //MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        MBProgressHUD.hide(for: self, animated: true)
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func loadRequestWithStrUrl(strUrl : String) {
        let url = URL(string: strUrl)
        guard let notNullUrl = url else {
            debugPrint("strUrl : \(strUrl) isn't an url, pls check its credibility ")
            return
        }
        let urlRequest = URLRequest.init(url: notNullUrl)
        
        self.wkWebView.load(urlRequest)
    }
    
    func loadRequestWithStrHtml(strHtml : String) {
        let fontStyle =  ApplicationManager.sharedInstance.appGD.strWebViewFontStyle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.wkWebView.loadHTMLString(fontStyle + strHtml, baseURL: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if (url?.scheme?.contains("tel"))! {
            ApplicationManager.sharedInstance.openURLManager.openTelPrompt(strPhoneNumber: (url?.absoluteString)!)
            decisionHandler(.cancel)
        } else if (url?.scheme?.contains("http"))! {
            
            let sfVC = SFSafariViewController(url: url!)
            let navigation = ApplicationManager.sharedInstance.navigationController
            
        
        }
    }
  
}
