//
//  CartMediator.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

class CartMediator {
  private var weakObservers = NSHashTable<CartPresenterObserving>.weakObjects()
  weak var rootPresenter: CartPresenter?

  func addObserver(_ observer: CartPresenterObserving) {
    weakObservers.add(observer)
  }

  func cartWasUpdated(_ sender: CartPresenterObserving) {
    weakObservers.allObjects.forEach {
      guard $0 !== sender else { return }
      $0.onCartUpdated()
    }
    rootPresenter?.onCartUpdated()
  }
}
