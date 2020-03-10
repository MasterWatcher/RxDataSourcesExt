//
//  TextCollectionCell.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 10/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSourcesExt

class TextCollectionCell: UICollectionViewCell, ConfigurableCell {

    lazy var button: UIButton = {
        let label = UIButton()
        label.setTitleColor(.white, for: .normal)
        return label
    }()

    var disposeBag = DisposeBag()

    func configure(with viewModel: TextCollectionCellViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

