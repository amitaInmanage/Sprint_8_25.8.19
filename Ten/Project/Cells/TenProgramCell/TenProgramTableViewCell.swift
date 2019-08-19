//
//  TenProgramTableViewCell.swift
//  Ten
//
//  Created by Amit on 13/08/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

protocol SelectedProgramDelegate: NSObject {
    func didTapSelectedProgram(sender: UIButton)
}

protocol DropDownDelegate: NSObject {
    func didTapDropDown()
}

class TenProgramTableViewCell: UITableViewCell {
        
    @IBOutlet weak var dropDownHC: NSLayoutConstraint!
    @IBOutlet weak var vwProgram: UIView!
    @IBOutlet weak var vwDropDown: UIView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var dropDownHeigtConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnDropDown: IMButton!
    @IBOutlet weak var btnSelectedProgram: IMButton!
    @IBOutlet weak var lblTitleProgram: MediumLabel!
    @IBOutlet weak var lblProgramDetails: RegularLabel!
    @IBOutlet weak var lblSubTitleFuel: MediumLabel!
    @IBOutlet weak var lblFuelAssumption: RegularLabel!
    @IBOutlet weak var lblSubTitleAroundCar: MediumLabel!
    @IBOutlet weak var lblAroundCarAssumption: RegularLabel!
    @IBOutlet weak var lblSubTitleStores: MediumLabel!
    @IBOutlet weak var lblStoresAssumption: RegularLabel!
    @IBOutlet weak var lblProgramDetailsDropDown: RegularLabel!
    
    weak var dropDownDelegate: DropDownDelegate?
    weak var selectedProgramDelegate: SelectedProgramDelegate?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
        self.dropDownHeigtConstraint.constant = 94
        self.vwDropDown.isHidden = true
    }
    
    fileprivate func initUI() {
        self.selectionStyle = .none
        
        self.lblSubTitleFuel.text = Translation(Translations.Titles.delekTenChooseProgramRowDiscountDelek, Translations.Titles.delekTenChooseProgramRowDiscountDelekDefault)
        
        self.lblSubTitleAroundCar.text = Translation(Translations.Titles.delekTenChooseProgramRowDiscountCar, Translations.Titles.delekTenChooseProgramRowDiscountCarDefault)
        
        self.lblSubTitleStores.text = Translation(Translations.Titles.delekTenChooseProgramRowDiscountStore, Translations.Titles.delekTenChooseProgramRowDiscountStoreDefault)
    }
    
    //MARK - IBAction :
    @IBAction func didTapSelectadProgram(_ sender: Any) {
        if let delegate = selectedProgramDelegate {
            delegate.didTapSelectedProgram(sender: sender as! UIButton)
        }
    }
    
    @IBAction func didTapDropDown(_ sender: Any) {
        
        if self.btnDropDown.image(for: .normal) == UIImage(named: "down") {
            
            UIView.animate(withDuration: 0.3) {
                self.btnDropDown.setImage(UIImage(named: "up"), for: .normal)
                self.vwDropDown.isHidden = false
                self.dropDownHeigtConstraint.constant = 250
                self.layoutIfNeeded()
            }
        } else if  self.btnDropDown.image(for: .normal) == UIImage(named: "up") {
            
            UIView.animate(withDuration: 0.3) {
                self.btnDropDown.setImage(UIImage(named: "down"), for: .normal)
                self.vwDropDown.isHidden = true
                self.dropDownHeigtConstraint.constant = 94
                self.layoutIfNeeded()

            }
        }
        if let delegate = dropDownDelegate {
            delegate.didTapDropDown()
        }
    }
}
