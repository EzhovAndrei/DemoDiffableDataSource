//
//  TipView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class TipView: UIView {
  private lazy var label = {
    let label = UILabel()
    label.text = "Tip"
    return label
  }()

  var presenter: TipPresenter?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
    backgroundColor = .white
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayout() {
    addSubview(label)
    label.pinToSuperview()
    NSLayoutConstraint.useAndActivate([
      heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}
