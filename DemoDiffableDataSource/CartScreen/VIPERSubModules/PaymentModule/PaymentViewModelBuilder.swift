//
//  PaymentViewModelBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

class PaymentViewModelBuilder {
  init() {}

  func viewModel(_ method: Payment) -> PaymentViewModel? {
    switch method {
    case .cod:
      return PaymentViewModel(title: "Cash", toggle: false)
    case .card:
      return PaymentViewModel(title: "Bank Card", toggle: true)
    }
  }
}
