//
//  TenConstants.swift
//  Ten
//
//  Created by Shani on 25/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit

struct TenRequestNames {
   
    static let getSmsToken = "getSmsToken"
    static let getOnBoarding = "getOnboarding"
    static let getVerifyPinCode = "verifyPinCode"
    static let getAddCreditCard = "addCreditCard"
    static let getVerifySmsToken = "verifySmsToken"
    static let getEditUserInformation = "editUserInformation"
    static let getTransactionsHistory = "getTransactionsHistory"
    static let getUpdateRegistrationData = "updateRegistrationData"
    static let getRemoveStorePaymentMethod = "removeStorePaymentMethod"
    static let getStarsNewFuelingDeviceProcess = "startNewFuelingDeviceProcess"
    static let getUpdateNewFuelingDeviceProcessData = "updateNewFuelingDeviceProcessData"

}

struct TenParamsNames {
    static let cardId = "card_id"
    static let acceptsUpdates = "acceptsUpdates"
    static let id = "id"
    static let type = "type"
    static let page = "page"
    static let add = "add"
    static let pinCode = "pinCode"
    static let email  = "email"
    static let gender = "gender"
    static let token = "token"
    static let screen = "screen"
    static let idNumber = "id_number"
    static let lastName = "lastName"
    static let cellPhone = "cellphone"
    static let fieldsArr = "fieldsArr"
    static let firstName = "firstName"
    static let cardNumber = "card_number"
    static let cardSecret = "card_secret"
    static let fuelTypes = "fuel_type_code"
    static let customerType = "customer_type"
    static let licensePlate = "license_plate"
    static let registrationToken = "registrationToken"
    static let isAdditionalCard = "is_additional_card"
}

struct updateRegistrationParams {
    static let firstName = "first_name"
    static let lastName = "last_name"
}

enum ScreensNames: String {
    case pinCode = "pin_code"
    case creditCard = "credit_card"
    case termsOfUse = "terms_of_use"
    case fuelingCard = "fueling_card"
    case customerType = "customer_type"
    case extraSecurity = "extra_security"
    case completeProcess = "complete_process"
    case chooseCreditCard = "choose_credit_card"
    case carInformationClub = "car_information_club"
    case fuelingCardPrivate = "fueling_card_private"
    case personalInformation = "personal_information"
    case fuelingCardBusiness = "fueling_card_business"
    case carInformationDalkan = "car_information_dalkan"
    case additionalFuelingCard = "additional_fueling_card"
    case carInformationPrivate = "car_information_private"
    case carInformationFcPrivate = "car_information_fc_private"
    case carInformationFcBusiness = "car_information_fc_business"
    case carInformationFcPrivateReadonly = "car_information_fc_private_readonly"
    case carInformationFcBusinessReadonly = "car_information_fc_business_readonly"
}

struct UpdateRegistrationDataCalls {
    static let updateRegistrationData = "updateRegistrationData"
    
}

struct UpdateRegistrationDataCallsParams {
    static let screen = "screen"
    static let registrationId = "registrationId"
    static let registrationToken = "registrationToken"
    
}

struct EditUserInformationParams {
    static let screen = "screen"
}


struct UpdateNewFuelingDeviceProcessDataParams {
    static let token = "token"
    static let screen = "screen"
}

//struct UpdateRegistrationDataKeys {
//    static let fieldsArrIdNum = "fieldsArr[id_number]"
//    static let fieldsArrLastName = "fieldsArr[last_name]"
//    static let fieldsArrFirstName = "fieldsArr[first_name]"
//    static let fieldsArrCustomerType = "fieldsArr[customer_type]"
//    static let fieldsArrLicensePlate = "fieldsArr[license_plate]"
//}

struct PaymentUrlPrefix {
    static let baseUrl = "https://ten.inmanage.com/"
    static let path = "resource/payment/cg"
}
