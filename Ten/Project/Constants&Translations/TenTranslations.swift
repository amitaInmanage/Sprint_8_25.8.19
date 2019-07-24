//
//  TenTranslations.swift
//  Ten
//
//  Created by shani daniel on 02/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import Foundation

struct LoginTranslations {
    
    static let phonePlaceHolder = "login_get_phone"
    static let lblTitle = "login_title"
    static let lblSubTitle = "login_sub_title"
    static let btnNext = "login_btn_next"
    static let btnNoLoginNext = "login_btn_no_login_next"
    static let errorPhone = "login_phone_error"
    
    static let lblTitleDefault = "אנא הזן מספר נייד שלך"
    static let lblSubTitleDefault = "נשלח לך סמס עם קוד חד פעמי"
    static let btnNextDefault = "המשך"
    static let btnNoLoginNextDefault = "המשך ללא התחברות"
    static let phonePlaceHolderDefault = "מספר נייד"
    static let errorPhoneDefault = "מספר נייד אינו תקין"
}

struct RegisterNameTranslations {
    
    static let lblTitle = "registername_title"
    static let btnNext = "registername_btn_next"
    static let firstNamePlaceholder = "register_name_first_name_placeholder"
    static let lastNamePlaceholder = "register_name_last_name_placeholder"
    static let errorFirstName = "registername_first_name_error"
    static let errorLastName = "registername_last_name_error"
    
    static let lblTitleDefault = "נשמח לדעת מה שמך?"
    static let btnNextDefault = "המשך"
    static let firstNamePlaceholderDefault = "שם פרטי"
    static let lastNamePlaceholderDefault = "שם משפחה"
    static let errorFirstNameDefault = "שם פרטי אינו תקין"
    static let errorLastNameDefault = "שם משפחה אינו תקין"
}

struct RegisterCodeValidationTranslations {
    
    static let lblTitle = "registercodevalidation_title"
    static let lblSubTitle = "registercodevalidation_sub_title"
    static let btnResendSms = "registercodevalidation_btn_not_get_code"
    static let btnContactUs = "registercodevalidation_btn_contact_us"
    static let btnSmsSent = "registercodevalidation_already_send"
    static let btnSendingSms = "registercodevalidation_sending_sns"
    
    static let lblTitleDefault = "הזן את הקוד שקיבלת בבקשה"
    static let lblSubTitleDefault = "קוד נשלח בהצלחה למספר"
    static let btnResendSmsDefault = "לא קיבלתי, שלח שוב"
    static let btnContactUsDefault = "נתקל בבעיה? צור קשר"
    static let btnSmsSentDefault = "נשלח!"
    static let btnSendingSmsDefault = "שולח.."

}

struct PinCodeVCTranslations {
    
    static let lblInsertTitle = "insert_pin_code_title"
    static let lblInsertSubTitle = "insert_pin_code_sub_title"
    static let btnInsertConfirm = "insert_pin_code_submit_btn"
    static let lblVerifyTitle = "verify_pin_code_title"
    static let lblVerifySubTitle = "verify_pin_code_sub_title"
    static let btnVerifyConfirm = "verify_pin_code_submit_btn"
    static let lblVerifyError = "verify_pin_code_error"
    
    static let lblInsertTitleDefault = "סיסמה בת 4 ספרות"
    static let lblInsertSubTitleDefault = "בחר סיסמה"
    static let btnInsertConfirmDefault = "המשך"
    static let lblVerifyTitleDefault = "סיסמה בת 4 ספרות"
    static let lblVerifySubTitleDefault = "אמת סיסמה"
    static let btnVerifyConfirmDefault = "המשך"
    static let lblVerifyErrorDefault = "סיסמה לא תקינה"
    
}

struct ExtraSecurityVCTranslations {
    
    static let lblTitle = "extra_security_title"
    static let lblSubTitle = "extra_security_sub_title"
    static let btnConfirm = "extra_security_submit_btn"
    static let btnSkip = "extra_security_skip_btn"
    
