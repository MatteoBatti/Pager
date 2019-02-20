//
//  ButtonManager.swift
//  PagerTab
//
//  Created by Matteo Battistini on 11/12/2018.
//

import UIKit

class ButtonFactory {
    
    
    class func button(_ title: String, tag: Int? = 0, appearence: PagerTabAppearance?, target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.tag = tag ?? 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: UIControl.State.normal)
        button.backgroundColor = appearence?.color
        appearence?.titleColors?.forEach({ (color, state) in
            button.setTitleColor(color, for: state)
        })
        button.titleLabel?.font = appearence?.font
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return button
    }
    
    
}
