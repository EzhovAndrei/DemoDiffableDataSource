//
//  ComponentProtocol.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 18.08.23.
//

import UIKit

protocol ComponentProtocol: Hashable {
  var cell: Cells { get }
  var view: UIView { get }
  func isVisible(_ mediator: CartMediator) -> Bool
}
