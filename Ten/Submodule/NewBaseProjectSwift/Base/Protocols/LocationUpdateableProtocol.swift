//
//  LocationUpdateableProtocol.swift
//  WelcomeInSwift
//
//  Created by inmanage on 13/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation
import CoreLocation

@objc protocol LocationUpdateableProtocol : NSObjectProtocol {
    
    func didGetNewLocation(location: CLLocation)
    
}
