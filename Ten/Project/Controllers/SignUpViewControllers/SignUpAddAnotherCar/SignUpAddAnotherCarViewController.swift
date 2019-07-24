//
//  SignUpAddAnotherCarViewController.swift
//  Ten
//
//  Created by inmanage on 02/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpAddAnotherCarViewController: BaseFormViewController {
    
    @IBOutlet weak var imgTop: UIImageView!
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: RegularLabel!
    @IBOutlet weak var btnAddCar: TenButtonStyle!
    @IBOutlet weak var btnRegisterSuccess: TenButtonStyle!
    
    var viewModel = SignUpAddAnotherCarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if let vc = parent as? TenStyleViewController {
             vc.navigationItem.hidesBackButton = true
        }
    }
    
    fileprivate func initializeUI() {
        self.imgTop.image = UIImage(named: "confetti")
        self.btnAddCar.setWhiteBackground()
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.registerSuccess, Translations.Titles.registerSuccessDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.registerSuccess, Translations.SubTitles.registerSuccessDefault)
        self.btnAddCar.setTitle(Translation(Translations.AlertButtonsKeys.addCar, Translations.AlertButtonsKeys.addCarDefault), for: .normal)
        self.btnRegisterSuccess.setTitle(Translation(Translations.AlertButtonsKeys.registerSuccess, Translations.AlertButtonsKeys.registerSuccessDefault), for: .normal)
    }
    
    //IBOutlet:
    @IBAction func didTapAddCar(_ sender: Any) {
        //TODO: send to private area
    }
    
    @IBAction func didTapRegisterSuccess(_ sender: Any) {
        self.viewModel.moveToTenGeneral()
    }
}
