//
//  DataSource.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

enum Sections: Hashable {
  case content
}

enum Cells: Hashable {
  case expedition(ExpeditionComponent)
  case location(LocationComponent)
  case payment(PaymentComponent)
  case tip(TipComponent)
  case product(ProductComponent)
}

enum ProductSections: Hashable {
  case product
}

enum ProductCells: Hashable {
  case product(ProductUIModel)
}
