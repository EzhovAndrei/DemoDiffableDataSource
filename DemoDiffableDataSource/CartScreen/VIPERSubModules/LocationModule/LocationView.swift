//
//  LocationView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class LocationView: UITableViewCell {
  private lazy var label = {
    let label = UILabel()
    return label
  }()

  var presenter: LocationPresenter? {
    didSet {
      presenter?.view = self
      presenter?.onViewLoaded()
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

  func updateView(_ viewModel: LocationViewModel?) {
    guard let viewModel = viewModel else { return }
    label.text = viewModel.title
  }
}
