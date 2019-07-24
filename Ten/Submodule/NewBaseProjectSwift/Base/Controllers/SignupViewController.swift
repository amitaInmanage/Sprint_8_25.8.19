//
//  SignupViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class SignupViewController: BaseFormViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cntrlAddPic: IMControl!
    @IBOutlet weak var cntrlLogin: IMControl!
    
    @IBOutlet weak var imgVwPic: UIImageView!
    // First Name
    @IBOutlet weak var vwFirstName: UIView!
    @IBOutlet weak var txtFldFirstName: RegularTextField!
    @IBOutlet weak var lblErrorFirstName: RegularLabel!
    
    // Last Name
    @IBOutlet weak var vwLastName: UIView!
    @IBOutlet weak var txtFldLastName: RegularTextField!
    @IBOutlet weak var lblErrorLastName: RegularLabel!
    
    // Phone
    @IBOutlet weak var vwPhone: UIView!
    @IBOutlet weak var txtFldPhone: RegularTextField!
    @IBOutlet weak var lblErrorPhone: RegularLabel!
    
    // Email
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var txtFldEmail: RegularTextField!
    @IBOutlet weak var lblErrorEmail: RegularLabel!
    
    // Password
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var txtFldPassword: RegularTextField!
    @IBOutlet weak var lblErrorPassword: RegularLabel!
    
    // Rewrite Password
    @IBOutlet weak var vwRewritePassword: UIView!
    @IBOutlet weak var txtFldRewritePassword: RegularTextField!
    @IBOutlet weak var lblErrorRewritePassword: RegularLabel!
    
    // BirthDate
    @IBOutlet weak var vwBirthDate: UIView!
    @IBOutlet weak var txtBirthDate: RegularTextField!
    @IBOutlet weak var lblErrorBirthDate: RegularLabel!
    
    @IBOutlet weak var lblAfterSignupTxt: RegularLabel!
    
    @IBOutlet weak var lblAgreeTerms: RegularLabel!
    @IBOutlet weak var btnAgreeTerms: UIButton!
    
    @IBOutlet weak var lblErrorAgreeTerms: RegularLabel!
    @IBOutlet weak var lblAgreeEmails: RegularLabel!
    @IBOutlet weak var btnAgreeEmails: UIButton!
    
    @IBOutlet weak var lblAlreadyHaveAccount: RegularLabel!
    @IBOutlet weak var lblLogin: RegularLabel!
    
    var userObj: UserAccountProcessObj!
    
    let imagePicker = UIImagePickerController()
    var currentStrBase64 = ""

    let datePicker = UIDatePicker()
    var dateSaved: Date?
    let alertControllerImagePicker = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupBaseRegister()
                
        ApplicationManager.sharedInstance.mainViewController.showBackButton(showBackButton: true, withBackActionDelegate: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func getGANTScreenName() -> (String) {
        return self.className
    }
    
    // MARK: setUpBaseRegister
    
    func setupBaseRegister() {

        self.txtFldFirstName.tag = SingupVCTags.tagFirstName
        self.txtFldLastName.tag = SingupVCTags.tagLastName
        self.txtFldPhone.tag = SingupVCTags.tagPhone
        self.txtFldEmail.tag = SingupVCTags.tagEmail
        self.txtFldPassword.tag = SingupVCTags.tagPassword
        self.txtFldRewritePassword.tag = SingupVCTags.tagRewritePassword
        self.txtBirthDate.tag = SingupVCTags.tagBirthDate
        
        self.lblErrorFirstName.tag = Tags.errorLabelTag
        self.lblErrorLastName.tag = Tags.errorLabelTag
        self.lblErrorPhone.tag = Tags.errorLabelTag
        self.lblErrorEmail.tag = Tags.errorLabelTag
        self.lblErrorPassword.tag = Tags.errorLabelTag
        self.lblErrorRewritePassword.tag = Tags.errorLabelTag
        self.lblErrorBirthDate.tag = Tags.errorLabelTag
        
        self.txtFldFirstName.delegate = self
        self.txtFldLastName.delegate = self
        self.txtFldPhone.delegate = self
        self.txtFldEmail.delegate = self
        self.txtFldPassword.delegate = self
        self.txtFldRewritePassword.delegate = self
        self.txtBirthDate.delegate = self
        
        self.txtFldEmail.keyboardType = .emailAddress
        self.txtFldPhone.keyboardType = .phonePad
        
        self.txtFldFirstName.autocapitalizationType = .words
        self.txtFldLastName.autocapitalizationType = .words
        
        self.txtFldPassword.isSecureTextEntry = true
        self.txtFldRewritePassword.isSecureTextEntry = true
        
        //Return keys
        self.txtFldFirstName.returnKeyType = .next
        self.txtFldLastName.returnKeyType = .next
        self.txtFldPhone.returnKeyType = .next
        self.txtFldEmail.returnKeyType = .next
        self.txtFldPassword.returnKeyType = .next
        self.txtFldRewritePassword.returnKeyType = .next
        self.txtBirthDate.returnKeyType = .done
        
        
        self.firstResponderViewInLineTag = self.txtFldFirstName.tag
        self.lastResponderViewInLineTag = self.txtBirthDate.tag

        if self.userObj != nil {
            
            self.arrResponderViews = [self.vwFirstName, self.vwLastName, self.vwPhone, self.vwEmail, self.vwBirthDate]
            self.arrResponderTextViews = [self.txtFldFirstName, self.txtFldLastName, self.txtFldPhone, self.txtFldEmail, self.txtBirthDate]
            
        } else {
            
            self.arrResponderViews = [self.vwFirstName, self.vwLastName, self.vwPhone, self.vwEmail, self.vwPassword, self.vwRewritePassword, self.vwBirthDate]
            self.arrResponderTextViews = [self.txtFldFirstName, self.txtFldLastName, self.txtFldPhone, self.txtFldEmail, self.txtFldPassword, self.txtFldRewritePassword, self.txtBirthDate]

        }
        
        self.txtFldFirstName.textFieldInputType = TextFieldInputType.name
        self.txtFldLastName.textFieldInputType = TextFieldInputType.name
        self.txtFldPhone.textFieldInputType = TextFieldInputType.mobilePhoneNumber
        self.txtFldEmail.textFieldInputType = TextFieldInputType.email
        self.txtFldPassword.textFieldInputType = TextFieldInputType.password
        self.txtFldRewritePassword.textFieldInputType = TextFieldInputType.rewritePassword
        
        self.addToolBarToResponderView(responderView: self.txtFldPhone, withAddNext: true)
        
        updateViewForFacebookLogin()
        
    }

    func updateViewForFacebookLogin() {
        
        if self.userObj != nil {
            
            self.txtFldFirstName.text = self.userObj.strFirstName
            self.txtFldLastName.text = self.userObj.strLastName
            self.txtFldEmail.text = self.userObj.strEmail
            
            if let strPic = self.userObj.strPicture {
                self.imgVwPic.setImageWithStrURL(strURL: strPic, withAddUnderscoreIphone: false)
                self.cntrlAddPic.isHidden = true
            }
            
            
            self.vwPassword.isHidden = true
            self.vwRewritePassword.isHidden = true
        }
        
    }
    // MARK: IBActions
    
    @IBAction func didTapAddPhoto(_ sender: Any) {
        
        self.view.endEditing(true)

        ApplicationManager.sharedInstance.navigationController.present(self.alertControllerImagePicker, animated: true)

    }
    
    @IBAction func didTapFBLogin(_ sender: Any) {

        let userAccountProcessObj = UserAccountProcessObj()
        userAccountProcessObj.loginOrSignupAttemptType = .signupWithFacebook
        userAccountProcessObj.pushLoginAndSignupTabVC = false
        userAccountProcessObj.animate = false

        ApplicationManager.sharedInstance.userAccountManager.startProcess(processType: .signup, processObj: userAccountProcessObj, processFinishedDelegate: self) { (processManager, processFinishedStatus) in

            if  processFinishedStatus == ProcessFinishedStatus.ProcessFinishedStatusSuccess {

                ApplicationManager.sharedInstance.mainViewController.popToHomeVC(resetAllTabsToRoot: true)
                
            } else {
                
                self.userObj = processManager.processObj as! UserAccountProcessObj
                
                self.setupBaseRegister()
                
            }
        }
        
    }
    
    @IBAction func didTapRegister(_ sender: Any) {

        self.view.endEditing(true)
        
        self.resetArrResponderViewsFromErrorState()
        
        if  !ApplicationManager.sharedInstance.inputValidationManager.validateAndHandleGUIForArrResponderViews(arrResponderViews: self.arrResponderViews, andRequiredFieldsErrorLabel: nil, allTextFieldControllers: self.allTextFieldControllers) {

            if !self.btnAgreeTerms.isSelected {
                self.lblErrorAgreeTerms.isHidden = false
            }
            return
        }
        
        if !self.btnAgreeTerms.isSelected {
            self.lblErrorAgreeTerms.isHidden = false
            return;
        } else{
            self.lblErrorAgreeTerms.isHidden = true
        }
        
        let userAccountProcessObj = UserAccountProcessObj()
        
        userAccountProcessObj.strFirstName = self.txtFldFirstName.text
        userAccountProcessObj.strLastName = self.txtFldLastName.text
        userAccountProcessObj.strMobilePhoneNumber = self.txtFldPhone.text
        userAccountProcessObj.strEmail = self.txtFldEmail.text
        userAccountProcessObj.terms = self.btnAgreeTerms.isSelected
        userAccountProcessObj.advertisement = self.btnAgreeEmails.isSelected
        userAccountProcessObj.encryptEmailAndPassword = true

        if let aDateSaved = self.dateSaved {

           userAccountProcessObj.birthdayTS = ApplicationManager.sharedInstance.timeManager.getTSFrom(date: aDateSaved)
        }
        
        if self.userObj != nil {
            
            //sign up with facebook
            
            userAccountProcessObj.loginOrSignupAttemptType = .signupWithFacebook
            
            userAccountProcessObj.strFBId = self.userObj.strFBId
            userAccountProcessObj.strFBAccessToken = self.userObj.strFBAccessToken
            
        } else{
            
            //sign up with email
            
            userAccountProcessObj.strPassword = self.txtFldPassword.text
            
            userAccountProcessObj.loginOrSignupAttemptType = .signupWithEmail
            
        }
        
        ApplicationManager.sharedInstance.userAccountManager.callAddUserWithUserAccountProcessObj(userAccountProcessObj: userAccountProcessObj, andRequestFinishedDelegate: nil)

    }
    
    @IBAction func didTapLogin(_ sender: Any) {

        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
        
        ApplicationManager.sharedInstance.tabBarController.pushViewController(viewController: loginVC, animated: true)
        
    }
    
    @IBAction func didTapAgreeTerms(_ sender: Any) {
        
        self.view.endEditing(true)

        if let btn = sender as? UIButton {
            btn.isSelected = !btn.isSelected
            if btn.isSelected {
                self.lblErrorAgreeTerms.isHidden = true
            }
        }
    }
    
    @IBAction func didTapAgreeEmails(_ sender: Any) {
        
        self.view.endEditing(true)

        if let btn = sender as? UIButton {
            btn.isSelected = !btn.isSelected
        }
    }
    @IBAction func didTapTermsLbl(_ sender: UIButton) {
        
    }
    
    // MARK: General
    
    func setupUI() {
        
        self.setupAlertActionSheet()
        self.view.backgroundColor = .white

        self.imgVwPic.layer.cornerRadius = self.imgVwPic.frame.size.width / 2
        self.imgVwPic.clipsToBounds = true
        
        setupDatePicker()
        setupTextFieldBirthdate()
        self.imagePicker.delegate = self
        
        addTapGestureRecognizers()
    }
    
    func addTapGestureRecognizers() {

    }
    
    override func fillTextWithTrans() {
       
    }
    
    func openGallary() {
        ApplicationManager.sharedInstance.navigationController.present(self.alertControllerImagePicker, animated: true)
    }
    
    func setupAlertActionSheet() {

        
    }
    
    func setupDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.timeZone = Calendar.current.timeZone
        self.datePicker.locale = Calendar.current.locale
        
        let calendar = ApplicationManager.sharedInstance.timeManager.getCalendar()
        let components: NSDateComponents = NSDateComponents()
        
        components.year = -100
        let minDate = calendar.date(byAdding: components as DateComponents, to: ApplicationManager.sharedInstance.timeManager.getCurrentServerDate())
        
        components.year = -25
        if let currentDate = calendar.date(byAdding: components as DateComponents, to: ApplicationManager.sharedInstance.timeManager.getCurrentServerDate()) {
            
            self.datePicker.date = currentDate

        }

        self.datePicker.maximumDate = ApplicationManager.sharedInstance.timeManager.getCurrentServerDate()
        self.datePicker.minimumDate = minDate
        
        self.datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapOpenMonthPicker))
        //self.vwMonth.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func setupTextFieldBirthdate() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.didTapCancelDate))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.didTapDoneDate))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.txtBirthDate.hideCaret = true
        self.txtBirthDate.inputView = self.datePicker
        self.txtBirthDate.inputAccessoryView = toolBar
        
    }

    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ApplicationManager.sharedInstance.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        var strBase64 = ""
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let croppedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            
            if croppedImage != nil {
                
                self.imgVwPic.image = croppedImage
                let smallImage = ApplicationManager.sharedInstance.gUIManager.scaleImage(image: croppedImage!, maxWidth: 300, maxHeight: 300)
                
                let imageData = UIImageJPEGRepresentation(smallImage!, 1)
                strBase64 = imageData!.base64EncodedString(options: .init(rawValue: 0))
                
            } else {
                
                self.imgVwPic.image = pickedImage
                
                let smallImage = ApplicationManager.sharedInstance.gUIManager.scaleImage(image: pickedImage, maxWidth: 300, maxHeight: 300)
                
                let imageData = UIImageJPEGRepresentation(smallImage!, 1)
                strBase64 = imageData!.base64EncodedString(options: .init(rawValue: 0))
                
            }
            
            self.view.layoutIfNeeded()
            
            if !strBase64.isEmpty {
                currentStrBase64 = strBase64
            }
        }
        self.cntrlAddPic.isHidden = true
        
        ApplicationManager.sharedInstance.navigationController.dismiss(animated: true, completion: nil)
    }

    
    // MARK : - date View Picker
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        self.dateSaved = sender.date
        
    }
    
    @objc func didTapDoneDate() {
        self.view.endEditing(true)
        
        if let aDateSaved = self.dateSaved {
            self.txtBirthDate.text = ApplicationManager.sharedInstance.timeManager.getFullDateString(from: aDateSaved)
        } else {
            self.txtBirthDate.text = ApplicationManager.sharedInstance.timeManager.getFullDateString(from: self.datePicker.date)

        }
    }
    
    @objc func didTapCancelDate() {
        self.view.endEditing(true)
    }

}
