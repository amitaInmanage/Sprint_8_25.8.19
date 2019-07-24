//
//  TranslationManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit

class TranslationManager: BaseManager {
    
    static var sharedInstance = TranslationManager()
    
    
    //MARK: General functions
    
    func translationForKey(key :String, withDefaultValue defaultValue: String) -> (String) {
        
        var strTranslation = ""
        
        var dictTranslations = ApplicationManager.sharedInstance.appGD.dictTranslations
        
        if dictTranslations.isEmpty {
            dictTranslations = loadTranslationsFromDisk()
        }
        
        if dictTranslations.isEmpty {
            return defaultValue
        }
        
        if dictTranslations[key] is String {
            strTranslation = dictTranslations[key] as! String
        }
        
      //  strTranslation = dictTranslations[key] as? String
        
        if strTranslation.isEmpty {
            strTranslation = defaultValue
        }
        
        strTranslation = strTranslation.replacingOccurrences(of: "\\", with: "")
        
        return strTranslation
        
    }
    
    func loadTranslationsFromDisk() -> ([String: Any]) {
        
        var dictToLoad = [String: Any]()
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        var basePath : String = paths[0]
        basePath = basePath.appending("/translationsArr")
        
//        if ApplicationManager.sharedInstance.fileManager.fileExistsAtAbsolutePath(path: basePath) {
//            dictToLoad = NSKeyedUnarchiver.unarchiveObject(withFile: basePath) as! [String : Any]
//        }
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: basePath) as? [String : Any] else {
            return dictToLoad
        }
        
        dictToLoad = data
        
        return dictToLoad
    }
    
    
    func saveTranslationsToDisk(dictTranslation: [String: Any]) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        var basePath : String = paths[0]
        basePath = basePath.appending("/translationsArr")
        
        NSKeyedArchiver.archiveRootObject(dictTranslation, toFile: basePath)
        
    }
    
    override func reset() {
        TranslationManager.sharedInstance = TranslationManager()
    }
    
}

//Global translation function

func Translation(_ key: String, _ withDefaultValue: String) -> (String) {
    return TranslationManager.sharedInstance.translationForKey(key: key, withDefaultValue: withDefaultValue)
}

