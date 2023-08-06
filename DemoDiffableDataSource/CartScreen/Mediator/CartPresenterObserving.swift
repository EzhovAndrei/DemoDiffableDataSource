//
//  CartPresenterObserving.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

@objc protocol CartPresenterObserving {
  func onCartUpdated()
}
