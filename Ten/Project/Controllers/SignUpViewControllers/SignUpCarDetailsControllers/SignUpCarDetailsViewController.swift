//
//  SignUpCarDetailsViewController.swift
//  Ten
//
//  Created by inmanage on 30/05/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

class SignUpCarDetailsViewController: BaseFormViewController {
    
    enum TxtFldTag: Int {
        case carNumber = 1
        case idNumber = 2
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: MediumText!
    @IBOutlet weak var lblSubtitle: MediumText!
    @IBOutlet weak var txtFldCarNumber: InputCustomView!
    @IBOutlet weak var txtFldIdNumber: InputCustomView!
    @IBOutlet weak var btnContinue: TenButtonStyle!

    var viewModel = SignUpCarDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        self.updateUI()
    }
    
    func initializeUI() {
        self.registerXibs()
        self.setupTextFields()
        
        self.mDCTextSetUp(mDCText: self.txtFldCarNumber.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carInformationClubLicensePlate, Translations.Placeholders.carInformationClubLicensePlateDefault), withIndex: self.txtFldCarNumber.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
        self.mDCTextSetUp(mDCText: self.txtFldIdNumber.txtFldInput, withPlaceholderText: Translation(Translations.Placeholders.carInformationClubeId, Translations.Placeholders.carInformationClubeIdDefault), withIndex: self.txtFldIdNumber.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .done, txtFldInputType: .generalNumbericNumber , errorText: "", addToolbar: true)
        
    }
    
    func updateUI() {
        self.txtFldCarNumber.txtFldInput.text = self.viewModel.strLicensePlateRO
        self.txtFldCarNumber.isUserInteractionEnabled = !self.viewModel.readOnly
        self.txtFldIdNumber.txtFldInput.text = self.viewModel.strIdNumberRO
        self.txtFldIdNumber.isUserInteractionEnabled = !self.viewModel.readOnly
    }
    
    override func fillTextWithTrans() {
        self.lblTitle.text = Translation(Translations.Titles.carInformationClub, Translations.Titles.carInformationClubDefault)
        self.lblSubtitle.text = Translation(Translations.SubTitles.carInformationClub, Translations.SubTitles.carInformationClubDefault)
        self.btnContinue.setTitle(Translation(Translations.AlertButtonsKeys.next, Translations.AlertButtonsKeys.nextDefault), for: .normal)
    }
    
    fileprivate func registerXibs() {
        self.collectionView.register(UINib(nibName: FuelTypeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: FuelTypeCollectionViewCell.className)
    }
    
    fileprivate func setupTextFields() {
        self.txtFldCarNumber.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldIdNumber.txtFldInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txtFldCarNumber.txtFldInput.tag = TxtFldTag.carNumber.rawValue
        self.txtFldIdNumber.txtFldInput.tag = TxtFldTag.idNumber.rawValue
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        switch textField.tag {
        case TxtFldTag.carNumber.rawValue:
            self.viewModel.strCarNumber = textField.text ?? ""
        case TxtFldTag.idNumber.rawValue:
            self.viewModel.strIdNumber = textField.text ?? ""
        default:
            break;
        }
        
        if self.viewModel.validateIdNumber(strIdNumber: self.viewModel.strIdNumber) &&
            self.viewModel.validateLicensePlat(strLicensePlate: self.viewModel.strCarNumber) {
            self.btnContinue.Enabled()
        } else {
            self.btnContinue.Disabled()
        }
    }
    
    //Mark: IBAction:
    @IBAction func didTapContinueBtn(_ sender: Any) {
        if ApplicationManager.sharedInstance.userAccountManager.registrationToken.isEmpty {
            self.viewModel.buildJsonAndSendUpdateNewFuelingDeviceProcessData(strScreenName: self.viewModel.screenName)
        } else {
            self.viewModel.buildJsonAndSendUpdateRegistrationData(strScreenName: self.viewModel.screenName)
        }
    }
}

extension SignUpCarDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FuelTypeCollectionViewCell.className, for: indexPath) as! FuelTypeCollectionViewCell
        
        cell.imgDelekType.setImageWithStrURL(strURL: self.viewModel.data[indexPath.item].strIconOff, withAddUnderscoreIphone: false)
        
        let isSelected = self.viewModel.data[indexPath.item].strCode == self.viewModel.strCode
        let fuelType = self.viewModel.data[indexPath.item]
        let resuelt = isSelected ? fuelType.strIconOn : fuelType.strIconOff
        
        cell.imgDelekType.setImageWithStrURL(strURL: resuelt, withAddUnderscoreIphone: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.viewModel.strCode = self.viewModel.data[indexPath.item].strCode
        self.collectionView.reloadData()
    }
}

