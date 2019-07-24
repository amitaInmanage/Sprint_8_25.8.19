//
//  My accumulation My accumulation MyAccumulationTableViewCell.swift
//  Ten
//
//  Created by inmanage on 10/07/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class MyAccumulationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSavingNIS: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnTop: TenButtonStyle!
    @IBOutlet weak var btnButtom: IMButton!
    @IBOutlet weak var vw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vw.addShadow()
        initUI()
    }
    
    fileprivate func initUI() {
        //TODO: put trye value in this label
//        self.lblSavingNIS.text = 
        self.lblTitle.text = Translation(Translations.Titles.myAccumulationTitle, Translations.Titles.myAccumulationTitleDefault)
        self.btnButtom.addUnderline(title: Translation(Translations.AlertButtonsKeys.myAccumulationExplain, Translations.AlertButtonsKeys.myAccumulationExplainDefault))
        self.btnButtom.tintColor = UIColor.getApplicationThemeColor()
        self.btnTop.setTitle(Translation(Translations.AlertButtonsKeys.payInStor, Translations.AlertButtonsKeys.payInStorDefault), for: .normal)
        self.btnTop.setReverseColor(textColor: UIColor.getApplicationThemeColor())
        self.btnTop.setWhiteBackground()
        self.selectionStyle = UITableViewCell.SelectionStyle.none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //IBAction:
    @IBAction func didTapTopButton(_ sender: Any) {
        //TODO: send to stor
    }
    
    @IBAction func didTapBottomButton(_ sender: Any) {
        //TODO: ?
    }
}
