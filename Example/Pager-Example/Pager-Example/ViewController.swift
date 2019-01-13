//
//  ViewController.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 14/02/2018.
//  Copyright © 2018 Matteo Battistini. All rights reserved.
//

import UIKit
import PagerTab

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = { let label = UILabel()
            label.textColor = FlatColor.darkBlue
            label.text = "PagerTab"
            return label
        }()
        
        //let appearence = PagerAppearance(type: PagerType.fixedWidth(70))
        //let appearence = PagerAppearance(type: PagerType.dynamic, titleColors: [(.blue, .selected), (.blue, .highlighted), (.lightGray, .normal)] )
        let appearence = PagerTabAppearance(type: PagerTabType.fixedNumber(2), color: FlatColor.yellow, titleColors: [(FlatColor.blue, .selected), (FlatColor.blue, .highlighted), (FlatColor.lightYellow, .normal)] )
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let shoppingListVC = sb.instantiateViewController(withIdentifier: "ShoppingListId")
        
        
        let BombVC: PageViewController    =  {  let vc = PageViewController(text: "💣")
                                                    vc.view.backgroundColor = FlatColor.lightGray
                                                    return vc
                                                    }()
        let NerdVC: PageViewController    = {  let vc = PageViewController(text: "🤓")
                                                    vc.view.backgroundColor = FlatColor.lightGray
                                                    return vc
                                                    }()
        let SkullVC: PageViewController   = {  let vc = PageViewController(text: "☠️")
                                                    vc.view.backgroundColor = FlatColor.lightGray
                                                    return vc
                                                    }()
        
        let viewControllers: [PagerTabPage] = [( shoppingListVC , "Shopping List"),
                                            ( BombVC , "Bomb"),
                                            ( NerdVC , "Nerd"),
                                            ( SkullVC , "Skull")  ]
        
        let pager = PagerTab( viewControllers , appearence:  appearence )
        
        
        self.add(childController: pager, toView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

