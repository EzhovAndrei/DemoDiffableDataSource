//
//  TippingBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

final class TipBuilder {
  static func build(_ mediator: CartMediator) -> TipPresenter {
    let interactor = TipInteractor()
    let presenter = TipPresenter(
      interactor: interactor,
      mediator: mediator
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    return presenter
  }
}
