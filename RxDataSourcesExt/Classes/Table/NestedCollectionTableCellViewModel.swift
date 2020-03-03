//
//  NestedCollectionTableCellViewModel.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit

public protocol NestedCollectionTableCellViewModel: TableItemType, Equatable {

    associatedtype TableCellType: ConfigurableCell & CollectionContainableCell & UITableViewCell where TableCellType.ViewModel == Self

    var id: String { get }
    var nestedSections: [CollectionSectionModel] { get }
}

public extension NestedCollectionTableCellViewModel {

    var identity: String { id }

    var tableReuseIdentifier: String { String(describing: TableCellType.self) }

    var tableCellType: UITableViewCell.Type { TableCellType.self }

    var rowHeight: CGFloat { UITableView.automaticDimension }

    var nestedType: NestedType { .collection(sections: nestedSections) }

    func configure(_ cell: UITableViewCell) { (cell as? TableCellType)?.configure(with: self) }
}
