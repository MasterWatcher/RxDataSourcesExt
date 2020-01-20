//
//  AnyTableItem.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

public struct AnyTableItem: TableItemType {

    let item: TableItemType

    public var id: String { item.id }
    public var tableReuseIdentifier: String { item.tableReuseIdentifier }
    public var tableCellType: UITableViewCell.Type { item.tableCellType }
    public var rowHeight: CGFloat { item.rowHeight }
    public var nestedType: NestedType { item.nestedType }

    init(_ item: TableItemType) {
        self.item = item
    }

    public func configure(_ cell: UITableViewCell) {
        item.configure(cell)
    }

    public func isEqualTo(_ other: TableItemType) -> Bool {
        item.isEqualTo(other)
    }
}

extension AnyTableItem: IdentifiableType {
    public var identity : String { id }
}

extension AnyTableItem: Equatable {
    public static func ==(lhs: AnyTableItem, rhs: AnyTableItem) -> Bool {
        return lhs.item.isEqualTo(rhs.item)
    }
}