    static let lblTitleDefault = "בחר בדיקת אבטחה נוספת"
    static let lblSubTitleDefault = "אנא בחר באיזו שיטה לאבטח את האפליקציה"
    static let btnConfirmDefault = "המשך"
    static let btnSkipDefault = "{דלג}"
}

struct UserBlockedPopup {
    
    static let lblTitle = ""
    static let lblSubtitle = ""
    static let btnTitle = ""
    
    static let lblTitleDefault = "אוי לא!"
    static let lblSubtitleDefault = "נראה שנחסמת אחרי הזנת קוד שגוי"
    static let btnTitleDefault = "צור קשר"
    
}

struct ToolTipsPopup {
    
    static let lblTitle = "tool_tips_popup_title"
    static let lblSubtitle = "tool_tips_popup_sub_title"
    
    static let lblTitleDefault = "<userName> שלום רב,"
    static let lblSubtitleDefault = "המחשה למיקום המספר על גב הכרטיס"
   
}

struct SuccessfulRegistrationPopupTranslations {
  
    static let lblTitle = "successful_registration_popup_title"
    static let lblSubtitle = "successful_registration_popup_sub_title"
    static let btnGotItTitle = "successful_registration_popup_btn_got_it"
    static let btnAddCarTitle = "successful_registration_popup_btn_add_car"
    
    static let lblTitleDefault = "הרשמתך הסתיימה בהצלחה!"
    static let lblSubtitleDefault = "מעתה תוכל לתדלק בקלות מהאפליקציה, ולצבור נקודות ששוות כסף!"
    static let btnGotItTitleDefault = "מגניב, קיבלתי!"
    static let btnAddCarTitleDefault = "הוסף רכב"
}


struct PleaseEnterDetailsPopupTranslations {
    
    static let lblTitle = "please_enter_details_popup_title"
    static let lblSubtitle = "please_enter_details_popup_sub_title"
    static let btnSkip = "please_enter_details_popup_btn_skip"
    static let btnRegister = "please_enter_details_popup_btn_register"
    
    static let lblTitleDefault = "לקוח יקר"
    static let lblSubtitleDefault = "אנא מלא את כל הפרטים כדי שנוכל למצוא אותך במערכת. רק כך תוכל לתדלק דרך האפליקציה של דלק טן ולצבור נקודות למבצעים והטבות."
    static let btnSkipDefault = "דלג"
    static let btnRegisterDefault = "הרשם"
    
}

struct HaveAnotherCreditCardPopupTranslations {
    
    static let lblTitle = "have_another_creditcard_popup_title"
    static let lblSubtitle = "have_another_creditcard_popup_sub_title"
    static let btnSkip = "have_another_creditcard_popup_btn_skip"
    static let btnAdd = "have_another_creditcard_popup_btn_add"
    
    static let lblTitleDefault = "לקוח יקר"
    static let lblSubtitleDefault = "זהינו שברשותך יש כרטיס תדלוק נוסף לרכב מספר <> המוגדר ל<>"
    //static let testerLblSubtitleDefault = "זהינו שברשותך יש כרטיס תדלוק נוסף לרכב מספר 18-888-09 המוגדר לגז tester!!" //temp for tests
    static let btnSkipDefault = "דלג"
    static let btnAddDefault = "הוספה"
}

struct WelcomeBackPopupTranslations {
    
    static let lblTitle = "welcomeback_popup_title"
    
    static let lblTitleDefault = "ברוך שובך <userName>!"
    
}

struct ShowCvvNumberLocationPopupTranslations {
    
    static let lblTitle = "show_cvvnumber_location_popup_title"
    static let lblSubtitle = "show_cvvnumber_location_popup_sub_title"
    
    static let lblTitleDefault = "<userName> שלום רב"
    static let lblSubtitleDefault = "המחשה למיקום המספר על גב הכרטיס"
}

