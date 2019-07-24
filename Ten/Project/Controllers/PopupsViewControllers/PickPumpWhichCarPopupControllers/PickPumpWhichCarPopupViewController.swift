//
//  FaceIdSmallPopupViewController.swift
//  Ten
//
//  Created by inmanage on 03/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PickPumpWhichCarPopupViewController: BasePopupViewController, UITableViewDelegate, UITableViewDataSource, cancelPopupDelegate {
    
    var selectedCellIndex: IndexPath?
    var strHeaderText = ""
    
    var stationsArr: [Station] = []
   
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
        
    func didTapCancel() {
        
        if let aPopupInfo = self.popupInfoObj {
            
            if let aSecondButtonAction = aPopupInfo.secondButtonAction {
                aSecondButtonAction()
            }
            
            if let aDelegate = self.popupViewControllerDelegate {
                if aDelegate.responds(to: #selector(PopupViewControllerDelegate.closePopupVC(popupVC:))) {
                    
                    aDelegate.closePopupVC!(popupVC: self)
                }
                
            }
        }
    }
 
    func setupUI() {
        
        self.registerNibs()
        self.fillTextWithTrans()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceVertical = false
        
        self.tableView.estimatedRowHeight = 160
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func fillTextWithTrans() {
        self.strHeaderText = Translation(PickPumpWhichCarPopupTranslations.lblTitle, PickPumpWhichCarPopupTranslations.lblTitleDefault)
    }
    
    func registerNibs() {
        
        self.tableView.register(UINib(nibName: PumpWhichCarTableViewCell.className, bundle: nil), forCellReuseIdentifier: PumpWhichCarTableViewCell.className)
        
        self.tableView.register(UINib(nibName: PumpWhichCarUITableViewHeaderFooterView.className, bundle: nil), forCellReuseIdentifier: PumpWhichCarUITableViewHeaderFooterView.className)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PumpWhichCarTableViewCell.className, for: indexPath) as! PumpWhichCarTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = Bundle.main.loadNibNamed(PumpWhichCarUITableViewHeaderFooterView.className, owner: self, options: nil)?.first as! PumpWhichCarUITableViewHeaderFooterView

        headerView.lblHeaderTitle.text = strHeaderText
        
        headerView.cancelDelegate = self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 67.5
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: false)
       
    }
     
}

