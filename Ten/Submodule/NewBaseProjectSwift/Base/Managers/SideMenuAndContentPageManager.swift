//
//  SideMenuAndContentPageManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class SideMenuAndContentPageManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = SideMenuAndContentPageManager()
    
    var arrContentPages = [ContentPage]()
    var arrStaticMenuItems = [BaseMenuItem]()
    var arrMenuItems = [BaseMenuItem]()
    var arrNotLoggedInMenuItems = [Any]()
    var arrAllMenuItems = [Any]()
    
    
    func buildFullSideMenu() {
        if arrContentPages.count > 0 {
            for page in self.arrContentPages {
                self.arrAllMenuItems.append(page)
            }
        }
        
        ApplicationManager.sharedInstance.mainViewController.sideMenuTableViewController.refreshTable()

    }

    func addStaticMenuItems() {
        
        for index in SideMenuItemID.myCompany.rawValue ... SideMenuItemID.communityManager.rawValue {
            let menuItem : BaseMenuItem = BaseMenuItem()
            
            var strTitle = ""
            var strIconImageName = ""
            
            
            switch index {
            case SideMenuItemID.myCompany.rawValue:
                strTitle = "user"
                strIconImageName = "user"
                break
                
            case SideMenuItemID.location.rawValue:
                strTitle = "location"
                strIconImageName = "location"

                break
                
            case SideMenuItemID.refer.rawValue:
                strTitle = "refer_friend"
                strIconImageName = "refer_friend"

                break
                
            case SideMenuItemID.communityManager.rawValue:
                strTitle = "manager"
                strIconImageName = "manager"

                break
                //
            default:
                break;
            }
            
            menuItem.numID = index
            menuItem.strTitle = strTitle as String
            menuItem.strIconImageName = strIconImageName as String
            menuItem.isStaticMenuItem = true
            self.arrAllMenuItems.append(menuItem)
            
        }
        
    }
    
    // MARK: - AddOns
    
    // Gets a content page of a given numID
    func getContentPageWithNumID(numID: Int) -> (ContentPage?) {
        
        for contentPage in self.arrContentPages {
            
            if numID == contentPage.numID {
                return contentPage
            }
            
        }
        
        return nil
    }
    
    // Gets a menu item of a given numID
    func getMenuItemWithNumID(numID: Int) -> (BaseMenuItem?) {
        
        for menuItem in self.arrMenuItems {
            
            if menuItem.numID  == numID {
                return menuItem
            }
        }
        
        return nil
    }


    // MARK: - Requests
    
    func callGetContentPageWithDictParams(dictParams: [String:Any], andRequestFinishedDelegate requestFinishedDelegate: RequestFinishedProtocol?) {
        
       var delegate = requestFinishedDelegate
        
        if delegate == nil {
            delegate = self
        }
        
        let request = GetContentPageRequest().initWithDictParams(dictParams: dictParams, andRequestFinishDelegate: delegate)
        
        ApplicationManager.sharedInstance.requestManager.sendRequest(request: request, view: nil)
        
    }
    
    
    // MARK: - General
    func moveToWebContentWithContentPage(contetPage: ContentPage) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if let webContentViewController = sb.instantiateViewController(withIdentifier: WebViewController.className) as? WebViewController {
            if let content = contetPage.strHTMLContent {
                webContentViewController.content = ApplicationManager.sharedInstance.appGD.strWebViewFontStyle + content
            }
            webContentViewController.navBarTitle = contetPage.strTitle
            
            ApplicationManager.sharedInstance.navigationController.pushViewController(webContentViewController, animated: true)
        }
    }
    
    func createContentPageWithTitle(title: String, andUrl url: URL) {
        
        let contentPage = ContentPage()
        contentPage.strTitle = title
        contentPage.urlString = url
        
        self.moveToWebContentWithContentPage(contetPage: contentPage)
        
    }
    
    //MARK: ServerRequestDoneDelegate
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == ServerGeneralRequests.getContentPage {
            self.moveToWebContentWithContentPage(contetPage: (innerResponse as! GetContentPageResponse).contentPage)
        }
        
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        if request.requestName == ServerGeneralRequests.getContentPage {
            LogMsg("\(ServerGeneralRequests.getContentPage) Failed")
        }
    }
    
    override func reset() {
        SideMenuAndContentPageManager.sharedInstance = SideMenuAndContentPageManager()
        
    }
    
    func sortAllMenuItems() {
        if self.arrNotLoggedInMenuItems.isEmpty {
            if !self.arrAllMenuItems.isEmpty {
                if let data = arrAllMenuItems as? [BaseMenuItem] {
                    for menuItem in data {
                        if menuItem.displayOptions != DisplayOptions.userLogin {
                            self.arrNotLoggedInMenuItems.append(menuItem)
                        }
                    }
                }
            }
        }
    }
}
