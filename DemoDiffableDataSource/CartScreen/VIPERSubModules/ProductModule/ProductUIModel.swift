//
//  ProductUIModel.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

struct ProductUIModel: Hashable {
  let id: UUID
  let count: String
  let title: String
  let image: UIImage?

  func hash(into hasher: inout Hasher) {
    hasher = Hasher()
    hasher.combine(id)
  }

  static func == (lhs: ProductUIModel, rhs: ProductUIModel) -> Bool {
    lhs.id == rhs.id
  }
}
