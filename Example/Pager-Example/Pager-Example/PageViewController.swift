//
//  BeautifullViewController.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 16/03/2018.
//  Copyright © 2018 Matteo Battistini. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    private let lblText: UILabel = UILabel()
    private var text: String?
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
        self.setupSubview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSubview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupSubview() {
        lblText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lblText)
        lblText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lblText.textAlignment = .center
        lblText.font = UIFont.systemFont(ofSize: 70)
        lblText.text = self.text ?? "🤓"
    }
    
}
