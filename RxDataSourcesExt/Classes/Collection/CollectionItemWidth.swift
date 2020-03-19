//
//  CollectionItemWidth.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 19/03/2020.
//

import Foundation

/// Width for `UICollectionViewCell`
public enum CollectionItemWidth: Equatable {
    /// Just normal `CGfloat` width
    case absolute(CGFloat)
    /// percentage of `UICollectionViewCell` width considering insets and spacings
    case relative(percentage: Int)
}
