//
//  ProductPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 03.08.23.
//

import Foundation

class ProductPresenter {
  private let interactor: ProductInteractor
  private let viewModelBuilder: ProductViewModelBuilder
  private let mediator: CartMediator
  weak var view: CartViewController?

  init(
    interactor: ProductInteractor,
    viewModelBuilder: ProductViewModelBuilder,
    mediator: CartMediator
  ) {
    self.interactor = interactor
    self.viewModelBuilder = viewModelBuilder
    self.mediator = mediator
  }

  func onProductCellDidLoaded(_ cell: ProductCell, indexPath: IndexPath) {
    guard let product = interactor.product(at: indexPath.row) else { return }
    let productViewModel = viewModelBuilder.viewModel(product)
    cell.updateView(productViewModel)
    cell.presenter = self
  }

  func onRemoveTap(_ id: UUID) {
    interactor.remove(id)
  }

  func onAddTap(_ id: UUID) {
    interactor.add(id)
  }

  func isVisible() -> [UUID] {
    interactor.products.map { $0.id }
  }

  func onProductUpdated() {
    mediator.cartWasUpdated(self)
    view?.refreshProductCells()
  }
}

extension ProductPresenter: CartPresenterObserving {
  func onCartUpdated() {
    view?.refreshProductCells()
  }
}

