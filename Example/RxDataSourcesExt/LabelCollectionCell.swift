//
//  LabelCollectionCell.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 19/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSourcesExt

class LabelCollectionCell: UICollectionViewCell, ConfigurableCell {

    var disposeBag = DisposeBag()

    private lazy var titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    func configure(with viewModel: LabelCollectionCellViewModel) {
        titleLabel.text = viewModel.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

