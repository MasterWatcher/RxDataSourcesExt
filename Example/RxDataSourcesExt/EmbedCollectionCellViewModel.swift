//
//  EmbedCollectionCellViewModel.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 03/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import RxDataSourcesExt

struct EmbedCollectionCellViewModel: NestedCollectionTableCellViewModel {

    typealias TableCellType = EmbedCollectionCell

    let id: String
    let nestedSections: [CollectionSectionModel]
    let rowHeight: CGFloat = 72
}
