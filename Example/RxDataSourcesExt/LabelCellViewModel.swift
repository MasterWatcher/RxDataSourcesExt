//
//  LabelCellViewModel.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 20/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxDataSourcesExt

struct LabelCellViewModel: TableCellViewModel {
    typealias TableCellType = LabelCell

    let id = UUID().uuidString
    let title: String
}
