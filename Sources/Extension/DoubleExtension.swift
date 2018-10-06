//
//  DoubleExtension.swift
//  Pager
//
//  Created by Matteo Battistini on 21/02/2018.
//

import UIKit


extension Double {
    
    var float: Float {
        get {
            return Float(self)
        }
    }
    
    var int: Int {
        get {
            return Int(self)
        }
    }
    
    var cgFloat: CGFloat {
        get {
            return CGFloat(self)
        }
    }
    
}
