//
//  DisposableCell.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxSwift

//You also need to override prepareForReuse and recreate disposeBag:
//override func prepareForReuse() {
//      super.prepareForReuse()
//      disposeBag = DisposeBag()
//  }
public protocol DisposableCell {
    var disposeBag: DisposeBag { get }
}
