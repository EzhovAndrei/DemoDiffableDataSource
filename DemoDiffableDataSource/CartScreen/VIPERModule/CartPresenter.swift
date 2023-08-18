//
//  CartPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import Foundation

protocol SubPresenting: AnyObject {
  func onCartUpdated()
}

final class CartPresenter {
  private let interactor: CartInteractor
  private var modules: [Sections: SubPresenting] = [:]
  private let cartMediator: CartMediator
  private let components: [any ComponentProtocol] = [
    ProductComponent(), ExpeditionComponent(), TipComponent(), LocationComponent(), PaymentComponent()
  ]

  weak var view: CartViewController?

  init(interactor: CartInteractor) {
    self.interactor = interactor
    cartMediator = CartMediator()
    cartMediator.rootPresenter = self
  }

  func onViewDidLoad() {
    onCartUpdated()
  }
}

extension CartPresenter {
  func onCartUpdated() {
    let snapshot = components.filter { component in
      component.isVisible(cartMediator)
    }
    view?.applySnapshot(snapshot)
  }
}
