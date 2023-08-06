//
//  ExpeditionView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class ExpeditionView: UITableViewCell {
  private lazy var switchView = {
    let view = UISwitch()
    view.addTarget(self, action: #selector(changeExpedition), for: .valueChanged)
    return view
  }()

  private lazy var label = {
    let label = UILabel()
    return label
  }()

  var presenter: ExpeditionPresenter? {
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
    contentView.addSubview(switchView)
    NSLayoutConstraint.useAndActivate([
      label.heightAnchor.constraint(equalToConstant: 100),
      label.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
      label.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
      label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
      label.bottomAnchor.constraint(equalTo: switchView.topAnchor),
      switchView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
      switchView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  func updateView(_ viewModel: ExpeditionViewModel?) {
    guard let viewModel = viewModel else { return }
    label.text = viewModel.title
    switchView.isOn = viewModel.toggle
  }

  @objc func changeExpedition() {
    presenter?.onChangeExpeditionMethod()
  }
}
