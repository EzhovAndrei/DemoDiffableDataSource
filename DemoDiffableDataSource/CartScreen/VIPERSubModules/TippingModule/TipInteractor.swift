//
//  TipInteractor.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class TipInteractor {
  private let cart = CartDomainModel.shared
  var domainModel: CartDomainModel {
    cart
  }

  weak var presenter: TipPresenter?

  init() {}
}
