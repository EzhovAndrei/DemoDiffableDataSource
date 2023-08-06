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
    let dataSource = UITableViewDiffableDataSource<Sections, Cells>(tableView: tableView) { tableView, indexPath, itemIdentifier in
      switch itemIdentifier {
      case .location:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LocationView.self)) as? LocationView else {
          return UITableViewCell()
        }
        self.presenter.onCellLoaded(cell)
        return cell
      case .payment:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PaymentView.self)) as? PaymentView else {
          return UITableViewCell()
        }
        self.presenter.onCellLoaded(cell)
        return cell
      case .tip:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TipView.self)) as? TipView else {
          return UITableViewCell()
        }
        self.presenter.onCellLoaded(cell)
        return cell
      case .expedition:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExpeditionView.self)) as? ExpeditionView else {
          return UITableViewCell()
        }
        self.presenter.onCellLoaded(cell)
        return cell
      case .product:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self)) as? ProductCell else {
          return UITableViewCell()
        }
        self.presenter.onProductCellDidLoaded(cell, indexPath: indexPath)
        return cell
      }
    }
    return dataSource
  }()

  private lazy var tableView = {
    let tableView = UITableView()
    tableView.contentInset = .init(top: 600, left: 0, bottom: 600, right: 0)
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

    tableView.register(LocationView.self, forCellReuseIdentifier: String(describing: LocationView.self))
    tableView.register(PaymentView.self, forCellReuseIdentifier: String(describing: PaymentView.self))
    tableView.register(TipView.self, forCellReuseIdentifier: String(describing: TipView.self))
    tableView.register(ExpeditionView.self, forCellReuseIdentifier: String(describing: ExpeditionView.self))
    tableView.register(ProductCell.self, forCellReuseIdentifier: String(describing: ProductCell.self))
  }

  func applySnapshot(_ snapshot: NSDiffableDataSourceSnapshot<Sections, Cells>) {
    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func refreshProductCells() {
    tableView.visibleCells.forEach { cell in
      guard let productCell = cell as? ProductCell, let indexPath = tableView.indexPath(for: productCell) else { return }
      presenter.onProductCellDidLoaded(productCell, indexPath: indexPath)
    }
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
