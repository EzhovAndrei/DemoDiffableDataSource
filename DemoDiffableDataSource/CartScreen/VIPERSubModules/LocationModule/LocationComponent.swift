//
//  LocationBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class LocationComponent {
  private var tableViewCell: UIView?

  private func build(_ mediator: CartMediator) {
    let interactor = LocationInteractor()
    let view = LocationView()
    let presenter = LocationPresenter(
      interactor: interactor,
      viewModelBuilder: LocationViewModelBuilder(),
      view: view
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    view.presenter = presenter
    self.tableViewCell = view
    presenter.onViewLoaded()
  }
}

extension LocationComponent: ComponentProtocol {
  var cell: Cells { .location(self) }
  var view: UIView { tableViewCell ?? UIView() }
  static func == (lhs: LocationComponent, rhs: LocationComponent) -> Bool { true }
  func hash(into hasher: inout Hasher) {}
  func isVisible(_ mediator: CartMediator) -> Bool {
    if tableViewCell == nil {
      build(mediator)
    }
    return true
  }
}
