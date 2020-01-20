//
//  ButtonCell.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 20/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSourcesExt

class ButtonCell: UITableViewCell, ConfigurableCell {

    var disposeBag = DisposeBag()

    lazy var button = UIButton()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        button.setTitleColor(.blue, for: .normal)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: ButtonCellViewModel) {
        button.setTitle(viewModel.title, for: .normal)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
