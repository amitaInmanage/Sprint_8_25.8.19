//
//  SideMenuTableViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 13/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

private enum SideMenuCellHeight: CGFloat {
    case profile = 98, general = 55
}

class SideMenuTableViewController: UITableViewController,RequestFinishedProtocol,ProcessFinishedProtocol, SideMenuProfileTableViewCellDelegate{
    

    var header: SideMenuHeader? = nil
    var footer: SideMenuFooter? = nil
    var arrMenuItems = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       self.determineIfWhichMenuToShow()
        self.tableView.register(UINib.init(nibName: SideMenuProfileTableViewCell.className, bundle: nil), forCellReuseIdentifier: SideMenuProfileTableViewCell.className)
        
        let nibName = UINib(nibName: SideMenuCell.className, bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: SideMenuCell.className)
        
        setupUI()
       
    }
    
    private func determineIfWhichMenuToShow() {
        if ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn {
            self.arrMenuItems = ApplicationManager.sharedInstance.sideMenuAndContentPageManager.arrAllMenuItems
        } else {
            ApplicationManager.sharedInstance.sideMenuAndContentPageManager.sortAllMenuItems()
            self.arrMenuItems = ApplicationManager.sharedInstance.sideMenuAndContentPageManager.arrNotLoggedInMenuItems
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - General
    
    func setupUI() {
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.borderColor = UIColor.clear.cgColor
        self.tableView.layer.rasterizationScale = UIScreen.main.scale;
        self.tableView.layer.shouldRasterize = true;
        self.tableView.separatorStyle = .none
        
    }

    
    func addFooterAndHeader(){
        
        self.footer?.removeFromSuperview()
        self.header?.removeFromSuperview()
        
        //TABLEVIEW FOOTE
        
        self.tableView.estimatedSectionFooterHeight = 0;
        if let arrBundle = Bundle.main.loadNibNamed(SideMenuFooter.className, owner: nil, options: nil) {
            
            self.footer = arrBundle[0] as? SideMenuFooter
            
            if(self.tableView.contentSize.height > self.view.height()) {
                self.tableView.tableFooterView = footer
                
            } else {
                self.footer?.setX(newX:0)
                self.footer?.setY(newY:self.view.height() - (footer?.height())!)
                self.footer?.setWidth(newWidth: self.view.width())
                self.tableView.isScrollEnabled=false
                self.tableView.tableFooterView = UIView()
                self.view.addSubview(self.footer!)
                
            }
        }
        
        
        
        //TABLEVIEW HEADER
        
        if let arrBundle = Bundle.main.loadNibNamed(SideMenuHeader.className, owner: nil, options: nil) {
            self.header = (arrBundle[0] as! SideMenuHeader)
            self.tableView.tableHeaderView = header
            
        }
        
    }
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItems.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row == 0 {
//            let menuItem = arrMenuItems[0] as! BaseMenuItem
//            let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuProfileTableViewCell.className) as! SideMenuProfileTableViewCell
//            cell.configureWithObj(menuItem: menuItem)
//            cell.isSelected = false
//            cell.delegate = self
//            return cell
//
//        } else {
            let menuItem = arrMenuItems[indexPath.row] as! BaseMenuItem
            let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.className) as! SideMenuCell
            cell.configureWithObj(menuItem: menuItem)
            
            if indexPath.row == arrMenuItems.count{
                cell.seperatorView.isHidden = true
            }
            
            return cell
//
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if indexPath.row > 0{
            let cell = tableView.cellForRow(at: indexPath) as! SideMenuCell
            cell.setHighlighted(false, animated: false)
            cell.lblTitle.isHighlighted = true
            cell.imgIcon.isHighlighted = true
            cell.imgIcon.tintColor = .white
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if indexPath.row > 0{
            let cell = tableView.cellForRow(at: indexPath) as! SideMenuCell
            cell.lblTitle.isHighlighted = false
            cell.imgIcon.isHighlighted = false
            cell.imgIcon.tintColor = .black

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        var cell = SideMenuCell()
        
//        if indexPath.row == 0 {
//            let privateAreaViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PrivateAreaViewController.className) as! PrivateAreaViewController
//            ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true, completionHandler: nil)
//            ApplicationManager.sharedInstance.tabBarController.pushViewController(viewController: privateAreaViewController, animated: true)
//        }
        
        if indexPath.row >= 0 {
            if indexPath.row > 0 {
                cell = tableView.cellForRow(at: indexPath) as! SideMenuCell
                cell.lblTitle.isHighlighted = true
                cell.imgIcon.isHighlighted = true
                cell.isHighlighted = true
            }
            
            tableView.isUserInteractionEnabled = false
           
            let menuItem = arrMenuItems[indexPath.row ] as! BaseMenuItem

            let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {

                    if !menuItem.isContentPage {
                        if menuItem.isStaticMenuItem {
                            self.moveToStaticVC(baseMenuItemTapped: menuItem)
                        } else {
                            if(!menuItem.strDeepLink.isEmpty) {
                                let deeplinkOpened  = ApplicationManager.sharedInstance.remoteNotificationAndDeepLinkManager.openDeepLink(strFullDeeplink: menuItem.strDeepLink, dataObject: nil, animated: true, completionHandler: nil)
                                if !deeplinkOpened {
                                    ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true, completionHandler: {
                                        ApplicationManager.sharedInstance.openURLManager.openSFSafari(strLink: menuItem.strDeepLink)
                                    })
                                    
                                }
                            }
                        }
                    } else {
                        let contentPage = menuItem as! ContentPage
                        
                        let dictParams = [ServerParamsGeneral.pageId:String(contentPage.numID)]
                        ApplicationManager.sharedInstance.sideMenuAndContentPageManager.callGetContentPageWithDictParams(dictParams: dictParams, andRequestFinishedDelegate: nil)
                    }
                

            }
            if indexPath.row > 0 {
                cell.lblTitle.isHighlighted = false
                cell.imgIcon.isHighlighted = false
                cell.isHighlighted = false
            }
            tableView.isUserInteractionEnabled = true

        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SideMenuCellHeight.profile.rawValue
            
        } else {
            return SideMenuCellHeight.general.rawValue
            
        }
    }

  
    // MARK: - Helper methods
    
    func refreshTable() {
        self.determineIfWhichMenuToShow()
        self.tableView.reloadData()
    }
    
    func moveToStaticVC(baseMenuItemTapped: BaseMenuItem) {
        
//        var vc = BaseViewController()
//        var vcIdentifier = ""
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        
//        switch baseMenuItemTapped.numID {
//            
//        case SideMenuItemID.myCompany.rawValue:
//            let dictParmas: [String: Any] = [ServerProfileCallsParams.companyId : 1]
//            ApplicationManager.sharedInstance.profilesManager.callGetCompanyProfile(dictParams: dictParmas, andRequestFinishedDelegate: nil)
//
//            break
//            ///
//        case SideMenuItemID.location.rawValue:
//            vcIdentifier = ""
//            break
//        case SideMenuItemID.refer.rawValue:
//            vcIdentifier = ""
//            break
//        case SideMenuItemID.communityManager.rawValue:
//            vcIdentifier = ""
//            break
//            //
//        default:
//            return
//        }
//        
//       vc = sb.instantiateViewController(withIdentifier: vcIdentifier) as! BaseViewController
//        
//        ApplicationManager.sharedInstance.navigationController.pushViewController(vc, animated: true)
//        
        
    }
    
    func moveToHome() {
        ApplicationManager.sharedInstance.navigationController .popToRootViewController(animated: false)
    }
    
    
    // MARK: - ProcessFinishProtocol
    
    func processFinished(processManager: BaseProcessManager, processFinishedStatus: ProcessFinishedStatus, processCompletion: (BaseProcessManager, ProcessFinishedStatus) -> ()) {
        
    }
    
    //MARK: - SideMenuProfileTableViewCellDelegate
    
    func didTapSignout(_ sender: Any) {
        if ApplicationManager.sharedInstance.userAccountManager.isUserLoggedIn {
            ApplicationManager.sharedInstance.userAccountManager.callLogoutWithUserAccountProcessObj(userAccountProcessObj: nil, andRequestFinishedDelegate: nil)
        } else {
            ApplicationManager.sharedInstance.userAccountManager.startLoginProcess()
            ApplicationManager.sharedInstance.mainViewController.hideSideMenu(animated: true) {
            }
        }
       
    }
    

}
