//
//  AppGeneralDeclarationResponse.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class AppGeneralDeclarationResponse: BaseGeneralDeclarationResponse {
    
    var extraSecurityArr = [ExtraSecurity]()
    var usersTypesArr = [UserType]()
    var fuelTypesArr = [Fuel]()
    var maxViewsWithoutScroll = 0
    var literFuelingLimitDefault = 0
    var moneyFuelingLimitDefault = 0
    var tenCardMin = 0
    var tenCardMax = 0
    var secretCodeMin = 0
    var secretCodeMax = 0
    var businessIdMax = 0
    var businessIdMin = 0
    var licensePlateMin = 0
    var licensePlateMax = 0
    var idNumberMin = 0
    var idNumberMax = 0
    var maxCustomerProgramChanges = 0
    var isShowBoarding = false
    var genderArr = [String: Any]()
    var customerProgramItem = [CustomerProgramItem]()
    var customerProgramBenefitTypesItem = [CustomerProgramBenefit]()
    
    override func buildFromJSONDict(JSONDict: [String: Any]!) -> BaseInnerResponse {
        super.buildFromJSONDict(JSONDict: JSONDict)
    
        let customerProgramBenefitTypes = ParseValidator.getArrayForKey(key: "customer_program_benefit_typesArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.customerProgramBenefitTypesItem = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: customerProgramBenefitTypes, innerResponse: CustomerProgramBenefit(), shouldReverseOrder: false) as! [CustomerProgramBenefit]
        
        let customerProgram = ParseValidator.getArrayForKey(key: "customer_programsArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.customerProgramItem = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: customerProgram, innerResponse: CustomerProgramItem(), shouldReverseOrder: false) as! [CustomerProgramItem]
    
        self.genderArr = ParseValidator.getDictionaryForKey(key: "gendersArr", JSONDict: JSONDict, defaultValue: [String: Any]())
        
        let usersTypesArr = ParseValidator.getArrayForKey(key: "customer_typesArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.usersTypesArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: usersTypesArr, innerResponse: UserType(), shouldReverseOrder: false) as! [UserType]
        
        let fuelTypesArr = ParseValidator.getArrayForKey(key: "fuel_typesArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.fuelTypesArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: fuelTypesArr, innerResponse: Fuel(), shouldReverseOrder: false) as! [Fuel]
        
        let extraSecurityArr = ParseValidator.getArrayForKey(key: "extra_securityArr", JSONDict: JSONDict, defaultValue: [Any]())
        self.extraSecurityArr = ParseValidator.createArrayOfInnerResponsesFromJSONArray(JSONArray: extraSecurityArr, innerResponse: ExtraSecurity(), shouldReverseOrder: false) as! [ExtraSecurity]
        
        self.isShowBoarding = ParseValidator.getBoolForKey(key: "show_onboarding", JSONDict: JSONDict, defaultValue: false)
        
        self.maxViewsWithoutScroll = ParseValidator.getIntForKey(key: "car_information_club_max_cells_without_scrolling", JSONDict: JSONDict, defaultValue: 3)
        
        self.maxCustomerProgramChanges = ParseValidator.getIntForKey(key: "max_customer_program_changes", JSONDict: JSONDict, defaultValue: 0)
        
        self.idNumberMax = ParseValidator.getIntForKey(key: "user_id_max_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.idNumberMin = ParseValidator.getIntForKey(key: "user_id_min_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.businessIdMax = ParseValidator.getIntForKey(key: "business_id_max_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.businessIdMin = ParseValidator.getIntForKey(key: "business_id_min_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.licensePlateMin = ParseValidator.getIntForKey(key: "license_plate_min_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.licensePlateMax = ParseValidator.getIntForKey(key: "license_plate_max_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.secretCodeMin = ParseValidator.getIntForKey(key: "secret_code_min_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.secretCodeMax = ParseValidator.getIntForKey(key: "secret_code_max_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.tenCardMin = ParseValidator.getIntForKey(key: "tan_card_min_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.tenCardMax = ParseValidator.getIntForKey(key: "tan_card_max_chars", JSONDict: JSONDict, defaultValue: 0)
        
        self.literFuelingLimitDefault = ParseValidator.getIntForKey(key: "liter_fueling_limit_default", JSONDict: JSONDict, defaultValue: 0)
        
        self.moneyFuelingLimitDefault = ParseValidator.getIntForKey(key: "money_fueling_limit_default", JSONDict: JSONDict, defaultValue: 0)

        return self
    }
}
