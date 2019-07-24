//
//  TimeManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class TimeManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
        
    }
    
    static var sharedInstance = TimeManager()
    
    public static let second = 1
    public static let minute = second * 60
    public static let hour = minute * 60
    public static let day = hour * 24

    static let kOffsetTimeFromServer = "offsetTimeFromServer"
    static let kCurrentLanguage = "currentLanguage"
    
    var strTimeZone = ""
    
    var currentLanguage : Language? {
        get {
            if self.currentLanguage == nil {
                
                let notesData : Data!
                
                if let aNotesData = UserDefaults.standard.object(forKey: TimeManager.kCurrentLanguage) {
                    notesData = aNotesData as! Data
                    if !notesData.isEmpty {
                        return (NSKeyedUnarchiver.unarchiveObject(with: notesData!) as! Language?)!
                    }
                }
                return nil
            }
            else{
                return self.currentLanguage
            }
        }
        set(newCurrentLanguage){
            self.currentLanguage = newCurrentLanguage;
        }
    }
    
    var intServerTimeTS: TimeInterval?{
        didSet{
            if intServerTimeTS != nil {
                offsetTimeFromServer = Date().timeIntervalSince1970 - intServerTimeTS!
                UserDefaults.standard.set((offsetTimeFromServer), forKey: TimeManager.kOffsetTimeFromServer)
            }
        }
    }
    
    //TODO :Check what happens when app is close - we need to get the UserDefaults value
    var offsetTimeFromServer: TimeInterval = 0
    
    func registerCallTimeAndCheckIfMaxTimePassed() -> (Bool) {
        
        let userDefaults = UserDefaults.standard
        
        let lastCallToServerDate = userDefaults.object(forKey: Constans.lastCallToServerTimestamp) as? Date
        
        if let aLastCallToServerDate = lastCallToServerDate {
            
            let minsSinceLastCall = aLastCallToServerDate.minutes(from: Date())
                
            //Calendar.current.component(.minute, from: aLastCallToServerDate) - Calendar.current.component(.minute, from: Date())
            
            var maxSessionTimeInMinutes = 25;
            
            if ApplicationManager.sharedInstance.appGD.intRestartOnIdle > 0 {
                
                maxSessionTimeInMinutes = ApplicationManager.sharedInstance.appGD.intRestartOnIdle
                
            }
            
            if minsSinceLastCall >= maxSessionTimeInMinutes {
                
                userDefaults.removeObject(forKey: Constans.lastCallToServerTimestamp)
                userDefaults.synchronize()
                return true
                
            } else {
                
                userDefaults.set(Date(), forKey: Constans.lastCallToServerTimestamp)
                userDefaults.synchronize()
                return false
                
            }
            
        } else {
            
            userDefaults.set(Date(), forKey: Constans.lastCallToServerTimestamp)
            userDefaults.synchronize()
            
        }
        
        return false
        
    }
    
    func refreshLastCallToServerTimestamp() {
        UserDefaults.standard.set(Date(), forKey: Constans.lastCallToServerTimestamp)
        UserDefaults.standard.synchronize()
    }
    
    // Use this instead of [NSDate date] when calculating and displaying server data
    func getCurrentServerDate() -> Date {
        return Date(timeIntervalSince1970: Date().timeIntervalSince1970 - offsetTimeFromServer)
    }
    
    func getCurrentServerTS() -> Int {
        return Int(getCurrentServerDate().timeIntervalSince1970)
    }
    
    
    // Calendar by current timeZone
    func getCalendar() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(identifier: self.strTimeZone) {
            calendar.timeZone = timeZone
        }
        
        return calendar
    }
    
    func setCurrentLanguageWithLanguageArr(languageArr: Array<Language>) {
        var lang: Language!
        for language: Language in languageArr {
            if language.isActive {
                lang = language
                break
            }
        }
        currentLanguage = lang
        
        let data = NSKeyedArchiver.archivedData(withRootObject: lang)
        UserDefaults.standard.set(data, forKey: TimeManager.kCurrentLanguage)
    }
    
    //LanguageDirection
    func isRTL() -> LanguageDirection {
        if currentLanguage != nil {
            return (currentLanguage?.languageDirection)!
        }
        else {
            return LanguageDirection.rtl // default
        }
    }
    
    func isRTLBool() -> Bool {
        if currentLanguage != nil {
            return false
        }
        else {
            return true
        }
    }
    
    // MARK: - Help Methods
    
    // Timestamp -> Date
    func getDateFromTS(timeStamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timeStamp)
    }
    
    // Date -> Timestamp
    func getTSFrom(date: Date) -> TimeInterval {
        return date.timeIntervalSince1970
    }
    
    // Timestamp -> "HH:mm"
    func getHourAndMinuteString(fromTimeStamp ts: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: ts)
        return getHourAndMinuteString(from: date)
    }
    
    // Date -> "HH:mm"
    func getHourAndMinuteString(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        let str: String = f.string(from: date)
        return str
    }
    
    // Timestamp -> "dd.MM.yy"
    func getFullDateString(fromTimeStamp ts: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: ts)
        return getFullDateString(from: date)
    }
    
    // Date -> "dd.MM.yy"
    func getFullDateString(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yy"
        let str: String = f.string(from: date)
        return str
    }
    
    // Date -> "dd.MM.yyyy"
    func getFullDateFullYearString(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        let str: String = f.string(from: date)
        return str
    }
    
    // Date -> "dd/MM/yyyy hh:mm:ss.SSS"
    func getFullDateAndTimeString(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yyyy hh:mm:ss.SSS"
        let str: String = f.string(from: date)
        return str
    }
    
    func getDateStringWithFormat(format: String, fromTimeStamp ts: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: ts)
        let f = DateFormatter()
        f.dateFormat = format
        let str: String = f.string(from: date)
        return str
    }
    
    func getTimeString(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "hh:mm"
        let str: String = f.string(from: date)
        return str
    }
    
    func getHourOrMinuteString(from timeStamp: Int) -> String {

        var time = 0
        if timeStamp > TimeManager.hour {
            time = timeStamp/TimeManager.hour
        } else {
            time = timeStamp/TimeManager.minute
        }

        return String(time)
    }
    
    func isHoursZero(from timeStamp: Int) -> Bool {
        
        var time = 0
        if timeStamp > TimeManager.hour {
            return false
        } else {
            return true
        }
    }
    
    func getHourOrMinuteString(fromDate date: Date) -> String {
        return self.getHourOrMinuteString(from: Int(self.getTSFrom(date: date)))
    }
    
    //Insert int from 1-7 and return a String hebrew of the day
    func getDaySymbolInHebrew(time: Int) -> String? {
        
        let dateFormatter = DateFormatter()
        let calendar = ApplicationManager.sharedInstance.timeManager.getCalendar()
        
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale(identifier: "he")
        
        let dateComponent = calendar.dateComponents([.weekday], from: ApplicationManager.sharedInstance.timeManager.getDateFromTS(timeStamp: TimeInterval(time)))
        
        let weekdaySymbols = dateFormatter.weekdaySymbols
        if let day = dateComponent.weekday {
            return weekdaySymbols?[day - 1]
        }
        return nil
    }
    
    //Insert int from 1-12 and return a String hebrew of the day
    func getMonthSymbolInHebrew(time: Int) -> String? {
        
        let dateFormatter = DateFormatter()
        let calendar = ApplicationManager.sharedInstance.timeManager.getCalendar()
        
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale(identifier: "he")
        
        //        let dateComponent = calendar.dateComponents([.month], from: ApplicationManager.sharedInstance.timeManager.getDateFromTS(timeStamp: TimeInterval(time)))
        
        let monthsSymbols = dateFormatter.monthSymbols
        
        return monthsSymbols?[time-1]
    }
    
    // Date -> "dd.MM"
    func getDateWithoutYearString(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd.MM"
        let str: String = f.string(from: date)
        return str
    }
    
    // Int -> dd
    func getDayInt(from date: Date) -> Int {
        let f = DateFormatter()
        f.dateFormat = "dd"
        let str: String = f.string(from: date)
        let num : Int = (Int)(str)!
        return num
    }
    
    override func reset() {
        TimeManager.sharedInstance = TimeManager()
    }
    
    //getYear integer
    func getYear(time: Int) -> Int {
        let date = self.getDateFromTS(timeStamp: TimeInterval(time))
        let calendar = ApplicationManager.sharedInstance.timeManager.getCalendar()
        
        let year = calendar.component(.year, from: date)
        
        return year
    }
    
    func getDaySymbol(time: Int) -> String? {
        
        let dateFormatter = DateFormatter()
        let calendar = self.getCalendar()
        
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale(identifier: "he")
        
        let dateComponent = calendar.dateComponents([.weekday], from: self.getDateFromTS(timeStamp: TimeInterval(time)))
        
        let weekdaySymbols = dateFormatter.weekdaySymbols
        
        return weekdaySymbols?[dateComponent.weekday!-1]
    }
}
