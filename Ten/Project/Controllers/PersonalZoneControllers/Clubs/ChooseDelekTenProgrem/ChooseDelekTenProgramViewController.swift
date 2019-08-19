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
    @IBOutlet weak var lblManagerText: RegularLabel!
    
    var viewModel = ChooseDelekTenProgramViewModel()
    var customerProgramsItems = ApplicationManager.sharedInstance.appGD.customerProgramItem
    var customerProgramBenefit = ApplicationManager.sharedInstance.appGD.customerProgramBenefitTypesItem
    var customerProgramsUser = ApplicationManager.sharedInstance.userAccountManager.user.customerProgram
    var maxChanges = ApplicationManager.sharedInstance.appGD.maxCustomerProgramChanges
    var customerProgramId: Int = 0
    var selected: Int = -1
    var firstTimeLoaded = true
    var disableState = false
    
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
       self.fullScreeen(parent: parent)
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.delekTenChooseProgram, Translations.Titles.delekTenChooseProgramDefault)
        
        //TODO: lblAmount
//        self.lblAmount.text =
        
        self.lblDetailsAmount.text = (Translation(Translations.AlertButtonsKeys.delekTenChooseProgramAccumulation, Translations.AlertButtonsKeys.delekTenChooseProgramAccumulationDefault))
        
        self.lblProgramTitle.text = (Translation(Translations.Titles.delekTenChoosePrograms, Translations.Titles.delekTenChooseProgramsDefault))
        
        self.btnTermsOfClubs.addUnderline(title: Translation(Translations.AlertButtonsKeys.delekTenChooseProgramTerms, Translations.AlertButtonsKeys.delekTenChooseProgramTermsDefault))
        
        self.btnSaveChanges.setTitle(Translation(Translations.AlertButtonsKeys.delekTenChooseProgram, Translations.AlertButtonsKeys.delekTenChooseProgramDefault), for: .normal)
        
         self.lblProgramDetails.text = StringManager.sharedInstance.replaceString(originalString:  (Translation(Translations.Titles.delekTenChooseProgramChangesLeft, Translations.Titles.delekTenChooseProgramChangesLeftDefault)), replacement: String(customerProgramsUser.changesMode), String(maxChanges))
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = .clear
        self.btnSaveChanges.Disabled()
        
        self.disableState = self.checkState()
        
        if disableState {
            self.btnSaveChanges.isHidden = true
            self.lblManagerText.text = Translation(Translations.AlertButtonsKeys.delekTenChooseProgramStation, Translations.AlertButtonsKeys.delekTenChooseProgramStationDefault)
            
        } else {
            self.lblManagerText.isHidden = true
            self.btnSaveChanges.isHidden = false
        }
    }
    
    fileprivate func registerXibs() {
        self.tableView.register(UINib(nibName: TenProgramTableViewCell.className, bundle: nil), forCellReuseIdentifier: TenProgramTableViewCell.className)
    }
    
    //Mark - IBAction:
    @IBAction func didTapTermsOfClubs(_ sender: Any) {
        //TODO: inSprint 7
    }
    
    @IBAction func didTapSaveChanges(_ sender: Any) {
        
        if self.customerProgramsUser.changesMode >= self.maxChanges  {
            
            let blockedPopup = PopupInfoObj()
            blockedPopup.popupType = .tenGeneralPopup
            blockedPopup.strImageName = "warning"
            
            blockedPopup.strTitle = StringManager.sharedInstance.replaceString(originalString: Translation(Translations.Titles.dialogChangeProgramNotAvailable, Translations.Titles.dialogChangeProgramNotAvailableDefault), replacement: ApplicationManager.sharedInstance.userAccountManager.user.strFirstName)
            
            blockedPopup.strSubtitle = Translation(Translations.SubTitles.dialogChangeProgramNotAvailable, Translations.SubTitles.dialogChangeProgramNotAvailableDefault)
            
            blockedPopup.strBottomText = Translation(Translations.SubTitles.dialogChangeProgramNotAvailableSubTitle, Translations.SubTitles.dialogChangeProgramNotAvailableSubTitleDefault)
            
            blockedPopup.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.dialogChangeProgramNotAvailable, Translations.AlertButtonsKeys.dialogChangeProgramNotAvailableDefault)
            
            blockedPopup.firstButtonAction = {
                //TODO: Send to Connect us
            }
            
            ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: blockedPopup, andPopupViewControllerDelegate: nil)
            
        } else {
            let popupInfoObj = PopupInfoObj()
            popupInfoObj.popupType = .tenGeneralPopup
            popupInfoObj.strImageName = "warning"
            
            popupInfoObj.strTitle = StringManager.sharedInstance.replaceString(originalString: Translation(Translations.Titles.dialogChangeProgramNotAvailable, Translations.Titles.dialogChangeProgramNotAvailableDefault), replacement: ApplicationManager.sharedInstance.userAccountManager.user.strFirstName)
            
            popupInfoObj.strSubtitle =  StringManager.sharedInstance.replaceString(originalString: Translation(Translations.SubTitles.dialogChangeProgram, Translations.SubTitles.dialogChangeProgramDefault
            ), replacement: customerProgramsItems[selected].strName, String(maxChanges))
            
            popupInfoObj.strFirstButtonTitle = Translation(Translations.AlertButtonsKeys.dialogChangeProgramBtn, Translations.AlertButtonsKeys.dialogChangeProgramBtnDefault)
            
            popupInfoObj.strSecondButtonTitle = Translation(Translations.AlertButtonsKeys.dialogChangeProgramCancel, Translations.AlertButtonsKeys.dialogChangeProgramCancelDefault)
            
            popupInfoObj.firstButtonAction = {
                
                let dict = [TenParamsNames.customerProgramId: self.customerProgramId]
                
                ApplicationManager.sharedInstance.userAccountManager.callSetUserCustomerProgram(dictParams: dict, requestFinishedDelegate: self)
                
            }
            
            ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        }
    }
}

