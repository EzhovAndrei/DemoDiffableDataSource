//
//  CartViewController.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

class CartViewController: UIViewController {
  private lazy var presenter = {
    let interactor = CartInteractor()
    let presenter = CartPresenter(interactor: interactor)
    interactor.presenter = presenter
    presenter.view = self
    return presenter
  }()

  private lazy var dataSource: UITableViewDiffableDataSource<Sections, Cells> = {
    let dataSource = UITableViewDiffableDataSource<Sections, Cells>(tableView: tableView) { tableView, _, itemIdentifier in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContainerCell") as? ContainerCell else {
        return UITableViewCell()
      }
      let view: UIView
      switch itemIdentifier {
      case let .location(component):
        view = component.view
      case let .payment(component):
        view = component.view
      case let .tip(component):
        view = component.view
      case let .expedition(component):
        view = component.view
      case let .product(component):
        view = component.view
        view.bounds = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10000)
        view.layoutIfNeeded()
      }
      cell.insertContent(view, insets: true)
      return cell
    }
    return dataSource
  }()

  private lazy var tableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.contentInset = .init(top: 600, left: 0, bottom: 600, right: 0)
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    tableView.register(ContainerCell.self, forCellReuseIdentifier: "ContainerCell")
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    presenter.onViewDidLoad()
  }

  private func setUpView() {
    view.backgroundColor = .white
    view.addSubview(tableView)
    NSLayoutConstraint.useAndActivate([
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension CartViewController {
  func applySnapshot(_ components: [any ComponentProtocol]) {
    var snapshot = NSDiffableDataSourceSnapshot<Sections, Cells>()
    snapshot.appendSections([.content])
    snapshot.appendItems(components.map { $0.cell }, toSection: .content)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

extension NSLayoutConstraint {
  static func useAndActivate(_ constraints: [NSLayoutConstraint]) {
    constraints
      .compactMap { $0.firstItem as? UIView }
      .filter { $0.translatesAutoresizingMaskIntoConstraints }
      .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    activate(constraints)
  }
}

extension CartViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
}
