//
//  TableSectionModel.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

public struct TableSectionModel {
    let id: String
    let title: String?
    public let items: [AnyTableItem]

    public init(id: String = UUID().uuidString, title: String? = nil, items: [TableItemType]) {
        self.id = id
        self.title = title
        self.items = items.map(AnyTableItem.init)
    }
}

extension TableSectionModel: AnimatableSectionModelType {

    public var identity: String { id }

    public init(original: TableSectionModel, items: [AnyTableItem]) {
        self.id = original.id
        self.title = original.title
        self.items = items
    }
}
