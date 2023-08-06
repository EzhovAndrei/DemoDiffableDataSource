//
//  LocationViewModelBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import Foundation

class LocationViewModelBuilder {
  init() {}

  func viewModel(_ location: String, expedition: Expedition) -> LocationViewModel? {
    let expeditionString = expedition == .delivery ? "Delivery" : "Pick Up"
    return LocationViewModel(title: location + " " + expeditionString)
  }
}
