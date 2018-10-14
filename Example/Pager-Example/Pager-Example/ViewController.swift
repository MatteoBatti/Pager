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
        
        
        //let appearence = PagerAppearance(type: PagerType.fixedWidth(70))
        //let appearence = PagerAppearance(type: PagerType.dynamic, titleColors: [(.blue, .selected), (.blue, .highlighted), (.lightGray, .normal)] )
        let appearence = PagerTabAppearance(type: PagerTabType.fixedNumber(2), color: .yellow, titleColors: [(.blue, .selected), (.blue, .highlighted), (.lightGray, .normal)] )
        
        
        let PoutingVC: PageViewController = {  let vc = PageViewController(text: "😡")
                                                    vc.view.backgroundColor = UIColor.gray
                                                    return vc
                                                    }()
        let BombVC: PageViewController    =  {  let vc = PageViewController(text: "💣")
                                                    vc.view.backgroundColor = UIColor.lightGray
                                                    return vc
                                                    }()
        let NerdVC: PageViewController    = {  let vc = PageViewController(text: "🤓")
                                                    vc.view.backgroundColor = UIColor.white
                                                    return vc
                                                    }()
        let SkullVC: PageViewController   = {  let vc = PageViewController(text: "☠️")
                                                    vc.view.backgroundColor = UIColor.black
                                                    return vc
                                                    }()
        
        let viewControllers: [PagerTabPage] = [( PoutingVC , "Pouting"),
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

