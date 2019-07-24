//
//  Array+IMExtension.swift
//  WelcomeInSwift
//
//  Created by inmanage on 09/03/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

//Protocol that copyable class should conform
protocol Copying {
    init(original: Self)
}

//Concrete class extension
extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

extension Array where Element: Equatable {
    
    mutating func removeObject(object: Element) {
        
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}


//Array extension for elements conforms the Copying protocol
extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}
