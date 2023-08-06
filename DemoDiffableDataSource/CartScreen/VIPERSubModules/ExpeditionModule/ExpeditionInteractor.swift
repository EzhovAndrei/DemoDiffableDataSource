//
//  ExpeditionInteractor.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class ExpeditionInteractor {
  private let cart = CartDomainModel.shared
  weak var presenter: ExpeditionPresenter?

  init() {}

  func changeExpeditionMethod() {
    if cart.expedition == .delivery {
      cart.expedition = .pickup
    } else {
      cart.expedition = .delivery
    }
    presenter?.expeditionMethodUpdated(cart.expedition)
  }

  func loadExpeditionMethod() {
    presenter?.expeditionMethodLoaded(cart.expedition)
  }
}
