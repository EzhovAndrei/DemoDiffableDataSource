//
//  ProductBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

class ProductComponent {
  private var tableViewCell: UIView?
  
  private func build(_ mediator: CartMediator) {
    let interactor = ProductInteractor()
    let view = ProductView()
    let presenter = ProductPresenter(
      interactor: interactor,
      viewModelBuilder: ProductViewModelBuilder(),
      mediator: mediator
    )
    presenter.view = view
    view.presenter = presenter
    interactor.presenter = presenter
    mediator.addObserver(presenter)
    presenter.onViewDidLoad()
    self.tableViewCell = view
  }
}

extension ProductComponent: ComponentProtocol {
  func isVisible(_ mediator: CartMediator) -> Bool {
    let isVisible = !CartDomainModel.shared.products.isEmpty
    if isVisible, tableViewCell == nil {
      build(mediator)
    } else if !isVisible {
      tableViewCell = nil
    }
    return true
  }
  var cell: Cells { .product(self) }
  var view: UIView { tableViewCell ?? UIView() }
  static func == (lhs: ProductComponent, rhs: ProductComponent) -> Bool { true }
  func hash(into hasher: inout Hasher) {}
}
