//
//  LocationView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class LocationView: UIView {
  private lazy var label = {
    let label = UILabel()
    return label
  }()

  var presenter: LocationPresenter?

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
    NSLayoutConstraint.useAndActivate([
      label.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      label.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      heightAnchor.constraint(equalToConstant: 100)
    ])
  }

  func updateView(_ viewModel: LocationViewModel?) {
    guard let viewModel = viewModel else { return }
    label.text = viewModel.title
  }
}
