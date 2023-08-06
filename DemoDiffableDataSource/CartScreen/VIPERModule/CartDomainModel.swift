//
//  CartDomainModel.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 02.08.23.
//

import Foundation

enum Payment {
  case card, cod
}

enum Expedition {
  case pickup, delivery
}

class Product {
  let name: String
  var count: Int
  let id: UUID
  let imageName: String
  init(name: String, count: Int, imageName: String) {
    self.name = name
    self.count = count
    self.imageName = imageName
    id = UUID()
  }
}

class CartDomainModel {
  var expedition: Expedition = .delivery
  var location = "Location"
  var payment = Payment.cod
  var tips = 10
  var products = [
    Product(name: "Pizza", count: 3, imageName: "pizza"),
    Product(name: "Burger", count: 2, imageName: "burger"),
    Product(name: "Coca Cola", count: 3, imageName: "cocacola"),
    Product(name: "ice cream", count: 2, imageName: "icecream")
  ]
  static let shared = CartDomainModel()
  private init() {}

  func decreaseProduct(_ id: UUID) {
    guard let index = products.firstIndex(where: { $0.id == id }) else { return }
    let product = products[index]
    let newCount = product.count - 1
    if newCount == 0 {
      products.remove(at: index)
    } else {
      product.count = newCount
    }
  }
  func increaseProduct(_ id: UUID) {
    guard let index = products.firstIndex(where: { $0.id == id }) else { return }
    let product = products[index]
    let newCount = product.count + 1
    if newCount > 5 {
      let newProduct = Product(name: product.name, count: 1, imageName: product.imageName)
      products.insert(newProduct, at: index + 1)
      product.count = 5
    } else {
      product.count = newCount
    }
  }
}