struct GpsPermissionIsMissingPopupTranslations {
    
    static let lblTitle = "gps_permission_is_missing_popup_title"
    static let lblSubtitle = "gps_permission_is_missing_popup_sub_title"
    static let btnDefinitions = "gps_permission_is_missing_popup_btn_definitions"
    static let btnSkip = "gps_permission_is_missing_popup_btn_skip"
    
    static let lblTitleDefault = "רוני> שלום רב>,"
    static let lblSubtitleDefault = "אנא הדלק את ה GPS שלך כדי שנוכל לאפשר לך לתדלק בתחנה בא אתה נמצא הגדרות > מיקום > הפעלת GPS עם תוכנות > אפליקתיית Ten"
    static let btnDefinitionsDefault = "עבור להגדרות"
    static let btnSkipDefault = "דלג"
}

struct EnsureSwitchFromTenCardPopupTranslations {
    
    static let lblTitle = "ensure_switch_from_ten_card_popup_title"
    static let lblSubtitle = "ensure_switch_from_ten_card_popup_sub_title"
    static let btnSwitch = "ensure_switch_from_ten_card_popup_switch"
    static let btnSkip = "ensure_switch_from_ten_card_popup_skip"
    
    static let lblTitleDefault = "<רוני> שים לב"
    static let lblSubtitleDefault = "עברת לאמצעי תשלום אחר ופחות משתלם. בתדלוק עם כרטיס המועדון של Ten מוענקת לך הנחה החוסכת לך 5% על כל ליטר"
    static let btnSwitchDefault = "החלף לתדלוק בכרטיס  Ten"
    static let btnSkipDefault = "מעדיף כרטיס אשראי"
}

struct EnsureCorrectPumpPopupTranslations {
    
    static let lblTitle = "ensure_correct_pump_popup_title"
    static let lblSubtitle = "ensure_correct_pump_popup_sub_title"
    static let btnFullService = "ensure_correct_pump_popup_full_service"
    static let btnSelfService = "ensure_correct_pump_popup_self_service"
    
    static let lblTitleDefault = "היי <רוני>!"
    static let lblSubtitleDefault = "האם אתה בטוח שאתה עומד בתחנת <ת״א מתחם התחנה מול משאבה מספר ?>"
    static let btnFullServiceDefault = "המשך בתדלוק בשירות מלא"
    static let btnSelfServiceDefault = "המשך בתדלוק בשירות עצמי"
}

struct PickPumpWhichCarPopupTranslations {
    
    static let lblTitle = "pick_pump_which_car_popup_title"

    static let lblTitleDefault = "בחר איזה רכב ברצונך לתדלק?"
 }

struct PointsHowItWorkPopupTranslations {
    
    static let lblTitle = "points_how_it_work_popup_title"
    static let lblSubtitle = "points_how_it_work_popup_sub_title"
    static let lblBottomText = "points_how_it_work_popup_bottom_text"
    
    static let lblTitleDefault = "לקוח יקר"
    static let lblSubtitleDefault = "מועדון הלקוחות של Ten נותן לכם את האפשרות לצבור נקודות בכל תדלוק. <יותר נקודות יותר הטבות!>"
    static let lblBottomTextDefault = "Ten, מס׳ 1 במחירים ובשירות!"
}

struct GpsLocationProblemPopupTranslations {
    
    static let lblTitle = "gps_location_problem_popup_title"
    static let lblSubtitle = "gps_location_problem_popup_sub_title"
    static let btnYes = "gps_location_problem_popup_btn_yes"
    static let btnNo = "gps_location_problem_popup_btn_no"
    
    static let lblTitleDefault = "אנחנו לא רואים אותך בתחנה"
    static let lblSubtitleDefault = "האם לאשר תדלוק?"
    static let btnYesDefault = "כן"
    static let btnNoDefault = "לא"
}

struct ObligoBalanceIsOverPopupTranslations {
    
