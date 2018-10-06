//
//  UIViewControllerExtension.swift
//  Pager
//
//  Created by Matteo Battistini on 14/02/2018.
//

import UIKit

extension UIViewController {
    
    /**
     Add child view controller.
     
     - parameter: UIViewController to add
     - parameter: UIView container
     */
    public func add(childController: UIViewController?, toView view: UIView?) {
        guard let childController = childController, let view = view else { return }
        self.addChildViewController(childController)
        childController.beginAppearanceTransition(true, animated: true)
        childController.willMove(toParentViewController: self)
        view.addSubview(childController.view)
        childController.endAppearanceTransition()
        childController.didMove(toParentViewController: self)
        childController.view.match(view)
    }
    
    /**
     Remove child view controller.
     
     - parameter: UIViewController to remove
     */
    public func remove(childController: UIViewController?) {
        guard let childController = childController else { return }
        childController.willMove(toParentViewController: nil)
        childController.beginAppearanceTransition(false, animated: true)
        childController.view.removeFromSuperview()
        childController.endAppearanceTransition()
        childController.removeFromParentViewController()
    }
    
}
