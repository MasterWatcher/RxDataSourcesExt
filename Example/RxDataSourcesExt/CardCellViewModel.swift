//
//  CardCellViewModel.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 08/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxDataSourcesExt

struct CardCellViewModel: CollectionCellViewModel {
    typealias CollectionCellType = CardCell

    let id = UUID().uuidString
    let title: String
    let itemWidth: CollectionItemWidth = .absolute(150)
    let itemHeight: CGFloat = 72
}
