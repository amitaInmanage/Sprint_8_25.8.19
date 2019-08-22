//
//  UsegeDataViewController.swift
//  Ten
//
//  Created by Amit on 15/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class UsegeDataViewController: BaseFormViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitleTableView: UILabel!
    @IBOutlet weak var tableViewTitle: UIView!
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var lblCarNumber: RegularText!
    @IBOutlet weak var tableDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var imgNis: UIImageView!
    @IBOutlet weak var imgFuelBox: UIImageView!
    @IBOutlet weak var lblAvgAmountToFueling: RegularText?
    @IBOutlet weak var lblAvgLitersToFueling: RegularText?
    @IBOutlet weak var lblAvaregeNis: UILabel!
    @IBOutlet weak var lblAvarageLiter: UILabel!
    @IBOutlet weak var lblLiter: SmallText!
    @IBOutlet weak var lblMonthlyCarExpenses: RegularText!
    @IBOutlet weak var vwTitle: UIView!
    @IBOutlet weak var vwGraphs: UIView!
    @IBOutlet weak var vwNis: UIView!
    @IBOutlet weak var vwFuel: UIView!
    @IBOutlet weak var btnDropDown: UIButton!
    
    var fuelingDevice = ApplicationManager.sharedInstance.userAccountManager.user.fuelingDevicesArr
    var viewModel = UsegeDataViewModel()
    var transparentView = UIView()
    var isTableVisible: Bool = false
    var sumByMount = [SumByMountItem]()
    var maxSum = SumByMountItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.cellCarInformation(id: "")
        self.registerXibs()
        self.oneCarForUser()
    }
    
    override func fillTextWithTrans() {
        self.boldLblAvgAmountToFueling()
        self.boldLblAvgLitersToFueling()
        self.lblTitleTableView.text = Translation(Translations.Titles.chooseFuelingType, Translations.Titles.chooseFuelingTypeDefault)
        self.lblTitle.text = Translation(Translations.Titles.usageDataTitle, Translations.Titles.usageDataTitleDefault)
        self.lblMonthlyCarExpenses.text = Translation(Translations.SubTitles.usageDataSubtitle, Translations.SubTitles.usageDataSubtitleDefault)
        self.lblLiter.text = Translation(Translations.Titles.avgLitreSubtitle, Translations.Titles.avgLitreSubtitleDefault)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
       self.fullScreeen(parent: parent)
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: PumpWhichCarTableViewCell.className, bundle: nil), forCellReuseIdentifier: PumpWhichCarTableViewCell.className)
        self.collectionView.register(UINib(nibName: UsageDataGraphCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: UsageDataGraphCollectionViewCell.className)
    }
    
    fileprivate func initUI() {
        self.tableViewTitle.isHidden = true
        if let strFuelIcon = self.fuelingDevice.first?.fuelItem.strIcon {
             self.imgFuelType.setImageWithStrURL(strURL: strFuelIcon, withAddUnderscoreIphone: false)
        }
        if let strPaymentIcon = self.fuelingDevice.first?.payment.strIcon {
             self.imgCreditCard?.setImageWithStrURL(strURL: strPaymentIcon, withAddUnderscoreIphone: false)
        }
        if let strCarNumber = self.fuelingDevice.first?.strTitle {
             self.lblCarNumber.text = strCarNumber
        }
        self.tableDropDownHC.constant = 0
        self.view.backgroundColor = .clear
        self.imgNis.image = UIImage(named: "nis")
        self.imgFuelBox.image = UIImage(named: "fuelBox")
        self.vwTitle.addShadowAndCorner()
        self.vwGraphs.addShadow()
        self.vwNis.addShadowAndCorner()
        self.vwFuel.addShadowAndCorner()
    }
  
    
    fileprivate func cellCarInformation(id: String) {
        
        let dict = [TenParamsNames.fuelingDeviceId: id]
        
        ApplicationManager.sharedInstance.userAccountManager.callGetUsageInformation(dictParams: dict as [String : Any], requestFinishedDelegate: self)
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
            if self.fuelingDevice.count <= 4 {
                self.tableDropDownHC.constant = (82.0 * CGFloat(self.fuelingDevice.count))
            } else {
                self.tableDropDownHC.constant = (82.0 * 4)
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
    
    fileprivate func boldLblAvgAmountToFueling()  {
        let formattedString = NSMutableAttributedString()
        formattedString
            
            .normal(Translation(Translations.Titles.avgSumTitle1, Translations.Titles.avgSumTitle1Default) + (" "))
            .bold(Translation(Translations.Titles.avgSumTitle2, Translations.Titles.avgSumTitle2Default) + (" "))
            .normal(Translation(Translations.Titles.avgSumTitle3, Translations.Titles.avgSumTitle3Default))
        
        self.lblAvgAmountToFueling?.attributedText = formattedString
    }
    
    fileprivate func boldLblAvgLitersToFueling()  {
        let formattedString = NSMutableAttributedString()
        formattedString
            
            .normal(Translation(Translations.Titles.avgLitreTitle1, Translations.Titles.avgLitreTitle1Default) + (" "))
            .bold(Translation(Translations.Titles.avgLitreTitle2, Translations.Titles.avgLitreTitle2Default) + (" "))
            .normal(Translation(Translations.Titles.avgLitreTitle3, Translations.Titles.avgLitreTitle3Default))
        
        self.lblAvgLitersToFueling?.attributedText = formattedString
    }
    
    fileprivate func oneCarForUser()  {
        let hidden = self.fuelingDevice.count <= 1
            self.imgDropDown.isHidden = hidden
            self.btnDropDown.isHidden = hidden
    }
}

extension UsegeDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fuelingDevice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PumpWhichCarTableViewCell.className, for: indexPath) as! PumpWhichCarTableViewCell
        
        let fuelingDevice = self.fuelingDevice[indexPath.row]
        
        cell.imgCar.setImageWithStrURL(strURL: fuelingDevice.strIcon, withAddUnderscoreIphone: false)
        cell.lblCarNumber.text = fuelingDevice.strTitle
        cell.imgFuelType.setImageWithStrURL(strURL: fuelingDevice.fuelItem.strIcon, withAddUnderscoreIphone: false)
        cell.lblCardNumber.text = fuelingDevice.payment.strTitle
        cell.imgCard.setImageWithStrURL(strURL: fuelingDevice.payment.strIcon, withAddUnderscoreIphone: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let fuelingDevice = self.fuelingDevice[indexPath.row]
        
        self.lblCarNumber.text = fuelingDevice.strTitle
        self.imgFuelType?.setImageWithStrURL(strURL: fuelingDevice.fuelItem.strIcon, withAddUnderscoreIphone: false)
        self.imgCreditCard.setImageWithStrURL(strURL: fuelingDevice.payment.strIcon, withAddUnderscoreIphone: false)
        self.cellCarInformation(id: fuelingDevice.strId)
        self.closeDropDown()
    }
    
    fileprivate func getBiggestSumByMount() -> SumByMountItem {
        var maxHightGraph: SumByMountItem = SumByMountItem()
        
        for sum in self.sumByMount {
            if sum.intSum > maxHightGraph.intSum  {
                maxHightGraph = sum
            }
        }
        return maxHightGraph
    }
}

