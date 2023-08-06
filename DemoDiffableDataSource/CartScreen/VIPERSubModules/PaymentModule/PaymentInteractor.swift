//
//  PaymentInteractor.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class PaymentInteractor {
  private let cart = CartDomainModel.shared
  weak var presenter: PaymentPresenter?
  init() {}

  func changePaymentMethod() {
    if cart.payment == .cod {
      cart.payment = .card
    } else {
      cart.payment = .cod
    }
    presenter?.paymentMethodUpdated(cart.payment)
  }

  func loadPaymentMethod() {
    presenter?.paymentMethodLoaded(cart.payment)
  }
}
