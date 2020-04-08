//
//  CardCell.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 08/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSourcesExt

class CardCell: UICollectionViewCell, ConfigurableCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    var disposeBag = DisposeBag()

    func configure(with viewModel: CardCellViewModel) {
        titleLabel.text = viewModel.title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

