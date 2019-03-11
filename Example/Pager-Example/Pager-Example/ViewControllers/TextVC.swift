//
//  TextVC.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 10/02/2019.
//  Copyright © 2019 Matteo Battistini. All rights reserved.
//

import UIKit

class TextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FlatColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }

}
