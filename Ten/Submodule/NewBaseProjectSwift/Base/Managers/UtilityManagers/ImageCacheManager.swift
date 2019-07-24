//
//  ImageCacheManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import SDWebImage

enum IMActivityIndicatorStyle: Int {
    case none, whiteLarge, white, gray
}

struct ImageConstansAddOns {
    static let imageURLTimeStampSeparator = "?t="
    static let underscoreIphone = "_iphone."
    static let period = "."
    static let periodJPG = ".jpg"
}

class ImageCacheManager: BaseManager {
    
    static var sharedInstance = ImageCacheManager()
    
    var dictImagesTimeStamps = [String:Any]()
    
    //MARK: UIImageView - Handlers
    func setImageForImageView(imageView: UIImageView, withStrImageURLSuffix strImageURLSuffix: String, andAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage?, andIMActivityIndicatorStyle activityIndicatorStyle: IMActivityIndicatorStyle, andCompletionBlock completionBlock: @escaping SDWebImageCompletionBlock) {
        
        var aStrImageURLSuffix = strImageURLSuffix
        
        if addUnderscoreIphone {
            aStrImageURLSuffix = self.addUnderscoreIphoneToStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix)
        }
        
//        let strImageURLPath = self.getStrImagePathFromStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix)
       // var strImageURL = self.getStrImageURLFromStrImageURLPath(strImageURLPath: strImageURLPath)
        
        aStrImageURLSuffix = self.getStrImageURLFromStrImageURLPath(strImageURLPath: aStrImageURLSuffix)
        
