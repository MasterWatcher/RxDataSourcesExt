//
//  TextCollectionCellViewModel.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RxDataSourcesExt

struct TextCollectionCellViewModel: CollectionCellViewModel {

    typealias CollectionCellType = TextCollectionCell

    let id: String = UUID().uuidString
    let title: String
    let itemWidth: CollectionItemWidth = .absolute(72)
    let itemHeight: CGFloat = 72
}

