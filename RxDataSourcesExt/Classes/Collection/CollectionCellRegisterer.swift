//
//  CollectionCellRegisterer.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 03/03/2020.
//

import Foundation

class CollectionCellRegisterer {

    private var registeredIdentifiers = Set<String>()

    func register(cellType: UICollectionViewCell.Type,
                  for reuseIdentifier: String,
                  indexPath: IndexPath,
                  in collectionView: UICollectionView) {
        guard !registeredIdentifiers.contains(reuseIdentifier) else { return }
        collectionView.register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
        registeredIdentifiers.insert(reuseIdentifier)
    }
}
