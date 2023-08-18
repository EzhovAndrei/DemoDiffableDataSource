//
//  ExpeditionPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class ExpeditionPresenter: CartPresenterObserving {
  private let interactor: ExpeditionInteractor
  private let viewModelBuilder: ExpeditionViewModelBuilder
  private let mediator: CartMediator
  private weak var view: ExpeditionView?

  init(
    interactor: ExpeditionInteractor,
    viewModelBuilder: ExpeditionViewModelBuilder,
    mediator: CartMediator,
    view: ExpeditionView
  ) {
    self.interactor = interactor
    self.viewModelBuilder = viewModelBuilder
    self.mediator = mediator
    self.view = view
  }

  func onViewLoaded() {
    interactor.loadExpeditionMethod()
  }

  func onChangeExpeditionMethod() {
    interactor.changeExpeditionMethod()
  }

  func expeditionMethodUpdated(_ method: Expedition) {
    mediator.cartWasUpdated(self)
    let viewModel = viewModelBuilder.viewModel(method)
    view?.updateView(viewModel)
  }

  func expeditionMethodLoaded(_ method: Expedition) {
    let viewModel = viewModelBuilder.viewModel(method)
    view?.updateView(viewModel)
  }
}

extension ExpeditionPresenter: SubPresenting {
  func onCartUpdated() {
    interactor.loadExpeditionMethod()
  }
}
