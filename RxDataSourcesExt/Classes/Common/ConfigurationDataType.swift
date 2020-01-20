//
//  ConfigurationDataType.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

protocol ConfigurationDataType {
    associatedtype T
    var cell: T { get }
}
