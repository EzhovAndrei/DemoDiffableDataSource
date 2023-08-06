//
//  ExpeditionViewModelBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

class ExpeditionViewModelBuilder {
  func viewModel(_ method: Expedition) -> ExpeditionViewModel? {
    switch method {
    case .pickup:
      return ExpeditionViewModel(title: "Pick up", toggle: false)
    case .delivery:
      return ExpeditionViewModel(title: "Delivery", toggle: true)
    }
  }
}
