//
//  CartPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

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
    var snapshot = NSDiffableDataSourceSnapshot<Sections, Cells>()
    snapshot.appendSections([.content])
    components.forEach { component in
      if component.isVisible(cartMediator) {
        snapshot.appendItems([component.cell], toSection: .content)
      }
    }
    view?.applySnapshot(snapshot)
  }
}
