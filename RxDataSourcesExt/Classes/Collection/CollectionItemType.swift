//
//  CollectionItemType.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit

public protocol CollectionItemType: Identifiable {

    var collectionReuseIdentifier: String { get }
    var collectionCellType: UICollectionViewCell.Type { get }
    var itemWidth: CollectionItemWidth { get }
    var itemHeight: CGFloat { get }
    func configure(_ cell: UICollectionViewCell)

    func isEqualTo(_ other: CollectionItemType) -> Bool
}

public extension CollectionItemType where Self: Equatable {
    func isEqualTo(_ other: CollectionItemType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}
