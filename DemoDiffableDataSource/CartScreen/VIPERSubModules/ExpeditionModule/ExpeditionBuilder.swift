//
//  ExpeditionBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 03.08.23.
//

import UIKit

final class ExpeditionBuilder {
  static func build(_ mediator: CartMediator) -> ExpeditionPresenter {
    let interactor = ExpeditionInteractor()
    let presenter = ExpeditionPresenter(
      interactor: interactor,
      viewModelBuilder: ExpeditionViewModelBuilder(),
      mediator: mediator
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    return presenter
  }
}
