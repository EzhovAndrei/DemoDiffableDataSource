//
//  ContainerCell.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 18.08.23.
//

import UIKit

final class ContainerCell: UITableViewCell {
  private lazy var cardView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 10
    view.layer.shadowOpacity = 0.3
    view.layer.shadowRadius = 4
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowColor = UIColor.black.cgColor
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .white
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func insertContent(_ content: UIView, insets: Bool) {
    if insets {
      contentView.addSubview(cardView)
      cardView.pinToSuperview(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
      cardView.addSubview(content)
    } else {
      contentView.addSubview(content)
    }
    content.pinToSuperview(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    cardView.subviews.forEach { $0.removeFromSuperview() }
    contentView.subviews.forEach { $0.removeFromSuperview() }
  }
}
