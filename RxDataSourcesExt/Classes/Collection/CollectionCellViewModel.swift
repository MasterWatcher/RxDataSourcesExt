//
//  CollectionCellViewModel.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit

public protocol CollectionCellViewModel: CollectionItemType, Equatable {
    associatedtype CollectionCellType: ConfigurableCell & UICollectionViewCell where CollectionCellType.ViewModel == Self
}

public extension CollectionCellViewModel {

    var collectionReuseIdentifier: String {
        String(describing: CollectionCellType.self)
    }

    var collectionCellType: UICollectionViewCell.Type { CollectionCellType.self }

    //according to https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617711-itemsize
    var itemSize: CGSize {
        CGSize(width: 50, height: 50)
    }

    func configure(_ cell: UICollectionViewCell) {
        (cell as? CollectionCellType)?.configure(with: self)
    }
}
