//
//  KeychainManager.swift
//  NewBaseProjectSwift
//
//  Created by Shani on 06/09/2018.
//  Copyright © 2018 Inmanage. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class KeychainManager: BaseManager {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = KeychainManager()
    
    // MARK: - Save methods
    
    func saveStringToKeychain(_ value: Any?, forKey key: String) {
        if let str = value as? String {
            self.saveStringToKeychain(str, forKey: key)
        }
    }
    
    func removeKeychain() {
        _ = KeychainWrapper.standard.removeAllKeys()
    }
    
    func saveStringToKeychain(_ string: String, forKey key: String) {
        KeychainWrapper.standard.set(string, forKey: key)
    }
    
    func saveBoolToKeychain(_ value: Bool, forKey key: String) {
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    func saveDataToKeychain(_ value: Data, forKey key: String) {
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    func saveDictToKeychain(_ dict: [String: String], forKey key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        KeychainWrapper.standard.set(data, forKey: key)
    }
    
    func saveDateToKeychain(_ date: Date, forKey key: String) {
        KeychainWrapper.standard.set(date as NSCoding, forKey: key)
    }
    
    // MARK: - Retrieve methods
    
    func retrieveStringFromKeychain(key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    
    func retrieveBoolFromKeychain(key: String) -> Bool {
        if let retrievedBool = KeychainWrapper.standard.bool(forKey: key) {
            return retrievedBool
        }
        return false
    }
    
    func retrieveDataFromKeychain(key: String) -> Data? {
        return KeychainWrapper.standard.data(forKey: key)
    }
    
    func retrieveDateFromKeychain(key: String) -> Date? {
        return KeychainWrapper.standard.object(forKey: key) as? Date
    }
    
    func retrieveDictFromKeychain(key: String) -> [String: String]? {
        if let data = KeychainWrapper.standard.data(forKey: key) {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: data) {
                return dict as? [String: String]
            } else {
                return nil
            }
        }
        return nil
    }
    
    // MARK: - Remove methods
    
    func removeFromKeychain(forKey key: String) {
        if self.retrieveStringFromKeychain(key: key) != nil {
            KeychainWrapper.standard.removeObject(forKey: key)
        }
    }
}
