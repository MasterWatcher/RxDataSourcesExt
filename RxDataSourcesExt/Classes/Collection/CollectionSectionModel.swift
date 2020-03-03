//
//  CollectionSectionModel.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

public struct CollectionSectionModel: Equatable {
    let id: String
    public let items: [AnyCollectionItem]

    public init(id: String = UUID().uuidString, items: [CollectionItemType]) {
        self.id = id
        self.items = items.map(AnyCollectionItem.init)
    }
}

extension CollectionSectionModel: AnimatableSectionModelType {

    public var identity: String { id }

    public init(original: CollectionSectionModel, items: [AnyCollectionItem]) {
        self.id = original.id
        self.items = items
    }
}
