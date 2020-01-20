//
//  CollectionContainableCell.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit

public protocol CollectionContainableCell: DisposableCell {
    var collectionView: UICollectionView { get }
}
