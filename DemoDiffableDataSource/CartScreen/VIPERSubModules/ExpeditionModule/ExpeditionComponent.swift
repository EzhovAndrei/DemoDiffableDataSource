//
//  ExpeditionBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 03.08.23.
//

import UIKit

final class ExpeditionComponent {
  private var _view: UIView?

  private func build(_ mediator: CartMediator) {
    let interactor = ExpeditionInteractor()
    let view = ExpeditionView()
    let presenter = ExpeditionPresenter(
      interactor: interactor,
      viewModelBuilder: ExpeditionViewModelBuilder(),
      mediator: mediator,
      view: view
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    view.presenter = presenter
    _view = view
    presenter.onViewLoaded()
  }
}

extension ExpeditionComponent: ComponentProtocol {
  func isVisible(_ mediator: CartMediator) -> Bool {
    if _view == nil {
      build(mediator)
    }
    return true
  }
  var cell: Cells { .expedition(self) }
  var view: UIView { _view ?? UIView() }
  static func == (lhs: ExpeditionComponent, rhs: ExpeditionComponent) -> Bool { true }
  func hash(into hasher: inout Hasher) {}
}
