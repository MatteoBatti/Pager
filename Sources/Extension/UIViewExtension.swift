//
//  UIViewExtension.swift
//  PagerTab
//
//  Created by Matteo Battistini on 14/02/2018.
//

import UIKit


extension UIView {
    
    func match(_ view: UIView) {
        NSLayoutConstraint.activate(
            [self.topAnchor.constraint(equalTo: view.topAnchor),
             self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             self.rightAnchor.constraint(equalTo: view.rightAnchor),
             self.leftAnchor.constraint(equalTo: view.leftAnchor)]
        )
    }
    
}
