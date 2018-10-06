//
//  WeakRef.swift
//  Pager
//
//  Created by Matteo Battistini on 27/02/2018.
//

import Foundation

class WeakRef<T> where T: AnyObject {
    
    private(set) weak var value: T?
    
    init(_ value: T?) {
        self.value = value
    }
}
