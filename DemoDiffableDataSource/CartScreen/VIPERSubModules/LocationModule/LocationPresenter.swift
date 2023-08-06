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
  weak var view: LocationView?
  var isVisible: Bool { true }

  init(
    interactor: LocationInteractor,
    viewModelBuilder: LocationViewModelBuilder
  ) {
    self.interactor = interactor
    self.viewModelBuilder = viewModelBuilder
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