        if self.shouldUpdateImageWithStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix) {
            
            weak var weakImageView = imageView
            
            if activityIndicatorStyle != .none {
                
                imageView.setShowActivityIndicator(true)
                imageView.setIndicatorStyle(.gray)
                
                imageView.sd_setImage(with: URL(string: aStrImageURLSuffix), placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                    if error == nil && image != nil {
                        
                        var aImage = image
                        
                        // Needed for correct scaling of the image, if we remove this code, the scale will be wrong - twice as big as should be
                        let scale = UIScreen.main.scale
                        
                        if scale > 1.0 {
                            
                            aImage = UIImage(cgImage: image!.cgImage!, scale: scale, orientation: UIImageOrientation.up)
                            weakImageView?.image = aImage
                            
                        }
                        
                        self.saveImage(image: aImage!, toDiskAndUpdateDictImagesTimeStampsWithStrImageURLSuffix: strImageURLSuffix)
                        
                    }
                    
                    completionBlock(image, error, cacheType, imageURL)
                    
                })
                
            } else {
                
                imageView.sd_setImage(with: URL(string: aStrImageURLSuffix), placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                    if error == nil && image != nil {
                        
                        var aImage = image
                        
                        // Needed for correct scaling of the image, if we remove this code, the scale will be wrong - twice as big as should be
                        let scale = UIScreen.main.scale
                        
                        if scale > 1.0 {
                            
                            aImage = UIImage(cgImage: image!.cgImage!, scale: scale, orientation: UIImageOrientation.up)
                            weakImageView?.image = aImage
                            
                        }
                        
                        self.saveImage(image: aImage!, toDiskAndUpdateDictImagesTimeStampsWithStrImageURLSuffix: strImageURLSuffix)
                        
                    }
                    
                    completionBlock(image, error, cacheType, imageURL)
                    
                })
                
                
            }
            
        } else {
            
            let strImagePath = ApplicationManager.sharedInstance.fileManager.getIphoneDirectoryPath().stringByAppendingPathComponent(path: aStrImageURLSuffix)
            
            // Need this for correct scaling of image!
            if let data = NSData(contentsOfFile: strImagePath) {
                
                let img = UIImage(data: data as Data, scale: UIScreen.main.scale)
                
                if let aImg = img {
                    imageView.image = aImg
                    completionBlock(aImg, nil, SDImageCacheType(rawValue: 0)!, URL(string: aStrImageURLSuffix))
                } else {
                    completionBlock(img, nil, SDImageCacheType(rawValue: 0)!, URL(string: aStrImageURLSuffix))
                }
            }
            
            
        }
    }
    
    //MARK: UIButton - image
    
    func setImageForButton(button: UIButton, forforState state: UIControlState, withStrImageURLSuffix strImageURLSuffix: String, andAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage?, andCompletionBlock completionBlock: @escaping SDWebImageCompletionBlock) {
        
        var aStrImageURLSuffix = strImageURLSuffix
        
        if addUnderscoreIphone {
            aStrImageURLSuffix = self.addUnderscoreIphoneToStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix)
        }
        
        //        let strImageURLPath = self.getStrImagePathFromStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix)
        // var strImageURL = self.getStrImageURLFromStrImageURLPath(strImageURLPath: strImageURLPath)
        
        aStrImageURLSuffix = self.getStrImageURLFromStrImageURLPath(strImageURLPath: aStrImageURLSuffix)
        
        weak var weakButton = button
        
        
        if self.shouldUpdateImageWithStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix) {
            
            button.sd_setImage(with: URL(string: aStrImageURLSuffix), for: state, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
                if error == nil && image != nil {
                    
                    var aImage = image
                    
                    // Needed for correct scaling of the image, if we remove this code, the scale will be wrong - twice as big as should be
                    let scale = UIScreen.main.scale
                    
                    if scale > 1.0 {
                        
                        aImage = UIImage(cgImage: image!.cgImage!, scale: scale, orientation: UIImageOrientation.up)
                        weakButton?.setImage(aImage, for: state)
                        
                    }
                    
                    self.saveImage(image: aImage!, toDiskAndUpdateDictImagesTimeStampsWithStrImageURLSuffix: strImageURLSuffix)
                    
                }
                
                completionBlock(image, error, cacheType, imageURL)
                
            })
            
        } else {
            
            let strImagePath = ApplicationManager.sharedInstance.fileManager.getIphoneDirectoryPath().stringByAppendingPathComponent(path: aStrImageURLSuffix)
            
            // Need this for correct scaling of image!
            
            if let data = NSData(contentsOfFile: strImagePath) {
                
                let img = UIImage(data: data as Data, scale: UIScreen.main.scale)
                
                if let aImg = img {
                    button.setImage(aImg, for: state)
                    completionBlock(aImg, nil, SDImageCacheType(rawValue: 0)!, URL(string: aStrImageURLSuffix))
                } else {
                    completionBlock(img, nil, SDImageCacheType(rawValue: 0)!, URL(string: aStrImageURLSuffix))
                }
            }
            
        }
        
    }
    
    // MARK: - Background Image
    
    func setBackgroundImageForButton(button: UIButton, forState state: UIControlState, withStrImageURLSuffix strImageURLSuffix: String, andAddUnderscoreIphone addUnderscoreIphone: Bool, andPlaceholderImage placeholderImage: UIImage?, andCompletionBlock completionBlock: @escaping SDWebImageCompletionBlock) {
        
        var aStrImageURLSuffix = strImageURLSuffix
        
        if addUnderscoreIphone {
            aStrImageURLSuffix = self.addUnderscoreIphoneToStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix)
        }
        
        //        let strImageURLPath = self.getStrImagePathFromStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix)
        // var strImageURL = self.getStrImageURLFromStrImageURLPath(strImageURLPath: strImageURLPath)
        
        aStrImageURLSuffix = self.getStrImageURLFromStrImageURLPath(strImageURLPath: aStrImageURLSuffix)
        
        weak var weakButton = button
        
        if self.shouldUpdateImageWithStrImageURLSuffix(strImageURLSuffix: aStrImageURLSuffix) {
            
            button.sd_setBackgroundImage(with: URL(string: aStrImageURLSuffix), for: state, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
                if error == nil && image != nil {
                    
                    var aImage = image
                    
                    // Needed for correct scaling of the image, if we remove this code, the scale will be wrong - twice as big as should be
                    let scale = UIScreen.main.scale
                    
                    if scale > 1.0 {
                        
                        aImage = UIImage(cgImage: image!.cgImage!, scale: scale, orientation: UIImageOrientation.up)
                        weakButton?.setBackgroundImage(aImage, for: state)
                        
                    }
                    
                    self.saveImage(image: aImage!, toDiskAndUpdateDictImagesTimeStampsWithStrImageURLSuffix: strImageURLSuffix)
                    
                }
                
                completionBlock(image, error, cacheType, imageURL)
                
            })
            
        } else {
            
            let strImagePath = ApplicationManager.sharedInstance.fileManager.getIphoneDirectoryPath().stringByAppendingPathComponent(path: aStrImageURLSuffix)
            
            // Need this for correct scaling of image!
            if let data = NSData(contentsOfFile: strImagePath) {
                
                let img = UIImage(data: data as Data, scale: UIScreen.main.scale)
                
                if let aImg = img {
                    button.setBackgroundImage(aImg, for: state)
                    completionBlock(aImg, nil, SDImageCacheType(rawValue: 0)!, URL(string: aStrImageURLSuffix))
                } else {
                    completionBlock(img, nil, SDImageCacheType(rawValue: 0)!, URL(string: aStrImageURLSuffix))
                }
            }
            
        }
        
    }
    
    
    
    func addUnderscoreIphoneToStrImageURLSuffix(strImageURLSuffix: String) -> (String) {
        
        var aStrImageURLSuffix = strImageURLSuffix
        
        let rangeOfPeriod = strImageURLSuffix.range(of: ImageConstansAddOns.period)
        
        if let range = rangeOfPeriod {
            aStrImageURLSuffix = strImageURLSuffix.replacingCharacters(in: range, with: ImageConstansAddOns.underscoreIphone)
        }
        
        return aStrImageURLSuffix
        
    }
    
    func getStrImagePathFromStrImageURLSuffix(strImageURLSuffix: String) -> (String) {
        
        var strImagePath = String()
        
        let arrComponents = strImageURLSuffix.components(separatedBy: ImageConstansAddOns.imageURLTimeStampSeparator)
        
        if arrComponents.count >= 1 {
            strImagePath = arrComponents.first!
        }
        
        return strImagePath
    }
    
    func getStrImageTimeStampFromStrImageURLSuffix(strImageURLSuffix: String) -> (String) {
        
        var strImageTimeStamp = String()
        
        let arrComponents = strImageURLSuffix.components(separatedBy: ImageConstansAddOns.imageURLTimeStampSeparator)
        
        if arrComponents.count == 2 {
            strImageTimeStamp = arrComponents.last!
        }
        
        return strImageTimeStamp
        
    }
    
    func getStrImageURLFromStrImageURLPath(strImageURLPath: String) -> (String) {
        
        if !strImageURLPath.contains("https://") && !strImageURLPath.contains("http://") {
            return "\(Constans.baseLiveURL)\(strImageURLPath)"
        }
        
        return strImageURLPath
        
    }
    
    func shouldUpdateImageWithStrImageURLSuffix(strImageURLSuffix: String) -> (Bool) {
        
        let strImageTimeStamp = self.getStrImageTimeStampFromStrImageURLSuffix(strImageURLSuffix: strImageURLSuffix)
        let strImageURLPath = self.getStrImagePathFromStrImageURLSuffix(strImageURLSuffix: strImageURLSuffix)
        let strSavedImageTimeStamp = self.dictImagesTimeStamps[strImageURLPath]
        
        if strSavedImageTimeStamp == nil || strImageURLPath.isEmpty || strImageURLPath.isEmpty {
            return true
        }
        
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        
        let numImageTimeStamp = numFormatter.correctedNumberFromString(string: strImageTimeStamp)
        
        if strSavedImageTimeStamp != nil {
            
            let numSavedImageTimeStamp = numFormatter.correctedNumberFromString(string: strSavedImageTimeStamp as! String)
            
            if let numImageTimeStamp = numImageTimeStamp , let numSavedImageTimeStamp = numSavedImageTimeStamp {
                
                if numImageTimeStamp.intValue < numSavedImageTimeStamp.intValue {
                    return true
                }
            }
        }
        
        return false
    }
    
    func saveImage(image: UIImage, toDiskAndUpdateDictImagesTimeStampsWithStrImageURLSuffix strImageURLSuffix: String) {
        
        let strImageURLPath = self.getStrImageURLFromStrImageURLPath(strImageURLPath: strImageURLSuffix)
        
        let strImageDirectory = ApplicationManager.sharedInstance.fileManager.getIphoneDirectoryPath().stringByAppendingPathComponent(path: strImageURLPath)
        
        // If the image's directory does not exist, then create it
        if !ApplicationManager.sharedInstance.fileManager.directoryExistsAtAbsolutePath(path: strImageDirectory) {
            
            do {
                
                try FileManager.default.createDirectory(atPath: strImageDirectory, withIntermediateDirectories: true, attributes: nil)
                
                var imageDataRepresentation : Data?
                let rangeOfPeriodJPG = strImageURLPath.range(of: ImageConstansAddOns.periodJPG)
                
                if rangeOfPeriodJPG != nil {
                    if let aImage = UIImageJPEGRepresentation(image, 1.0) {
                        imageDataRepresentation = aImage
                    }
                    
                } else {
                    
                    if let image = UIImagePNGRepresentation(image) {
                        imageDataRepresentation = image
                    }
                    
                }
                
                if let imageFinale = imageDataRepresentation {
                    
                    do {
                        
                        try (imageFinale as NSData).write(toFile: ApplicationManager.sharedInstance.fileManager.getIphoneDirectoryPath().stringByAppendingPathComponent(path: strImageURLPath), options: .atomicWrite)
                        
                        self.updateDictImagesTimeStampsAndSaveItToDiskWithStrImageURLSuffix(strImageURLSuffix: strImageURLSuffix)
                        
                        
                    } catch let error as NSError {
                        print(error.localizedDescription);
                    }
                    
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription);
            }
            
            
        }
        
    }
    
    
    func updateDictImagesTimeStampsAndSaveItToDiskWithStrImageURLSuffix(strImageURLSuffix: String) {
        
        var strImageTimeStamp = self.getStrImageTimeStampFromStrImageURLSuffix(strImageURLSuffix: strImageURLSuffix)
        let strImageURLPath = self.getStrImagePathFromStrImageURLSuffix(strImageURLSuffix: strImageURLSuffix)
        
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        
        let numImageTimeStamp = numFormatter.correctedNumberFromString(string: strImageTimeStamp)
        
        if strImageTimeStamp.isEmpty || numImageTimeStamp == nil || (numImageTimeStamp?.intValue)! <= 0 {
            strImageTimeStamp = "1"
        }
        
        self.dictImagesTimeStamps.updateValue(strImageTimeStamp, forKey: strImageURLPath)
        
        let strMediaFilePath = ApplicationManager.sharedInstance.fileManager.getMediaJsonFilePath()
        
//        let os = OutputStream(toFileAtPath: strMediaFilePath, append: false)
        
        if let os = OutputStream(toFileAtPath: strMediaFilePath, append: false) {
            os.open()
            JSONSerialization.writeJSONObject(self.dictImagesTimeStamps, to: os, options: JSONSerialization.WritingOptions(rawValue: 0), error: nil)
            os.close()

        }
        
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    override func reset() {
        ImageCacheManager.sharedInstance = ImageCacheManager()
    }
    
}
