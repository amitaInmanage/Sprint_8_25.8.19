//
//  LoginViewController.swift
//  WelcomeInSwift
//
//  Created by inmanage on 14/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class LoginViewController: BaseFormViewController {
    
    @IBOutlet weak var imgVwPic: UIImageView!
    
    @IBOutlet weak var lblOr: RegularLabel!
    
    // Email
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var txtFldEmail: RegularTextField!
    @IBOutlet weak var lblErrorEmail: RegularLabel!
    
    // Password
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var txtFldPassword: RegularTextField!
    @IBOutlet weak var lblErrorPassword: RegularLabel!
    
    @IBOutlet weak var btnForgotPassword: RegularButton!
        
    @IBOutlet weak var cntrlRegister: IMControl!
    
    @IBOutlet weak var lblDontHaveAccount: RegularLabel!
    @IBOutlet weak var lblRegister: RegularLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupBaseLogin()
        
        ApplicationManager.sharedInstance.mainViewController.showBackButton(showBackButton: true, withBackActionDelegate: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getGANTScreenName() -> (String) {
        return self.className
    }
    
    // MARK: setupBaseLogin
    
    func setupBaseLogin() {
        
        self.txtFldEmail.tag = LoginVCTags.tagEmail
        self.txtFldPassword.tag = LoginVCTags.tagPassword
        
        self.lblErrorEmail.tag = Tags.errorLabelTag
        self.lblErrorPassword.tag = Tags.errorLabelTag
        
        self.txtFldEmail.delegate = self
        self.txtFldPassword.delegate = self
        
        self.txtFldEmail.keyboardType = .emailAddress
        
        self.txtFldPassword.isSecureTextEntry = true
        
        //Return keys
        self.txtFldEmail.returnKeyType = .next
        self.txtFldPassword.returnKeyType = .done
        
        self.firstResponderViewInLineTag = self.txtFldEmail.tag
        self.lastResponderViewInLineTag = self.txtFldPassword.tag
        
        self.arrResponderViews = [self.vwEmail, self.vwPassword]
        self.arrResponderTextViews = [self.txtFldEmail, self.txtFldPassword]
        
        self.txtFldEmail.textFieldInputType = TextFieldInputType.email
        self.txtFldPassword.textFieldInputType = TextFieldInputType.password
        
    }
    
    
    // MARK: IBActions
    
    @IBAction func didTapForgotPassword(_ sender: Any) {
        
        let popupInfoObj = PopupInfoObj()
        
        popupInfoObj.popupType = .restorePassword
        
        popupInfoObj.firstButtonActionWithObj = { (_ dataObject :Any) -> () in
            
            let strEmail = dataObject as! String
            
            let userAccountProcessObj = UserAccountProcessObj()
            userAccountProcessObj.strEmail = strEmail
            userAccountProcessObj.encryptEmailAndPassword = true
            
            ApplicationManager.sharedInstance.userAccountManager.callStartRestorePasswordWithUserAccountProcessObj(userAccountProcessObj: userAccountProcessObj, andRequestFinishedDelegate: nil)
        }
        
        ApplicationManager.sharedInstance.popupManager.createPopupVCWithPopupInfoObj(popupInfoObj: popupInfoObj, andPopupViewControllerDelegate: nil)
        
    }
    
    @IBAction func didTapFBLogin(_ sender: Any) {
        
        let userAccountProcessObj = UserAccountProcessObj()
        userAccountProcessObj.loginOrSignupAttemptType = .signupWithFacebook
        userAccountProcessObj.pushLoginAndSignupTabVC = false
        userAccountProcessObj.animate = false
        
        //change to facebookManager insted of user account manager because of a problem when pressing "finish" in facebook popup
        ApplicationManager.sharedInstance.userAccountManager.startProcess(processType: .login, processObj: userAccountProcessObj, processFinishedDelegate: self) { (processManager, processFinishedStatus) in
            
            if  processFinishedStatus == ProcessFinishedStatus.ProcessFinishedStatusSuccess {
                ApplicationManager.sharedInstance.mainViewController.popToHomeVC(resetAllTabsToRoot: true)
                
            } else {
               
                self.moveToSignupVC(proccessObj: processManager.processObj)
            }
        }
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        
        moveToSignupVC(proccessObj: nil)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        self.view.endEditing(true)
        
        self.resetArrResponderViewsFromErrorState()
        
        if !ApplicationManager.sharedInstance.inputValidationManager.validateAndHandleGUIForArrResponderViews(arrResponderViews: self.arrResponderViews, andRequiredFieldsErrorLabel: nil, allTextFieldControllers: self.allTextFieldControllers) {
            return
        }
        
        let userAccountProcessObj = UserAccountProcessObj()
        
        userAccountProcessObj.strEmail = self.txtFldEmail.text
        userAccountProcessObj.strPassword = self.txtFldPassword.text
        
        userAccountProcessObj.encryptEmailAndPassword = true
        
        userAccountProcessObj.loginOrSignupAttemptType = .loginWithEmail
        
        ApplicationManager.sharedInstance.userAccountManager.callLoginUserWithUserAccountProcessObj(userAccountProcessObj: userAccountProcessObj, andRequestFinishedDelegate: nil)
        
    }
    
    // MARK: General
    
    func setupUI() {
        
        self.view.backgroundColor = .white
        addTapGestureRecognizers()
    }
    
    func moveToSignupVC(proccessObj: BaseProcessObj?) {
        
        let signupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SignupViewController.className) as! SignupViewController
        
        if proccessObj != nil {
            signupVC.userObj = proccessObj! as! UserAccountProcessObj
            
        }
        
        ApplicationManager.sharedInstance.tabBarController.pushViewController(viewController: signupVC, animated: true)
        
    }
    
    func addTapGestureRecognizers() {
        
        
    }
    
    override func fillTextWithTrans() {
       
    }
    
}
