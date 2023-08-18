//
//  LocationPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

final class LocationPresenter {
  private let interactor: LocationInteractor
  private let viewModelBuilder: LocationViewModelBuilder
  private weak var view: LocationView?

  init(
    interactor: LocationInteractor,
    viewModelBuilder: LocationViewModelBuilder,
    view: LocationView
  ) {
    self.interactor = interactor
    self.viewModelBuilder = viewModelBuilder
    self.view = view
  }

  func onViewLoaded() {
    interactor.loadLocation()
  }

  func locationLoaded(_ location: String, expedition: Expedition) {
    let viewModel = viewModelBuilder.viewModel(location, expedition: expedition)
    view?.updateView(viewModel)
  }
}

extension LocationPresenter: CartPresenterObserving {
  func onCartUpdated() {
    interactor.loadLocation()
  }
}
