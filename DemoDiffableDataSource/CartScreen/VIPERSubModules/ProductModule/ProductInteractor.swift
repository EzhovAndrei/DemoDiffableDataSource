//
//  ProductInteractor.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

class ProductInteractor {
  private let cart = CartDomainModel.shared
  var products: [Product] {
    cart.products
  }
  weak var presenter: ProductPresenter?

  init() {}

  func product(at index: Int) -> Product? {
    guard cart.products.count > index else { return nil }
    return cart.products[index]
  }

  func remove(_ id: UUID) {
    cart.decreaseProduct(id)
    presenter?.onProductUpdated()
  }

  func add(_ id: UUID) {
    cart.increaseProduct(id)
    presenter?.onProductUpdated()
  }
}
