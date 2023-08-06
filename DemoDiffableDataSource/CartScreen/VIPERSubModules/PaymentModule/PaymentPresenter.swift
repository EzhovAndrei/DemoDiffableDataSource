//
//  PaymentPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class PaymentPresenter {
  private let interactor: PaymentInteractor
  private let viewModelBuilder: PaymentViewModelBuilder
  private let mediator: CartMediator
  weak var view: PaymentView?
  var isVisible: Bool { true }

  init(
    interactor: PaymentInteractor,
    viewModelBuilder: PaymentViewModelBuilder,
    mediator: CartMediator
  ) {
    self.interactor = interactor
    self.viewModelBuilder = viewModelBuilder
    self.mediator = mediator
  }

  func onViewLoaded() {
    interactor.loadPaymentMethod()
  }

  func onChangePaymentMethod() {
    interactor.changePaymentMethod()
  }

  func paymentMethodLoaded(_ method: Payment) {
    let viewModel = viewModelBuilder.viewModel(method)
    view?.updateView(viewModel)
  }
  
  func paymentMethodUpdated(_ method: Payment) {
    mediator.cartWasUpdated(self)
    let viewModel = viewModelBuilder.viewModel(method)
    view?.updateView(viewModel)
  }
}

extension PaymentPresenter: CartPresenterObserving {
  func onCartUpdated() {
    interactor.loadPaymentMethod()
  }
}
