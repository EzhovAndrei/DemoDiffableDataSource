//
//  PaymentBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

final class PaymentComponent {
  private var tableViewCell: UIView?

  private func build(_ mediator: CartMediator) {
    let interactor = PaymentInteractor()
    let view = PaymentView()
    let presenter = PaymentPresenter(
      interactor: interactor,
      viewModelBuilder: PaymentViewModelBuilder(),
      mediator: mediator,
      view: view
    )
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    view.presenter = presenter
    self.tableViewCell = view
    presenter.onViewLoaded()
  }
}

extension PaymentComponent: ComponentProtocol {
  func isVisible(_ mediator: CartMediator) -> Bool {
    if tableViewCell == nil {
      build(mediator)
    }
    return true
  }
  var cell: Cells { .payment(self) }
  var view: UIView { tableViewCell ?? UIView() }
  static func == (lhs: PaymentComponent, rhs: PaymentComponent) -> Bool { true }
  func hash(into hasher: inout Hasher) {}
}
