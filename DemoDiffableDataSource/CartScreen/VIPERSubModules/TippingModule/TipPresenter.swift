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
  weak var view: TipView?
  var isVisible: Bool {
    let domainModel = interactor.domainModel
    return domainModel.expedition == .delivery && domainModel.payment == .card
  }

  init(
    interactor: TipInteractor,
    mediator: CartMediator
  ) {
    self.interactor = interactor
    self.mediator = mediator
  }
}

extension TipPresenter: CartPresenterObserving {
  func onCartUpdated() {}
}
