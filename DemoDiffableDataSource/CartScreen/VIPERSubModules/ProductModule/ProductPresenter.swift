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
  weak var view: ProductView?

  init(
    interactor: ProductInteractor,
    viewModelBuilder: ProductViewModelBuilder,
    mediator: CartMediator
  ) {
    self.interactor = interactor
    self.viewModelBuilder = viewModelBuilder
    self.mediator = mediator
  }

  func onRemoveTap(_ id: UUID) {
    interactor.remove(id)
  }

  func onAddTap(_ id: UUID) {
    interactor.add(id)
  }

  func onProductUpdated() {
    onCartUpdated()
    mediator.cartWasUpdated(self)
  }

  func onViewDidLoad() {
    onCartUpdated()
  }
}

extension ProductPresenter: CartPresenterObserving {
  func onCartUpdated() {
    let uiModels = interactor.products.map { viewModelBuilder.viewModel($0) }
    view?.applyModels(uiModels)
  }
}

