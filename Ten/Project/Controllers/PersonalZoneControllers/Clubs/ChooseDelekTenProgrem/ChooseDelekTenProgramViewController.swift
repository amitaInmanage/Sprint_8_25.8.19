//
//  ChooseDelekTenProgramViewController.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class ChooseDelekTenProgramViewController: BaseFormViewController {
    
    @IBOutlet weak var btnSaveChanges: TenButtonStyle!
    @IBOutlet weak var btnTermsOfClubs: IMButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblProgramDetails: RegularLabel!
    @IBOutlet weak var lblProgramTitle: RegularLabel!
    @IBOutlet weak var lblAmount: RegularLabel!
    @IBOutlet weak var lblDetailsAmount: RegularLabel!
    @IBOutlet weak var lblTitle: MediumLabel!
    @IBOutlet weak var tableViewHC: NSLayoutConstraint!
    
    var viewModel = ChooseDelekTenProgramViewModel()
    var customerProgramsItems = ApplicationManager.sharedInstance.appGD.customerProgramItem
    var customerProgramBenefit = ApplicationManager.sharedInstance.appGD.customerProgramBenefitTypesItem
    var customerProgramsUser = ApplicationManager.sharedInstance.userAccountManager.user.customerProgram
    var maxChanges = ApplicationManager.sharedInstance.appGD.maxCustomerProgramChanges
    var customerProgramId = 0
    var selected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.registerXibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 230
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
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.delekTenChooseProgram, Translations.Titles.delekTenChooseProgramDefault)
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = .clear
        
        self.btnTermsOfClubs.addUnderline(title: Translation(Translations.AlertButtonsKeys.delekTenChooseProgramTerms, Translations.AlertButtonsKeys.delekTenChooseProgramTermsDefault))
        
        self.btnSaveChanges.setTitle(Translation(Translations.AlertButtonsKeys.delekTenChooseProgram, Translations.AlertButtonsKeys.delekTenChooseProgramDefault), for: .normal)
        
        self.lblDetailsAmount.text = (Translation(Translations.AlertButtonsKeys.delekTenChooseProgramAccumulation, Translations.AlertButtonsKeys.delekTenChooseProgramAccumulationDefault))
        
        self.lblProgramTitle.text = (Translation(Translations.Titles.delekTenChoosePrograms, Translations.Titles.delekTenChooseProgramsDefault))
        
        self.lblProgramDetails.text = StringManager.sharedInstance.replaceString(originalString:  (Translation(Translations.Titles.delekTenChooseProgramChangesLeft, Translations.Titles.delekTenChooseProgramChangesLeftDefault)), replacement: String(customerProgramsUser.changesMode), String(maxChanges))
        
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: TenProgramTableViewCell.className, bundle: nil), forCellReuseIdentifier: TenProgramTableViewCell.className)
    }
    
    //Mark - IBAction:
    @IBAction func didTapTermsOfClubs(_ sender: Any) {
        //TODO: inSprint 7
    }
    
    @IBAction func didTapSaveChanges(_ sender: Any) {
        
        let dict = [TenParamsNames.customerProgramId: self.customerProgramId]
        
        ApplicationManager.sharedInstance.userAccountManager.callSetUserCustomerProgram(dictParams: dict, requestFinishedDelegate: nil)
    }
}

extension ChooseDelekTenProgramViewController: SelectedProgramDelegate, DropDownDelegate {
    
    func didTapDropDown() {
    }
    
    func didTapSelectedProgram() {
        self.customerProgramId = Int(customerProgramsItems[selected].strId)!
    }
}

extension ChooseDelekTenProgramViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerProgramsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TenProgramTableViewCell.className, for: indexPath) as! TenProgramTableViewCell
        
        self.selected = indexPath.row
        
        cell.dropDownDelegate = self
        cell.selectedProgramDelegate = self
        
        cell.lblTitleProgram.text = StringManager.sharedInstance.replaceString(originalString: Translation(Translations.Titles.delekTenChooseProgramRow, Translations.Titles.delekTenChooseProgramRowDefault), replacement: customerProgramsItems[indexPath.row].strName)
        cell.lblProgramDetails.text = customerProgramsItems[indexPath.row].strDescription
        
        var fuelDiscountText = getTemplateText(type: customerProgramsItems[indexPath.row].strFuelBenefitType)
        fuelDiscountText = StringManager.sharedInstance.replaceString(originalString: fuelDiscountText, replacement: customerProgramsItems[indexPath.row].strfuelBenefitValue)
        cell.lblFuelAssumption.text = fuelDiscountText
        
        var surroundingText = getTemplateText(type: customerProgramsItems[indexPath.row].strSurroundingsType)
        surroundingText = StringManager.sharedInstance.replaceString(originalString: surroundingText, replacement: customerProgramsItems[indexPath.row].strSurroundingsValue)
        cell.lblAroundCarAssumption.text = surroundingText
        
        
        var storeText = getTemplateText(type: customerProgramsItems[indexPath.row].strStoreBenefitType)
        storeText = StringManager.sharedInstance.replaceString(originalString: storeText, replacement: customerProgramsItems[indexPath.row].strStoreBenefitValue)
        cell.lblStoresAssumption.text = storeText
        
        if customerProgramsItems[indexPath.row].strNotes.isEmpty {
            cell.lblProgramDetailsDropDown.text = ""
        } else {
            cell.lblProgramDetailsDropDown.text = customerProgramsItems[indexPath.row].strNotes
        }
        
        return cell
    }
    
    func getTemplateText(type: String) -> String {
        for benefitType in customerProgramBenefit {
            if type == String(benefitType.intKey) {
                return benefitType.strTemplate
            }
        }
        return ""
    }
}