    static let lblTitle = "obligo_balance_is_over_popup_title"
    static let lblSubtitle = "obligo_balance_is_over_popup_sub_title"
    
    static let lblTitleDefault = "אופס!"
    static let lblSubtitleDefault = "ניראה שיתרת האובליגו לכרטיס <XXXX> הסתיימה לכן נאלצנו לעצור את תהליך התדלוק. ניתן להגדיל את יתרת האובליגו באמצעות יצירת קשר עם שירות הלקוחות"
}

struct EmailSentSuccessfullyPopupTranslations {
    
    static let lblTitle = "email_sent_successfully_popup_title"
    static let btnConfirm = "email_sent_successfully_popup_btn_confirm"

    static let lblTitleDefault = "העתק של החשבונית נשלח למייל <israel@gmail.com>"
    static let btnConfirmDefault = "המשך"
}

struct InsertYourEmailAddressPopupTranslations {
    
    static let lblTitle = "insert_your_email_address_popup_title"
    static let btnConfirm = "insert_your_email_address_popup_btn_confirm"
    static let emailPlaceHolder = "insert_your_email_address_popup_placeholder"
    static let emailError = "insert_your_email_address_popup_email_error"
    
    static let lblTitleDefault = "אנא הקלד את הדוא״ל שאליו תרצה שנשלח את החשבונית שלך"
    static let btnConfirmDefault = "המשך"
    static let emailPlaceHolderDefault = "דוא״ל"
    static let emailErrorDefault = "כתובת דוא״ל לא תקינה"
    
}

struct PickPumpObligoLiterPopupTranslations {
    
    static let lblTitle = "pick_pump_obligo_liter_popup_title"
    static let btnConfirm = "pick_pump_obligo_liter_popup_btn_confirm"
    static let btnInit = "pick_pump_obligo_liter_popup_btn_init"
    static let limitInputTitle = "pick_pump_obligo_liter_popup_limit_input_title"
    static let pickLimitFormatTitle = "pick_pump_obligo_liter_popup_pick_limit_format_title"
    static let lblLiter = "pick_pump_obligo_liter_popup_txt_liter"
    static let lblMoney = "pick_pump_obligo_liter_popup_txt_money"
    
    static let lblTitleDefault = "בחר סוג הגבלה"
    static let btnConfirmDefault = "שמור"
    static let limitInputTitleDefault = "אנא בחר את הגבלת הדלק"
    static let pickLimitFormatTitleDefault = "הגבלת כמות ליטר לתדלוק"
    static let btnInitDefault = "{אפס}"
    static let lblLiterDefault = "ליטר"
    static let lblMoneyDefault = "כסף"

}

struct BusinessRefuelingCardRegistrationVCTranslations {
    
    static let lblTitle = "business_refueling_card_registration_title"
    static let btnNext = "business_refueling_card_registration_btn_next"
    static let txtPlaceHolderBusinessNumber = "business_refueling_card_registration_placeholder_business_number"
    static let txtPlaceHolderCarNumber = "business_refueling_card_registration_placeholder_car_number"
    static let errorCarNumber = "business_refueling_card_registration_car_number_error"
    static let errorBusinessNumber = "errorCarNumber business_refueling_card_registration_business_number_error"
    
    static let lblTitleDefault = "לקוח דלק Ten"
    static let btnNextDefault = "המשך"
    static let txtPlaceHolderBusinessNumberDefault = "מספר ח.פ/עוסק מורשה"
    static let txtPlaceHolderCarNumberDefault = "מספר רכב"
    static let errorCarNumberDefault = "מספר רכב לא תקין"
    static let errorBusinessNumberDefault = "חשבון זה לא נמצא במערכת"
}

struct RegisterTenCardVCTranslations {
    
    static let lblTitle = "register_ten_card_title"
    static let btnForgotCode = "register_ten_card_btn_forgot_code"
    static let btnNext = "register_ten_card_btn_next"
    static let txtPlaceHolderSecretCode = "register_ten_card_secretcoder_placeholder"
    static let txtPlaceHolderCardNumber = "register_ten_cardnumber_placeholder"
    static let errorSecretCode = "register_ten_card_error_secret_code"
    static let errorCardNumber = "register_ten_card_error_cardnumber"
    