extension ChooseDelekTenProgramViewController: SelectedProgramDelegate, DropDownDelegate {
    
    func didTapDropDown() {
        view.layoutIfNeeded()
        self.tableView.reloadData()
    }
    
    func didTapSelectedProgram(sender: UIButton) {
        self.btnSaveChanges.Enabled()
        self.selected = sender.tag
        self.customerProgramId = customerProgramsItems[self.selected].intId
        self.firstTimeLoaded = false
        self.tableView.reloadData()
    }
    
    func getTemplateText(type: String) -> String {
        for benefitType in customerProgramBenefit {
            if type == String(benefitType.intKey) {
                return benefitType.strTemplate
            }
        }
        return ""
    }
    
    fileprivate func checkState() -> Bool{
        if self.customerProgramsUser.availableProgram.count <= 1 {
            return true
        } else {
            return false
        }
    }
}

extension ChooseDelekTenProgramViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerProgramsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TenProgramTableViewCell.className, for: indexPath) as! TenProgramTableViewCell
        
        cell.btnSelectedProgram.tag = indexPath.row
        
        self.disableState = self.checkState()
        
        if firstTimeLoaded {
            if customerProgramsItems[indexPath.row].intId == customerProgramsUser.intCurrentProgrramId {
                cell.btnSelectedProgram.setImage(UIImage(named: "radioButtonOn"), for: .normal)
                self.selected = indexPath.row
            } else {
                cell.btnSelectedProgram.setImage(UIImage(named: "radioButtonOff"), for: .normal)
            }
        } else {
                let imageResource = indexPath.row == selected ? "radioButtonOn" :  "radioButtonOff"
                cell.btnSelectedProgram.setImage(UIImage(named: imageResource), for: .normal)
          
        }
        
        cell.dropDownDelegate = self
        cell.selectedProgramDelegate = self
        let customerProgramItem = customerProgramsItems[indexPath.row]
        
        cell.lblTitleProgram.text = StringManager.sharedInstance.replaceString(originalString: Translation(Translations.Titles.delekTenChooseProgramRow, Translations.Titles.delekTenChooseProgramRowDefault), replacement: customerProgramItem.strName)
        cell.lblProgramDetails.text = customerProgramItem.strDescription
        
        var fuelDiscountText = getTemplateText(type: customerProgramItem.strFuelBenefitType)
        fuelDiscountText = StringManager.sharedInstance.replaceString(originalString: fuelDiscountText, replacement: customerProgramItem.strfuelBenefitValue)
        cell.lblFuelAssumption.text = fuelDiscountText
        
        var surroundingText = getTemplateText(type: customerProgramItem.strSurroundingsType)
        surroundingText = StringManager.sharedInstance.replaceString(originalString: surroundingText, replacement: customerProgramItem.strSurroundingsValue)
        cell.lblAroundCarAssumption.text = surroundingText
        
        var storeText = getTemplateText(type: customerProgramItem.strStoreBenefitType)
        storeText = StringManager.sharedInstance.replaceString(originalString: storeText, replacement: customerProgramItem.strStoreBenefitValue)
        cell.lblStoresAssumption.text = storeText
        
        cell.lblProgramDetailsDropDown.isHidden =  customerProgramItem.strNotes.isEmpty
        cell.lblProgramDetailsDropDown.text = customerProgramItem.strNotes
        
        let alphaDisable = CGFloat(1.0)
        let alphaEnable = CGFloat(0.5)

        if disableState {

            if self.customerProgramsUser.availableProgram[0] == customerProgramItem.intId {
                cell.vwProgram.alpha = alphaDisable
                cell.vwDropDown.alpha = alphaDisable
            } else {
                cell.vwProgram.alpha = alphaEnable
                cell.vwDropDown.alpha = alphaEnable
            }
        } else {
            cell.vwProgram.alpha = alphaDisable
            cell.vwDropDown.alpha = alphaDisable
        }
        
        cell.btnSelectedProgram.isEnabled = !disableState
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !disableState {
            self.btnSaveChanges.Enabled()
            self.selected = indexPath.row
            self.customerProgramId = customerProgramsItems[self.selected].intId
            self.firstTimeLoaded = false
            self.tableView.reloadData()
        } else {
            self.btnSaveChanges.Disabled()
            self.selected = indexPath.row
            self.customerProgramId = customerProgramsItems[self.selected].intId
            self.firstTimeLoaded = false
            self.tableView.reloadData()
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: TenProgramTableViewCell.className, for: indexPath) as! TenProgramTableViewCell
//
//        cell.btnSelectedProgram.isEnabled = false
//        self.btnSaveChanges.Enabled()
//        self.selected = indexPath.row
//        self.customerProgramId = customerProgramsItems[self.selected].intId
//        self.firstTimeLoaded = false
//        self.tableView.reloadData()
    }
}

extension ChooseDelekTenProgramViewController {
    
    func requestSucceeded(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse, andInnerResponse innerResponse: BaseInnerResponse) {
        
        if request.requestName == TenRequestNames.getSetUserCustomerProgram {
            if let signUpVC = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: ChooseDelekTenProgramViewController.className) as? ChooseDelekTenProgramViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(signUpVC, animated: true)
            }
        }
    }
    
    func requestFailed(request: BaseRequest, withOuterResponse outerResponse: BaseOuterResponse) {
        
    }
}
