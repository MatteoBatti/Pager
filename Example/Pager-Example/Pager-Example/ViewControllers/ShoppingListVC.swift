//
//  ShoppingLIstVC.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 13/01/2019.
//  Copyright © 2019 Matteo Battistini. All rights reserved.
//

import UIKit

class ShoppingListVC: UITableViewController {
    
    let ShoppingList = ["Tomatoes", "Mozzarella", "Pasta"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = FlatColor.lightGray
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCellId", for: indexPath)
        cell.textLabel?.textColor = FlatColor.blue
        cell.textLabel?.text = ShoppingList[indexPath.row]
        return cell
    }

}
