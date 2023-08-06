//
//  PaymentBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class PaymentBuilder {
  static func build(_ mediator: CartMediator) -> PaymentPresenter {
    let interactor = PaymentInteractor()
    let presenter = PaymentPresenter(
      interactor: interactor,
      viewModelBuilder: PaymentViewModelBuilder(),
      mediator: mediator
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    return presenter
  }
}
