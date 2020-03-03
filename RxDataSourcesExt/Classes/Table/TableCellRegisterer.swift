//
//  TableCellRegisterer.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 20/01/2020.
//

import Foundation

class TableCellRegisterer {

    private var registeredIdentifiers = Set<String>()

    func register(cellType: UITableViewCell.Type, for reuseIdentifier: String, in tableView: UITableView) {
        guard !registeredIdentifiers.contains(reuseIdentifier) else { return }
        guard tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) == nil else {
            registeredIdentifiers.insert(reuseIdentifier)
            return
        }
        tableView.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        registeredIdentifiers.insert(reuseIdentifier)
    }
}
