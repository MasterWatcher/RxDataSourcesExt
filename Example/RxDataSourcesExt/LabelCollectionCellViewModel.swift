//
//  LabelCollectionCellViewModel.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 19/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxDataSourcesExt

struct LabelCollectionCellViewModel: CollectionCellViewModel {
    typealias CollectionCellType = LabelCollectionCell

    let id = UUID().uuidString
    let title: String
    let itemWidth: CollectionItemWidth
    let itemHeight: CGFloat = 50
}
