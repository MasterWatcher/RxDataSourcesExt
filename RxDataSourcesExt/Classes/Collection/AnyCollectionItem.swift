//
//  AnyCollectionItem.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

public struct AnyCollectionItem: CollectionItemType {

    let item: CollectionItemType

    public var id: String { item.id }
    public var collectionReuseIdentifier: String { item.collectionReuseIdentifier }
    public var collectionCellType: UICollectionViewCell.Type { item.collectionCellType }
    public var itemWidth: CollectionItemWidth { item.itemWidth }
    public var itemHeight: CGFloat { item.itemHeight }

    init(_ item: CollectionItemType) {
        self.item = item
    }

    public func configure(_ cell: UICollectionViewCell) {
        item.configure(cell)
    }

    public func isEqualTo(_ other: CollectionItemType) -> Bool {
        item.isEqualTo(other)
    }
}

extension AnyCollectionItem: IdentifiableType {
    public var identity : String { id }
}

extension AnyCollectionItem: Equatable {
    public static func ==(lhs: AnyCollectionItem, rhs: AnyCollectionItem) -> Bool {
        return lhs.item.isEqualTo(rhs.item)
    }
}
