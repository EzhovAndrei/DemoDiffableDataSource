//
//  ExpeditionView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class ExpeditionView: UIView {
  private lazy var switchView = {
    let view = UISwitch()
    view.addTarget(self, action: #selector(changeExpedition), for: .valueChanged)
    return view
  }()

  private lazy var label = {
    let label = UILabel()
    return label
  }()

  var presenter: ExpeditionPresenter?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayout() {
    backgroundColor = .white
    addSubview(label)
    addSubview(switchView)
    NSLayoutConstraint.useAndActivate([
      heightAnchor.constraint(equalToConstant: 80),
      label.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      label.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      label.bottomAnchor.constraint(equalTo: switchView.topAnchor),
      switchView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      switchView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
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
