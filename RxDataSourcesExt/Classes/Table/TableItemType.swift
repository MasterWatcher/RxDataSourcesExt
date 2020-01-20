//
//  TableItemType.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

public enum NestedType {
    case none
    case collection(sections: [CollectionSectionModel])
}

public protocol TableItemType {

    var id: String { get }
    var tableReuseIdentifier: String { get }
    var tableCellType: UITableViewCell.Type { get }
    var rowHeight: CGFloat { get }
    var nestedType: NestedType { get }

    func configure(_ cell: UITableViewCell)

    func isEqualTo(_ other: TableItemType) -> Bool
}

public extension TableItemType where Self: Equatable {
    func isEqualTo(_ other: TableItemType) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}
