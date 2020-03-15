//
//  ConfigurableCell.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

public protocol ConfigurableCell: DisposableCell {

    associatedtype ViewModel: Identifiable

    func configure(with: ViewModel)
}
