//
//  UINavigationBar+IMExtension.swift
//  Mindspace
//
//  Created by inmanage on 19/06/2017.
//  Copyright © 2017 inmanage. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationBar: UINavigationBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize :CGSize = CGSize(width: self.frame.size.width, height: 44)
        return newSize
    }
    
}
