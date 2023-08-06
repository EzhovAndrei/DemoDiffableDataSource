//
//  TipView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class TipView: UITableViewCell {
  private lazy var label = {
    let label = UILabel()
    label.text = "Tip"
    return label
  }()
  var presenter: TipPresenter? {
    didSet {
      presenter?.view = self
    }
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
    contentView.backgroundColor = .white
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayout() {
    contentView.addSubview(label)
    NSLayoutConstraint.useAndActivate([
      label.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
      label.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
      label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
      label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
      label.heightAnchor.constraint(equalToConstant: 100)
    ])
  }
}
