//
//  RegisterCarViewController.swift
//  Ten
//
//  Created by shani daniel on 25/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//


import UIKit
import MaterialComponents.MaterialTextFields


class CarInformationFcPrivateViewController: BaseFormViewController { 
    
    @IBOutlet weak var buttonsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: RegularLabel!
    @IBOutlet weak var vwId: InputCustomView!
    @IBOutlet weak var vwCarNumber: InputCustomView!
    @IBOutlet weak var lblFuelType: RegularLabel!
    @IBOutlet weak var imgFuelType: UIImageView!
    @IBOutlet weak var btnNext: TenButtonStyle!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var fuelTypeVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addObservers()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeObservers()
        
    }
    
    func setupRegisterCarVCTags() {
        
        self.vwId.txtFldInput.tag = RegisterCarVCTags.tagId
        self.vwCarNumber.txtFldInput.tag = RegisterCarVCTags.tagCardNumber
        
    }
    
    
    func setupUI() {
        
        self.btnNext.isEnabled = true
        
        setupRegisterCarVCTags()
        
        // Id text fiald
        let strIdPlaceholder = Translation(RegisterCarVCTranslations.txtPlaceholderId, RegisterCarVCTranslations.txtPlaceholderIdDefault)
        
        let strErrorId = Translation(RegisterCarVCTranslations.txtErrorId, RegisterCarVCTranslations.txtErrorIdDefault)
        
        self.mDCTextSetUp(mDCText: self.vwId.txtFldInput, withPlaceholderText: strIdPlaceholder, withIndex: self.vwId.txtFldInput.tag, withKeyboardType: .numberPad , withKeyType: .next, txtFldInputType: .generalNumbericNumber , errorText: strErrorId, addToolbar: true)
        
        // Car number text fiald
        let strCarNumberPlaceholder = Translation(RegisterCarVCTranslations.txtPlaceholderCarNumber, RegisterCarVCTranslations.txtPlaceholderCarNumberDefault)
        
        let strErrorCarNumber =  Translation(RegisterCarVCTranslations.txtErrorCarNumber , RegisterCarVCTranslations.txtErrorCarNumberDefault)
        
        self.mDCTextSetUp(mDCText: self.vwCarNumber.txtFldInput, withPlaceholderText: strCarNumberPlaceholder, withIndex: self.vwCarNumber.txtFldInput.tag, withKeyboardType: .numberPad, withKeyType: .done, txtFldInputType: .carNumber, errorText: strErrorCarNumber, addToolbar: true)
       
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @IBAction func didTapNext(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        self.resetArrResponderViewsFromErrorState()
        
        if !ApplicationManager.sharedInstance.inputValidationManager.validateAndHandleGUIForArrResponderViews(arrResponderViews: self.arrResponderViews, andRequiredFieldsErrorLabel: nil, allTextFieldControllers: self.allTextFieldControllers) { return }
        
        
        if let nextViewConteroller = UIStoryboard.init(name: "Login", bundle: Bundle.main).instantiateViewController(withIdentifier: RegisterTenCardViewController.className) as? RegisterTenCardViewController {
            self.navigationController?.pushViewController(nextViewConteroller, animated: true)
        }
        
    }
    
    override func fillTextWithTrans() {
        
        self.lblTitle.text = Translation(RegisterCarVCTranslations.lblTitle, RegisterCarVCTranslations.lblTitleDefault)
        
        self.btnNext.setTitle(Translation(RegisterCarVCTranslations.btnNext, RegisterCarVCTranslations.btnNextDefault), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - UIKeyboardNotifications
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let tabBarHeight = self.tabBarController != nil ? (self.tabBarController?.tabBar.height())! : 0
            print("\(keyboardSize.height) -- \(self.buttonsConstraint.constant)")
            if self.buttonsConstraint.constant != keyboardSize.height - tabBarHeight{
                print("changed")
                self.buttonsConstraint.constant = keyboardSize.height - tabBarHeight
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.buttonsConstraint.constant != 29 {
                
                self.buttonsConstraint.constant = 29
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    
}



