//
//  ProductViewModelBuilder.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 05.08.23.
//

import UIKit

class ProductViewModelBuilder {
  init() {}

  func viewModel(_ product: Product) -> ProductViewModel {
    ProductViewModel(
      id: product.id,
      count: "\(product.count)",
      title: product.name,
      image: UIImage(named:  product.imageName)
    )
  }
}
