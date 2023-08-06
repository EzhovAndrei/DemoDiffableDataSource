//
//  LocationBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class LocationBuilder {
  static func build(_ mediator: CartMediator) -> LocationPresenter {
    let interactor = LocationInteractor()
    let presenter = LocationPresenter(
      interactor: interactor,
      viewModelBuilder: LocationViewModelBuilder()
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    return presenter
  }
}
