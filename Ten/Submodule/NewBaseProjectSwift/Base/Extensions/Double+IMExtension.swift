//
//  Double+IMExtension.swift
//  Mindspace
//
//  Created by Amir-inManage on 09/07/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    func getStringDateFromFormat(format: String) -> String {
        let date = Date(timeIntervalSince1970: self)

        var strDate = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = Calendar.current.timeZone
        
        strDate = dateFormatter.string(from: date)
        
        return strDate
        
    }
}
