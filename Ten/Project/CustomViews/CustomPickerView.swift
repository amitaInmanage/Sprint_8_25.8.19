//
//  CustomPickerView.swift
//  Ten
//
//  Created by inmanage on 10/06/2019.
//  Copyright © 2019 Inmanage. All rights reserved.
//

import UIKit

enum pickerViewFields: Int {
    case yearField = 0
    case monthField = 1
}

class CustomPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var months: [String]!
    var years: [Int]!
    let currentDate = Date()
    let calendar = Calendar.current
    
    var month : Box<Int> = Box<Int>(Calendar.current.component(.month, from: Date())) {
        didSet {
            selectRow(month.value-1, inComponent: pickerViewFields.monthField.rawValue, animated: false)
        }
    }
    
    var year : Box<Int> = Box<Int>(Calendar.current.component(.year, from: Date())) {
        didSet {
            selectRow(years.index(of: year.value)!, inComponent: pickerViewFields.yearField.rawValue, animated: true)
        }
    }
    
    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() { // start date is 1/2018
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            
            let startYear = 2018
            while startYear <= currentYear {
                years.append(currentYear)
                currentYear -= 1
            }
        }
        
        self.years = years
        
        // population months with localized names
        var months: [String] = []
        
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date) - 1
        
        //        var month = 0
        //        for _ in 1...12 {
        //            months.append(DateFormatter().monthSymbols[month].capitalized)
        //            month += 1
        //        }
        
        months = ["ינואר", "פברואר", "מרץ", "אפריל", "מאי", "יוני", "יולי", "אוגוסט", "ספטמבר", "אוקטובר", "נובמבר", "דצמבר"]
        
        self.months = months
        
        self.delegate = self
        self.dataSource = self
        
        self.selectRow(currentMonth - 1, inComponent: pickerViewFields.monthField.rawValue, animated: false)
        
    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: RegularLabel.fontName() ?? "", size: 14)
            pickerLabel?.textAlignment = .center
        }
        
        switch component {
        case pickerViewFields.monthField.rawValue:
            pickerLabel?.text = months[row]
        case pickerViewFields.yearField.rawValue:
            pickerLabel?.text = "\(years[row])"
        default:
            pickerLabel?.text = ""
        }
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case pickerViewFields.monthField.rawValue:
            return months.count
        case pickerViewFields.yearField.rawValue:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = self.selectedRow(inComponent: pickerViewFields.monthField.rawValue) + 1
        let year = years[self.selectedRow(inComponent: pickerViewFields.yearField.rawValue)]
        
        if let block = onDateSelected {
            block(month, year)
        }
        
        if (year == years[0]) {
            
            let currentMonth = calendar.component(.month, from: currentDate)
            if let indexOfJCurrentMonth = months.firstIndex(of: DateFormatter().monthSymbols[currentMonth - 1].capitalized){
                if ( month >  indexOfJCurrentMonth) {
                    
                    self.setToCurrentDate()
                }
                else {
                    self.month.value = month
                    self.year.value = year
                }
                
            } else {
                self.month.value = month
                self.year.value = year
            }
        } else {
            self.month.value = month
            self.year.value = year
        }
    }
    
    func setToCurrentDate() {
        let currentMonth = calendar.component(.month, from: currentDate)
        if let indexOfCurrentMonth = months.firstIndex(of: DateFormatter().monthSymbols[currentMonth - 1].capitalized) {
            self.selectRow(0, inComponent: pickerViewFields.yearField.rawValue, animated: true)
            self.selectRow(indexOfCurrentMonth, inComponent: pickerViewFields.monthField.rawValue, animated: true)
        }
        self.month.value =  calendar.component(.month, from: currentDate)
        self.year.value = calendar.component(.year, from: currentDate)
    }
}
