//
//  AnyCollectionItem.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

public struct AnyCollectionItem: CollectionItemType {

    let item: CollectionItemType

    var id: String { item.id }
    var collectionReuseIdentifier: String { item.collectionReuseIdentifier }
    var itemSize: CGSize { item.itemSize }

    init(_ item: CollectionItemType) {
        self.item = item
    }

    func configure(_ cell: UICollectionViewCell) {
        item.configure(cell)
    }

    func isEqualTo(_ other: CollectionItemType) -> Bool {
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
