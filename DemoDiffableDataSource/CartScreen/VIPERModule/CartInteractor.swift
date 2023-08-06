//
//  CartInteractor.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class CartInteractor {
  private let cart = CartDomainModel.shared
  weak var presenter: CartPresenter?
  init() {}
}
