//
//  ProductView.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 18.08.23.
//

import UIKit

private class ProductDataSource: UITableViewDiffableDataSource<ProductSections, ProductCells> {
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  }
  func applyModels(_ models: [ProductUIModel]) {
    var snapshot = NSDiffableDataSourceSnapshot<ProductSections, ProductCells>()
    snapshot.appendSections([.product])
    snapshot.appendItems(models.map{ ProductCells.product($0) }, toSection: .product)
    apply(snapshot, animatingDifferences: false)
  }
}

final class ProductView: UIView {
  var presenter: ProductPresenter?

  private lazy var dataSource: ProductDataSource = {
    let dataSource = ProductDataSource(tableView: tableView) { _, _, itemIdentifier in
      switch itemIdentifier {
      case let .product(uiModel):
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
          return UITableViewCell()
        }
        cell.updateView(uiModel)
        cell.delegate = self.presenter
        return cell
      }
    }
    return dataSource
  }()

  lazy var tableView: UITableView = {
    let tableView = ProductListTableView()
    tableView.isScrollEnabled = false
    tableView.delegate = self
    tableView.allowsSelection = false
    tableView.contentInset = .zero
    tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
    return tableView
  }()

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
    addSubview(tableView)
    tableView.pinToSuperview()
  }

  func applyModels(_ models: [ProductUIModel]) {
    tableView.beginUpdates()
    dataSource.applyModels(models)
    tableView.endUpdates()
    tableView.indexPathsForVisibleRows?.forEach({ indexPath in
      (tableView.cellForRow(at: indexPath) as? ProductCell)?.updateView(models[indexPath.row])
    })
  }
}

extension ProductView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
}


class ProductListTableView: UITableView {
  override var contentSize: CGSize{
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }

  override func reloadData() {
    super.reloadData()
    self.invalidateIntrinsicContentSize()
  }
}
