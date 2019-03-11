//
//  ShoppingLIstVC.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 13/01/2019.
//  Copyright © 2019 Matteo Battistini. All rights reserved.
//

import UIKit

class ShoppingListVC: UITableViewController {
    
    let shoppingList = ["Apples",
                        "Apricots",
                        "Bananas",
                        "Blackberries",
                        "Blueberries",
                        "Cantaloupe",
                        "Cherries",
                        "Clementines",
                        "Coconut",
                        "Cucumber",
                        "Currants",
                        "Durian",
                        "Figs",
                        "Grapefruit",
                        "Grapes",
                        "Guava",
                        "Honeydew",
                        "Jackfruit",
                        "Kiwis",
                        "Kumquats",
                        "Lemons",
                        "Limes",
                        "Lychees",
                        "Mangoes",
                        "Mangosteen",
                        "Nectarines",
                        "Collard",
                        "Corn",
                        "Cucumber",
                        "Eggplant",
                        "Fennel",
                        "Green Onions",
                        "Jalapeno Peppers",
                        "Kohlrabi",
                        "Leek",
                        "Mushrooms",
                        "Olives",
                        "Onions",
                        "Okra",
                        "Parsnip"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = FlatColor.lightGray
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCellId", for: indexPath)
        cell.textLabel?.textColor = FlatColor.blue
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

}
