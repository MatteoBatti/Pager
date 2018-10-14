//
//  PagerApparence.swift
//  PagerTab
//
//  Created by Matteo Battistini on 16/02/2018.
//

import UIKit

public enum PagerTabType {
    case fixedWidth(CGFloat)
    case fixedNumber(Int)
    case dynamic
}



public struct PagerTabAppearance {

    let type: PagerTabType
    var selected: Int?
    let height: CGFloat
    var color: UIColor?
    var titleColors: [(UIColor, UIControl.State)]?
    var font: UIFont?
    
    public init(type: PagerTabType,
                selected: Int = 0,
                height: CGFloat = 50.0,
                color: UIColor? = .clear,
                titleColors: [(UIColor, UIControl.State)]? = [(.black, .normal)],
                font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) ) {
        self.type = type
        self.selected = selected
        self.height = height
        self.color = color
        self.titleColors = titleColors
        self.font = font
    }
    
}
