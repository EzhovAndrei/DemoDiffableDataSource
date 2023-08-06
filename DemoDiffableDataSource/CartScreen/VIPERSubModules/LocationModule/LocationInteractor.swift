//
//  LocationInteractor.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class LocationInteractor {
  private let cart = CartDomainModel.shared
  weak var presenter: LocationPresenter?

  init() {}

  func loadLocation() {
    presenter?.locationLoaded(cart.location, expedition: cart.expedition)
  }
}
