//
//  SignUpCarDetailsDelekTypeViewController.swift
//  Ten
//
//  Created by inmanage on 26/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpCarDetailsDelekTypeViewController: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case carNumber = 1
    }
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var lblSubTitle: RegularLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtFldCarNumber: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!
    
    var viewModel = SignUpCarDetailsDelekTypeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXibs()
        self.initializeUI()
        
    }
    
    func initializeUI() {
        self.initializeTextFields()
        self.btnContinue.Disabled()
        self.mDCTextSetUp(mDCText: self.txtFldCarNumber.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carInforamtionClubeLicense, Translations.Placeholders.carInforamtionClubeLicenseDefault), withIndex: self.txtFldCarNumber.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber, errorText: "" , addToolbar: true)
    }
    
    fileprivate func initializeTextFields() {
        self.txtFldCarNumber.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldCarNumber.txtFldInput.tag = TxtFldTag.carNumber.rawValue
            [txtFldCarNumber.txtFldInput].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.carInformationClub, Translations.Titles.carInformationClubDefault)
        self.lblSubTitle.text = Translation(Translations.SubTitles.carInformationClub, Translations.SubTitles.carInformationClubDefault)
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.btnConfirm, Translations.AlertButtonsKeys.btnConfirmDefault), for: .normal)
    }
    
    fileprivate func registerXibs() {
        self.collectionView.register(UINib(nibName: FuelTypeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: FuelTypeCollectionViewCell.className)
    }
    
    //MARK: text field delegate:
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        //Max length UITextField:
        if let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) {
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 8
        } else {
            return false
        }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let carNumber = txtFldCarNumber.txtFldInput.text, !carNumber.isEmpty
               else {
                  self.btnContinue.Disabled()
            return
        }
        self.validateCarnumberLength()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
          case TxtFldTag.carNumber.rawValue:
            self.viewModel.strCarNumber = textField.text ?? ""
        default:
            break;
        }
    }
    
    //Mark: IBAction:
    @IBAction func didTapContinueBtn(_ sender: Any) {
        if ApplicationManager.sharedInstance.userAccountManager.registrationToken.isEmpty {
            self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
        }else {
            self.viewModel.buildJsonAndSendUpdateRegistrationData(strScreenName: self.viewModel.screenName)
        }
    }
}

extension SignUpCarDetailsDelekTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt  indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FuelTypeCollectionViewCell.className, for: indexPath) as! FuelTypeCollectionViewCell
        cell.imgDelekType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOff, withAddUnderscoreIphone: false)
        if indexPath.item == self.viewModel.selectedIndexPath {
            cell.imgDelekType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOn, withAddUnderscoreIphone: false)
        } else {
           cell.imgDelekType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOff, withAddUnderscoreIphone: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.validateSelectedFuelType()
        self.viewModel.selectedIndexPath = indexPath.item
        let code = self.viewModel.data[indexPath.item].strCode
        self.viewModel.strCode = code
        self.collectionView.reloadData()
    }
}

extension SignUpCarDetailsDelekTypeViewController {
    
    func validateSelectedFuelType() {
        
        if self.viewModel.isCarNumberValid {
            self.viewModel.isSelecTedFuelType = true
            self.btnContinue.Enabled()
        } else {
            self.viewModel.isSelecTedFuelType = true
            self.btnContinue.Disabled()
        }
    }
    
    func validateCarnumberLength() {
        if txtFldCarNumber.txtFldInput.text!.count > 6 && self.viewModel.isSelecTedFuelType {
            self.viewModel.isCarNumberValid = true
            self.btnContinue.Enabled()
            
        } else if txtFldCarNumber.txtFldInput.text!.count > 6 && self.viewModel.isSelecTedFuelType == false {
            self.viewModel.isCarNumberValid = true
            self.btnContinue.Disabled()
            
        } else {
            self.btnContinue.Disabled()
            self.viewModel.isCarNumberValid = false
        }
    }
}
