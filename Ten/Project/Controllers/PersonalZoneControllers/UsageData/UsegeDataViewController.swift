//
//  UsegeDataViewController.swift
//  Ten
//
//  Created by Amit on 15/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class UsegeDataViewController: BaseFormViewController {
  
    @IBOutlet weak var lblTitleTableView: UILabel!
    @IBOutlet weak var tableViewTitle: UIView!
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var lblCarNumber: RegularLabel!
    @IBOutlet weak var tableDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: MediumLabel!
    @IBOutlet weak var imgNis: UIImageView!
    @IBOutlet weak var imgFuelBox: UIImageView!
    @IBOutlet weak var lblAvgForAmountTitle: RegularLabel!
    @IBOutlet weak var lblAmountAvgTitle: BoldLabel!
    @IBOutlet weak var lblAvgFuelingTitle: RegularLabel!
    @IBOutlet weak var lblAvgForLiterTitle: RegularLabel!
    @IBOutlet weak var lblLitersAvgTitle: BoldLabel!
    @IBOutlet weak var lblFuelingForAvgLiters: RegularLabel!
    @IBOutlet weak var lblAvaregeNis: MediumLabel!
    @IBOutlet weak var lblAvarageLiter: MediumLabel!
    @IBOutlet weak var lblLiter: RegularLabel!
    @IBOutlet weak var lblMonthlyCarExpenses: RegularLabel!
    @IBOutlet weak var vwTitle: UIView!
    @IBOutlet weak var vwGraphs: UIView!
    @IBOutlet weak var vwNis: UIView!
    @IBOutlet weak var vwFuel: UIView!
    
    var fuelingDevice = ApplicationManager.sharedInstance.userAccountManager.user.fuelingDevicesArr
    var viewModel = UsegeDataViewModel()
    var transparentView = UIView()
    var isTableVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.getCarInformation()
        self.registerXibs()
    }
    
    override func fillTextWithTrans() {
        self.lblTitleTableView.text = Translation(Translations.Titles.chooseFuelingType, Translations.Titles.chooseFuelingTypeDefault)
        self.lblTitle.text = Translation(Translations.Titles.usageDataTitle, Translations.Titles.usageDataTitleDefault)
        self.lblMonthlyCarExpenses.text = Translation(Translations.SubTitles.usageDataSubtitle, Translations.SubTitles.usageDataSubtitleDefault)
        self.lblAvgForAmountTitle.text = Translation(Translations.Titles.avgSumTitle1, Translations.Titles.avgSumTitle1Default)
        self.lblAmountAvgTitle.text = Translation(Translations.Titles.avgSumTitle2, Translations.Titles.avgSumTitle2Default)
        self.lblAvgFuelingTitle.text = Translation(Translations.Titles.avgSumTitle3, Translations.Titles.avgSumTitle3Default)
        self.lblAvgForLiterTitle.text = Translation(Translations.Titles.avgLitreTitle1, Translations.Titles.avgLitreTitle1Default)
        self.lblLitersAvgTitle.text = Translation(Translations.Titles.avgLitreTitle2, Translations.Titles.avgLitreTitle2Default)
        self.lblFuelingForAvgLiters.text = Translation(Translations.Titles.avgLitreTitle3, Translations.Titles.avgLitreTitle3Default)
        self.lblLiter.text = Translation(Translations.Titles.avgLitreSubtitle, Translations.Titles.avgLitreSubtitleDefault)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
            vc.changeConstraint(trailingConstraint: 0,
                                bottomConstraint: 0,
                                leadingConstraint: 0,
                                containerHeightConst: vc.view.frame.height)
            vc.containerView.backgroundColor = .clear
            vc.view.backgroundColor = .clear
            vc.vwContent = nil
            vc.containerView = nil
        }
    }
    
    fileprivate func initUI() {
        self.tableViewTitle.isHidden = true
        self.imgFuelType.setImageWithStrURL(strURL: self.fuelingDevice[0].fuelItem.strIcon, withAddUnderscoreIphone: false)
        self.imgCreditCard?.setImageWithStrURL(strURL: self.fuelingDevice[0].payment.strIcon, withAddUnderscoreIphone: false)
        self.lblCarNumber.text = self.fuelingDevice[0].strTitle
        self.tableDropDownHC.constant = 0
        self.view.backgroundColor = .clear
        self.imgNis.image = UIImage(named: "nis")
        self.imgFuelBox.image = UIImage(named: "fuelBox")
        self.vwTitle.addShadowAndCorner()
        self.vwGraphs.addShadow()
        self.vwNis.addShadowAndCorner()
        self.vwFuel.addShadowAndCorner()
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: PumpWhichCarTableViewCell.className, bundle: nil), forCellReuseIdentifier: PumpWhichCarTableViewCell.className)
    }
    
    fileprivate func getCarInformation() {
        
        let dict = [TenParamsNames.fuelingDeviceId: self.fuelingDevice[0].strId]
        
        ApplicationManager.sharedInstance.userAccountManager.callGetUsageInformation(dictParams: dict, requestFinishedDelegate: self)
    }
    
    //IBAction:
    @IBAction func didTapCloseDropDown(_ sender: Any) {
         self.closeDropDown()
    }
    
    @IBAction func didTapOpenDropDown(_ sender: Any) {
        if self.isTableVisible == false {
            self.openDropDown()
        } else {
            self.closeDropDown()
        }
    }
    
    fileprivate func closeDropDown() {
        UIView.animate(withDuration: 0.3) {
            self.transparentView.alpha = 0
            self.tableViewTitle.isHidden = true
            self.imgDropDown.image = UIImage(named: "down")
            self.tableDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func openDropDown() {
        UIView.animate(withDuration: 0.3) {
            
            self.tableViewTitle.isHidden = false
            if self.fuelingDevice.count <= 5 {
                self.tableDropDownHC.constant = (82.0 * CGFloat(self.fuelingDevice.count))
            } else {
                self.tableDropDownHC.constant = (82.0 * 5)
            }
            self.addAlpheAndTapRecognizerToScreen()
            self.transparentView.alpha = 0.8
            self.imgDropDown.image = UIImage(named: "up")
            self.isTableVisible = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func didTapTransparentView() {
        UIView.animate(withDuration: 0.3) {
            self.transparentView.alpha = 0
            self.closeDropDown()
        }
    }
    
    fileprivate func addAlpheAndTapRecognizerToScreen() {
        let window = UIApplication.shared.keyWindow
        self.transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        DispatchQueue.main.async(execute: {
            let hight = UIScreen.main.bounds.size.height - self.tableView.frame.size.height - self.tableViewTitle.frame.size.height
            let witdh = self.view.frame.size.height
            self.transparentView.frame = CGRect(x: 0, y: 0, width: witdh, height: hight)
            window?.addSubview(self.transparentView)
        })
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapTransparentView))
        self.transparentView.addGestureRecognizer(tapGesture)
    }
}

extension UsegeDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fuelingDevice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PumpWhichCarTableViewCell.className, for: indexPath) as! PumpWhichCarTableViewCell
        
        cell.imgCar.setImageWithStrURL(strURL: self.fuelingDevice[indexPath.row].strIcon, withAddUnderscoreIphone: false)
        cell.lblCarNumber.text = self.fuelingDevice[indexPath.row].strTitle
        cell.imgFuelType.setImageWithStrURL(strURL: self.fuelingDevice[indexPath.row].fuelItem.strIcon, withAddUnderscoreIphone: false)
        cell.lblCardNumber.text = self.fuelingDevice[indexPath.row].payment.strTitle
        cell.imgCard.setImageWithStrURL(strURL: self.fuelingDevice[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.lblCarNumber.text = self.fuelingDevice[indexPath.row].strTitle
        self.imgFuelType.setImageWithStrURL(strURL: self.fuelingDevice[indexPath.row].fuelItem.strIcon, withAddUnderscoreIphone: false)
        self.imgCreditCard.setImageWithStrURL(strURL: self.fuelingDevice[indexPath.row].payment.strIcon, withAddUnderscoreIphone: false)
        
        self.closeDropDown()
    }
}

extension UsegeDataViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == TenRequestNames.getUsageInformation {
            
            if let innerResponse = innerResponse as? GetUsageInformationResponse {
              
                
            }
            
        }
    }
    
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}

