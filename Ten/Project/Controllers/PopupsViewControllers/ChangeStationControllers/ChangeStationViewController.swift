//
//  ChangeStationViewController.swift
//  Ten
//
//  Created by shani daniel on 10/10/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

class ChangeStationViewController: BasePopupViewController , UITableViewDelegate, UITableViewDataSource, cancelPopupDelegate {
  
    var selectedCellIndex: IndexPath?
    var strHeaderText = ""
    var stationsArr: [Station] = []
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
     
        //self.stationsArr =  self.stationsArr.sorted(by: { $0.StrRange > $1.StrRange })
        self.registerNibs()
        self.fillTextWithTrans()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceVertical = false
        
//        self.tableView.estimatedRowHeight = 160
//        self.tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func fillTextWithTrans() {
        strHeaderText = Translation(ChangeStationVCTranslations.lblTitle, ChangeStationVCTranslations.lblTitleDefault)
    }
    
    func registerNibs() {
        
        self.tableView.register(UINib(nibName: StationTableViewCell.className, bundle: nil), forCellReuseIdentifier: StationTableViewCell.className)
        
        
        self.tableView.register(UINib(nibName: StationUITableViewHeaderFooterView.className, bundle: nil), forCellReuseIdentifier: StationUITableViewHeaderFooterView.className)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //self.stationsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.className, for: indexPath) as! StationTableViewCell
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed(StationUITableViewHeaderFooterView.className, owner: self, options: nil)?.first as! StationUITableViewHeaderFooterView
        
        headerView.lblHeaderTitle.text = strHeaderText
        
        headerView.cancelDelegate = self
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 67.5
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
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        if let aSelectedCellIndex = self.selectedCellIndex {
            let selectedCell = self.tableView.cellForRow(at: aSelectedCellIndex) as! StationTableViewCell
            dissHighlightRegularCell(regularCell: selectedCell)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! StationTableViewCell
        self.selectedCellIndex = indexPath
        self.highlightChosenCell(currentCell: cell)
  
    }
  
    func highlightChosenCell(currentCell: StationTableViewCell) {
       
            currentCell.backgroundColor = UIColor.getHighlightedCellColor()
            currentCell.imgSelected.isHidden = false
    }
    
    func dissHighlightRegularCell(regularCell: StationTableViewCell) {
        regularCell.backgroundColor = UIColor.clear
        regularCell.imgSelected.isHidden = true
    }
    
}

