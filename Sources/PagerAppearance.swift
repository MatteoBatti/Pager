//
//  PagerApparence.swift
//  Pager
//
//  Created by Matteo Battistini on 16/02/2018.
//

import UIKit

public enum PagerType {
    case fixedWidth(CGFloat)
    case fixedNumber(Int)
    case dynamic
}



public struct PagerAppearance {

    let type: PagerType
    var selected: Int?
    let height: CGFloat
    var color: UIColor?
    var titleColors: [(UIColor, UIControlState)]?
    var font: UIFont?
    
    public init(type: PagerType,
                selected: Int = 0,
                height: CGFloat = 50.0,
                color: UIColor? = .clear,
                titleColors: [(UIColor, UIControlState)]? = [(.black, .normal)],
                font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) ) {
        self.type = type
        self.selected = selected
        self.height = height
        self.color = color
        self.titleColors = titleColors
        self.font = font
    }
    
}
