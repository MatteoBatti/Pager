//
//  ViewController.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 14/02/2018.
//  Copyright © 2018 Matteo Battistini. All rights reserved.
//

import UIKit
import PagerTab

class ViewController: UIViewController, PagerTabDelegate {

    deinit {
        print("-> DEINIT!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let appearence = PagerAppearance(type: PagerType.fixedWidth(70))
        //let appearence = PagerAppearance(type: PagerType.dynamic, titleColors: [(.blue, .selected), (.blue, .highlighted), (.lightGray, .normal)] )
        let appearence = PagerTabAppearance(type: PagerTabType.fixedNumber(2), color: FlatColor.yellow, titleColors: [(FlatColor.blue, .selected), (FlatColor.blue, .highlighted), (FlatColor.lightYellow, .normal)] )
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let shoppingListVC = sb.instantiateViewController(withIdentifier: "ShoppingListId")
        shoppingListVC.view.accessibilityIdentifier = "ShoppingListId"
        let textVC = sb.instantiateViewController(withIdentifier: "TextVCid")
        textVC.view.accessibilityIdentifier = "TextVCid"
        let collectionVC = sb.instantiateViewController(withIdentifier: "CollectionVCId")
        textVC.view.accessibilityIdentifier = "CollectionVCId"
        let imageVC = sb.instantiateViewController(withIdentifier: "ImageVCId")
        imageVC.view.accessibilityIdentifier = "ImageVCId"
        
        let viewControllers: [PagerTabPage] = [( shoppingListVC , "Shopping List"),
                                            ( textVC , "Text"),
                                            ( collectionVC , "Collection"),
                                            ( imageVC , "Image")  ]
        
        let pager = PagerTab( viewControllers , appearence:  appearence )
        pager.delegate = self
        
        
        self.add(childController: pager, toView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageDidAppear(_ index: Int, page: PagerTabPage) {
            print("did appear page at index => \(index), with name => \(page.1), with viewController => \(String(describing: type(of: page.0)))")
    }


}

