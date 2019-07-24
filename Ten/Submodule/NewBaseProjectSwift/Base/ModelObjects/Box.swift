//
//  Box.swift
//  Maccabi_Haifa
//
//  Created by aviv frenkel on 30/11/2017.
//  Copyright © 2017 Idan. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    private var listener : Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value : T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
