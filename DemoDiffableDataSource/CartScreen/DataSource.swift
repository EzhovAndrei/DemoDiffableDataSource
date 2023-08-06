//
//  DataSource.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import UIKit

enum Sections: Hashable {
  case expedition
  case location
  case payment
  case tip
  case product
}

enum Cells: Hashable {
  case expedition
  case location
  case payment
  case tip
  case product(UUID)
}
