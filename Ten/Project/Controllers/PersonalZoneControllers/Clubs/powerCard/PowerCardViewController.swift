//
//  PowerCardViewController.swift
//  Ten
//
//  Created by Amit on 12/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class PowerCardViewController: BaseFormViewController {
    @IBOutlet weak var lblTitle: MediumLabel!
    @IBOutlet weak var vwTitle: UIView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblPowerCard: MediumLabel!
    @IBOutlet weak var lblAmount: RegularLabel!
    @IBOutlet weak var btnLogin: TenButtonStyle!
    @IBOutlet weak var vwContentHC: NSLayoutConstraint!
    
    var viewModel = PowerCardViewModel()
    var hasPowarCard = ApplicationManager.sharedInstance.userAccountManager.user.powerCardArr.isHasCard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
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
        self.vwTitle.addShadowAndCorner()
        self.vwContent.addShadowAndCorner()
        self.view.backgroundColor = .clear
        if hasPowarCard {
            self.vwContent.isHidden = false
            self.lblAmount.text = ApplicationManager.sharedInstance.userAccountManager.user.powerCardArr.strBudget
        } else {
            self.vwContentHC.constant = 30
            view.layoutIfNeeded()
            self.vwContent.isHidden = true
        }
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.powerCard, Translations.Titles.powerCardDefault)
        self.lblPowerCard.text = Translation(Translations.Titles.powercardAccumulation, Translations.Titles.powercardAccumulationDefault)
        if hasPowarCard {
             self.btnLogin.setTitle(Translation(Translations.AlertButtonsKeys.powercardDisconnect, Translations.AlertButtonsKeys.powercardDisconnectDefault), for: .normal)
        } else {
            self.btnLogin.setTitle(Translation(Translations.AlertButtonsKeys.powercardConnect, Translations.AlertButtonsKeys.powercardConnectDefault), for: .normal)
        }
    }
    @IBAction func didTapLoginLogoutBtn(_ sender: Any) {
          if hasPowarCard {
            self.viewModel.showPopup()
          } else {
            if let personalZone = UIStoryboard.init(name: "PersonalZone", bundle: Bundle.main).instantiateViewController(withIdentifier: AddPowerCardViewController.className) as? AddPowerCardViewController {
                ApplicationManager.sharedInstance.navigationController.pushTenViewController(personalZone, animated: true)
            }
        }
    }
}
