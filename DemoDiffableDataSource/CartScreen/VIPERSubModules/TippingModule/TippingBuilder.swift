//
//  TippingBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

final class TipComponent {
  private var tableViewCell: UIView?

  private  func build(_ mediator: CartMediator) {
    let interactor = TipInteractor()
    let view = TipView()
    let presenter = TipPresenter(
      interactor: interactor,
      mediator: mediator,
      view: view
    )
    view.presenter = presenter
    mediator.addObserver(presenter)
    interactor.presenter = presenter
    self.tableViewCell = view
  }
}

extension TipComponent: ComponentProtocol {
  func isVisible(_ mediator: CartMediator) -> Bool {
    let domainModel = CartDomainModel.shared
    let isVisible = domainModel.expedition == .delivery && domainModel.payment == .card
    if isVisible, tableViewCell == nil {
      build(mediator)
    } else if !isVisible {
      tableViewCell = nil
    }
    return isVisible
  }
  var cell: Cells { .tip(self) }
  var view: UIView { tableViewCell ?? UIView() }
  static func == (lhs: TipComponent, rhs: TipComponent) -> Bool { true }
  func hash(into hasher: inout Hasher) {}
}
