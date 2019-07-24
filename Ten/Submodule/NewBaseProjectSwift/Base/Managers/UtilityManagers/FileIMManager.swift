//
//  FileIMManager.swift
//  WelcomeInSwift
//
//  Created by inmanage on 08/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

struct Paths {
    
    static let imagesDirectoryPath = "images"
    static let iPhoneDirectoryPath = "iphone"
    static let underscoreMediaDirectoryPath = "_media"
    static let mediaDirectoryPath = "media"

    static let iPhoneZipFilePath = "iphone.zip"
    static let mediaJsonFilePath = "media.json"
    static let mediaSQLFilePath = "media.sql"
    static let translationsFilePath = "Translations"

    static let didMediaZipFileDownloadAndExtract = "didMediaZipFileDownloadAndExtract"

}

class FileIMManager: BaseManager {
    
    static var sharedInstance = FileIMManager()

    // Tests if a directory exists at a given path
    func directoryExistsAtAbsolutePath(path: String) -> (Bool) {
        
        var directory: ObjCBool = ObjCBool(false)
        let isDirectoryExists = FileManager.default.fileExists(atPath: path, isDirectory: &directory)

        return isDirectoryExists && directory.boolValue
        
    }
    
    func fileExistsAtAbsolutePath(path :String) -> (Bool) {
        
        var directory: ObjCBool = ObjCBool(false)
        let isFileExistsAtPath = FileManager.default.fileExists(atPath: path, isDirectory: &directory)
        
        return isFileExistsAtPath && directory.boolValue
        
    }
    
    // /Documents
    func getDocumentsDirectoryPath() -> (String) {
        return (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.relativePath)!
    }
    
    // /Documents/images
    func getImagesDirectoryPath() -> (String) {
        return self.getDocumentsDirectoryPath().stringByAppendingPathComponent(path: "/\(Paths.imagesDirectoryPath)")
    }
    
    func getIphoneDirectoryPath() -> (String) {
        return self.getImagesDirectoryPath().stringByAppendingPathComponent(path: "/\(Paths.iPhoneDirectoryPath)")
    }
    
    func getMediaJsonFilePath() -> (String) {
        return self.getIphoneDirectoryPath().stringByAppendingPathComponent(path: Paths.mediaJsonFilePath)
    }
    
    override func reset() {
        FileIMManager.sharedInstance = FileIMManager()
    }
    
    
}