    static let lblTitleDefault = "הזן בבקשה את פרטי כרטיס Ten שברשותך"
    static let btnNextDefault = "המשך"
    static let btnForgotCodeDefault = "{שכחתי את הקוד}"
    static let txtPlaceHolderSecretCodeDefault = "קוד סודי"
    static let txtPlaceHolderCardNumberDefault = "מספר כרטיס"
    static let errorSecretCodeDefault = "קוד סודי שגוי"
    static let errorCardNumberDefault = "כרטיס זה אינו תקין"
}

struct RegisterCarVCTranslations { 
    
    static let lblTitle = "register_car_title"
    static let btnNext = "register_car_btn_next"
    static let txtPlaceholderId = "register_car_id_placeholder"
    static let txtPlaceholderCarNumber = "register_car_car_number_placeholder"
    static let txtFuelType = "register_car_txt_fuel_type"
    static let txtErrorId = "register_car_txt_error_id"
    static let txtErrorCarNumber = "register_car_txt_error_car_number"
    
    static let lblTitleDefault = "ועכשיו נדבר קצת על הרכב שלך"
    static let btnNextDefault = "המשך"
    static let txtPlaceholderIdDefault = "ת.ז"
    static let txtPlaceholderCarNumberDefault = "מספר רכב"
    static let txtFuelTypeDefault = "סוג דלק"
    static let txtErrorIdDefault = "ת.ז אינו תקין"
    static let txtErrorCarNumberDefault = "מספר רכב זה לא נמצא"
    
}

struct ChangeStationVCTranslations {
    
    static let lblTitle = "change_station_title"
    
    static let lblTitleDefault = "בחר באיזה תחנה אתה נמצא"
}

struct UserTypeVCTranslations {
    static let lblTitle = "customer_type_title"
    
    static let lblTitleDefault = "אנא בחר איזה סוג לקוח אתה"
}

struct CarInformationClubVCTranslations {
    
    static let lblTitle = "car_information_club_title"
    static let btnNext = "car_information_club_submit_btn"
    static let txtPlaceHolderCarNumber = "car_information_club_license_plate_placeholder"
    static let errorCarNumber = "car_information_club_license_plate_invalid_error"
    static let lblFuelTypeTitle = "car_information_club_select_fuel_title"
    
    static let lblTitleDefault = "ועכשיו נדבר קצת על הרכב שלך"
    static let btnNextDefault = "המשך"
    static let txtPlaceHolderCarNumberDefault = "מספר רכב"
    static let errorCarNumberDefault = "מספר רכב לא תקין"
    static let lblFuelTypeTitleDefault = "סוג דלק ?"
}

struct FuelingAndExtraServicesVCTranslations {
    
    static let lblTitle = "fueling_and_extra_services_title"
    static let lblSubTitle = "fueling_and_extra_services_sub_title"
    static let lblExtraServicesTitle = "fueling_and_extra_services_lbl_extra_services_title"
    static let btnCallTheRefueler = "fueling_and_extra_services_btn_call_the_refueler"
    static let lblTextMoney = "fueling_and_extra_services_txt_money"
    static let lblTextLiter = "fueling_and_extra_services_txt_liter"
    static let btnCancel = "fueling_and_extra_services_btn_cancel"
    
    static let lblTitleDefault = "התחל בתדלוק"
    static let lblSubTitleDefault = "המשאבה פתוחה"
    static let lblExtraServicesTitleDefault = "שירותים נוספים"
    static let btnCallTheRefuelerDefault = "קרא למתדלק"
    static let lblTextMoneyDefault = "תשלום"
    static let lblTextLiterDefault = "ליטר"
    static let btnCancelDefault = "בטל"
    
}






