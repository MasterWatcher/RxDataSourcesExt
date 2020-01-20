//
//  TableCellViewModel.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit

public protocol TableCellViewModel: TableItemType, Equatable {

    associatedtype TableCellType: ConfigurableCell & UITableViewCell where TableCellType.ViewModel == Self

    var id: String { get }
}

public extension TableCellViewModel {

    var tableReuseIdentifier: String { String(describing: TableCellType.self) }

    var tableCellType: UITableViewCell.Type { TableCellType.self }

    var rowHeight: CGFloat { UITableViewAutomaticDimension }

    var nestedType: NestedType { .none }

    func configure(_ cell: UITableViewCell) { (cell as? TableCellType)?.configure(with: self) }
}
