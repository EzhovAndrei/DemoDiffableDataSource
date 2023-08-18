//
//  TipPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class TipPresenter {
  private let interactor: TipInteractor
  private let mediator: CartMediator
  private weak var view: TipView?

  init(
    interactor: TipInteractor,
    mediator: CartMediator,
    view: TipView
  ) {
    self.interactor = interactor
    self.mediator = mediator
    self.view = view
  }
}

extension TipPresenter: CartPresenterObserving {
  func onCartUpdated() {}
}
