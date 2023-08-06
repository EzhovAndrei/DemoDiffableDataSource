//
//  ProductBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

class ProductBuilder {
  static func build(_ mediator: CartMediator, view: CartViewController) -> ProductPresenter {
    let interactor = ProductInteractor()
    let presenter = ProductPresenter(
      interactor: interactor,
      viewModelBuilder: ProductViewModelBuilder(),
      mediator: mediator
    )
    presenter.view = view
    interactor.presenter = presenter
    mediator.addObserver(presenter)
    return presenter
  }
}
