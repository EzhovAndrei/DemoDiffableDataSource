//
//  CartPresenter.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

protocol SubPresenting: AnyObject {
  func onCartUpdated()
}

final class CartPresenter {
  private let interactor: CartInteractor
  private var modules: [Sections: SubPresenting] = [:]
  private let cartMediator: CartMediator
  private lazy var expeditionPresenter: ExpeditionPresenter = {
    ExpeditionBuilder.build(cartMediator)
  }()
  private lazy var locationPresenter: LocationPresenter = {
    LocationBuilder.build(cartMediator)
  }()
  private lazy var paymentPresenter: PaymentPresenter = {
    PaymentBuilder.build(cartMediator)
  }()
  private lazy var tipPresenter: TipPresenter = {
    TipBuilder.build(cartMediator)
  }()
  private var productPresenter: ProductPresenter?

  weak var view: CartViewController? {
    didSet {
      guard let view = view else { return }
      productPresenter = ProductBuilder.build(cartMediator, view: view)
    }
  }

  init(interactor: CartInteractor) {
    self.interactor = interactor
    cartMediator = CartMediator()
    cartMediator.rootPresenter = self
  }

  func onViewDidLoad() {
    onCartUpdated() 
  }

  func onCellLoaded(_ cell: ExpeditionView) {
    cell.presenter = expeditionPresenter
  }

  func onCellLoaded(_ cell: LocationView) {
    cell.presenter = locationPresenter
  }

  func onCellLoaded(_ cell: PaymentView) {
    cell.presenter = paymentPresenter
  }

  func onCellLoaded(_ cell: TipView) {
    cell.presenter = tipPresenter
  }

  func onProductCellDidLoaded(_ cell: ProductCell, indexPath: IndexPath) {
    productPresenter?.onProductCellDidLoaded(cell, indexPath: indexPath)
  }
}

extension CartPresenter {
  func onCartUpdated() {
    var snapshot = NSDiffableDataSourceSnapshot<Sections, Cells>()

    if expeditionPresenter.isVisible {
      snapshot.appendSections([.expedition])
      snapshot.appendItems([.expedition], toSection: .expedition)
    }

    if locationPresenter.isVisible {
      snapshot.appendSections([.location])
      snapshot.appendItems([.location], toSection: .location)
    }

    if paymentPresenter.isVisible {
      snapshot.appendSections([.payment])
      snapshot.appendItems([.payment], toSection: .payment)
    }

    if tipPresenter.isVisible {
      snapshot.appendSections([.tip])
      snapshot.appendItems([.tip], toSection: .tip)
    }

    if let products = productPresenter?.isVisible(), !products.isEmpty {
      snapshot.appendSections([.product])
      products.forEach {
        snapshot.appendItems([.product($0)], toSection: .product)
      }
    }
    view?.applySnapshot(snapshot)
  }
}
