//
//  SizeChangeableCell.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxSwift

public protocol SizeChangeableCell {
    var didChangeSize: Observable<Void> { get }
}