extension UsegeDataViewController {
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == TenRequestNames.getUsageInformation {
            
            if let innerResponse = innerResponse as? GetUsageInformationResponse {
                
                self.lblAvarageLiter.text = String(innerResponse.avarages.intLiter)
                self.lblAvaregeNis.text = String(innerResponse.avarages.intSum)
                self.sumByMount = innerResponse.sumByMountArr
                self.maxSum = self.getBiggestSumByMount()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}

extension UsegeDataViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.sumByMount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsageDataGraphCollectionViewCell.className, for: indexPath) as! UsageDataGraphCollectionViewCell
        let sumByMount = self.sumByMount[indexPath.row]
        
        if self.maxSum.intSum != sumByMount.intSum {
            let newHeight: Double = Double(sumByMount.intSum) / Double(self.maxSum.intSum) * 100.0
            
            cell.graphHeightConstraint.constant = CGFloat(newHeight)
        } else {
            cell.graphHeightConstraint.constant = 100
        }
        
        cell.lblNis.text =  "₪" + String(sumByMount.intSum)
        cell.lblMonth.text = sumByMount.strMonth
        cell.lblYear.text = String(sumByMount.intYear)
       
        
        return cell
    }
}




//Animate to Graph:
//                for number in 1...Int(newHeight) {
//                    UIView.animate(withDuration: 0.3) {
//                    cell.graphHeightConstraint.constant = CGFloat(number)
//                        self.view.layoutIfNeeded()
//                    }
//                }
