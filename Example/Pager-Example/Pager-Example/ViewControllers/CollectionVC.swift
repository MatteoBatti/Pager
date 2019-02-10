//
//  CollectionVC.swift
//  Pager-Example
//
//  Created by Matteo Battistini on 10/02/2019.
//  Copyright © 2019 Matteo Battistini. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellId"

class CollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = FlatColor.lightGray
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = FlatColor.yellow
        return cell
    }

}
