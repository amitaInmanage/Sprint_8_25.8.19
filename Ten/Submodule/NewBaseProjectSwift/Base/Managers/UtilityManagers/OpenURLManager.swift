//
//  OpenURLManager.swift
//  WelcomeInSwift
//
//  Created by Idan Dreispiel on 15/02/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class OpenURLManager: BaseManager, SFSafariViewControllerDelegate {
    
    override init(){
        // init all properties
        super.init()
    }
    
    static var sharedInstance = OpenURLManager()
    
    
    // MARK: - Navigation
    // Tries Waze first, if unable to open, tries Maps
    func openNavigationAppWithLocation(location: CLLocation, andMapItemName mapItemName: String) -> (Bool) {
        
        var canOpenURL = self.openWazeWithLocation(location: location, andShouldOpenAppStore: false)
        
        if !canOpenURL {
            canOpenURL = self.openMapsWithLocation(location: location, andMapItemName: mapItemName)
        }

        return canOpenURL
        
    }
    
    func openWazeWithLocation(location: CLLocation, andShouldOpenAppStore shouldOpenAppStore: Bool) -> (Bool) {
        
        let strUrl = String(format: "waze://?ll=%f,%f&navigate=yes", location.coordinate.latitude, location.coordinate.longitude)
        
        let canOpenUrl = UIApplication.shared.canOpenURL(URL(string: strUrl)!)
        
        if canOpenUrl {
            
            // Waze is installed. Launch Waze and start navigation
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: strUrl)!, options: [:], completionHandler: { (bool) in
                })
            } else {
                // Fallback on earlier versions
            }
            
        } else if shouldOpenAppStore {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "http://itunes.apple.com/us/app/id323229106")!, options: [:], completionHandler: { (bool) in
                })
            } else {
                // Fallback on earlier versions
            }
            
        }
        
        return canOpenUrl
    }
    
    
    func openMapsWithLocation(location: CLLocation, andMapItemName mapItemName: String) -> (Bool) {
        
        let locationCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        var placemark = MKPlacemark()
        
        // Creates a placemark on map
        if #available(iOS 10.0, *) {
            placemark = MKPlacemark(coordinate: locationCoordinate)
        } else {
            // Fallback on earlier versions
        }
        
        // Create mapItem for map
        let mapItem = MKMapItem(placemark: placemark)
        
        // Name mapItem
        mapItem.name = mapItemName
        
        let currentLocationMapItem = MKMapItem.forCurrentLocation()
        
        // Set launchOptions
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        
        // Open Maps
        return MKMapItem.openMaps(with: [currentLocationMapItem, mapItem], launchOptions: launchOptions)
    
    }
    
    // MARK: - Telprompt
    
    func openTelPrompt(strPhoneNumber: String) -> (Bool) {
        
        var aStrPhoneNumber = strPhoneNumber
        
        aStrPhoneNumber = strPhoneNumber.replacingOccurrences(of: " ", with: "")
        aStrPhoneNumber = strPhoneNumber.replacingOccurrences(of: "-", with: "")
        aStrPhoneNumber = strPhoneNumber.replacingOccurrences(of: "tel", with: "")
        aStrPhoneNumber = strPhoneNumber.replacingOccurrences(of: ":", with: "")

        let url = URL(string: "telprompt://\(aStrPhoneNumber)")
        
        if let aUrl = url {
            
            let canOpenURL = UIApplication.shared.canOpenURL(aUrl)
            
            if canOpenURL {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(aUrl, options: [:], completionHandler: nil)
                    
                } else {
                    UIApplication.shared.openURL(aUrl)
                    
                }
            }
            
            return canOpenURL

        }
        
        return false
    }
    
    // MARK: - General apps
    func openUrl(strUrl :String) -> (Bool) {
        
        let strFullUrl = strUrl.contains("http") ? strUrl : "http://"+(strUrl)
        
        let url = self.createUrlFromString(strUrl: strFullUrl)
        
        let canOpenURL = UIApplication.shared.canOpenURL(url)
        
        if canOpenURL {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(url)
                
            }
        }

        return canOpenURL
        
    }
    
    func openAppByUrl(strAppUrl: String, strUrl: String){
        
        let url = self.createUrlFromString(strUrl: strAppUrl)
        print(url.absoluteString)
        let canOpenURL = UIApplication.shared.canOpenURL(url)
        
        if canOpenURL {
           
            openUrl(url: url)
            
        } else{
            
            let url = self.createUrlFromString(strUrl: strUrl)
            
            let canOpenURL = UIApplication.shared.canOpenURL(url)

            if canOpenURL {
               
                openUrl(url: url)
            }
            
        }
    }

    func openUrl(url: URL){
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func createUrlFromString(strUrl: String) -> (URL) {
        
        var aStrUrl = strUrl
        
        aStrUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        return URL(string: aStrUrl)!
        
    }
    
    func openSFSafari(strLink :String) {
        if strLink.contains("http://") || strLink.contains("https://") {
            let url = URL(string: strLink)
            if let aUrl = url {
                let sfVc = SFSafariViewController(url: aUrl)
                if #available(iOS 10.0, *) {
                    sfVc.preferredBarTintColor = UIColor.getApplicationThemeColor()
                } else {
                    // Fallback on earlier versions
                }
                sfVc.delegate = self
                ApplicationManager.sharedInstance.navigationController.present(sfVc, animated: true, completion: nil)
            } else {
                if let aUrl = URL(string: strLink.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "") {
                    let sfVc = SFSafariViewController(url: aUrl)
                    if #available(iOS 10.0, *) {
                        sfVc.preferredBarTintColor = UIColor.getApplicationThemeColor()
                    } else {
                        // Fallback on earlier versions
                    }
                    sfVc.delegate = self
                    ApplicationManager.sharedInstance.navigationController.present(sfVc, animated: true, completion: nil)
                }

            }
        }
    }
    
    override func reset() {
        OpenURLManager.sharedInstance = OpenURLManager()
    }
    
    

}
