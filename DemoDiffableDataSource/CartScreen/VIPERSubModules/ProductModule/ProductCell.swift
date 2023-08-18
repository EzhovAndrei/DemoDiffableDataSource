//
//  ProductCell.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 03.08.23.
//

import UIKit

final class ProductCell: UITableViewCell {
  weak var delegate: ProductPresenter?
  private lazy var buttonDecrease = {
    let button = UIButton()
    button.setTitle("Decrease", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.addTarget(self, action: #selector(removeProduct), for: .touchUpInside)
    return button
  }()

  private lazy var buttonIncrease = {
    let button = UIButton()
    button.setTitle("Increase", for: .normal)
    button.setTitleColor(.green, for: .normal)
    button.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
    return button
  }()

  private lazy var stackView = {
    let view = UIStackView()
    view.axis = .vertical
    return view
  }()

  private lazy var stackViewProduct = {
    let view = UIStackView()
    view.spacing = 20
    view.axis = .horizontal
    return view
  }()

  private lazy var stackViewButtons = {
    let view = UIStackView()
    view.axis = .horizontal
    view.distribution = .fillEqually
    return view
  }()

  private lazy var titleLabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18)
    return label
  }()

  private lazy var countLabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20)
    return label
  }()

  private lazy var productImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    return image
  }()

  private var viewModel: ProductUIModel?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
    contentView.backgroundColor = .white
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayout() {
    contentView.addSubview(stackView)
    stackView.addArrangedSubview(stackViewProduct)
    stackView.addArrangedSubview(stackViewButtons)
    stackViewProduct.addArrangedSubview(productImageView)
    stackViewProduct.addArrangedSubview(countLabel)
    stackViewProduct.addArrangedSubview(titleLabel)
    stackViewButtons.addArrangedSubview(buttonDecrease)
    stackViewButtons.addArrangedSubview(buttonIncrease)

    NSLayoutConstraint.activate([
      productImageView.heightAnchor.constraint(equalToConstant: 100),
      stackView.heightAnchor.constraint(equalToConstant: 200),
      productImageView.widthAnchor.constraint(equalToConstant: 100),
      countLabel.widthAnchor.constraint(equalToConstant: 50)
    ])

    // Pin stackView to superview
    stackView.pinToSuperview()

    startAnimation()
  }

  func startAnimation() {
    titleLabel.transform = .identity
    layer.removeAllAnimations()
    DispatchQueue.main.async {
      UIView.animate(
        withDuration: 5,
        delay: 0,
        options: [.curveEaseOut, .repeat, .autoreverse]) {
          self.titleLabel.transform = CGAffineTransform(translationX: 100, y: 0)
        }
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    startAnimation()
  }

  func updateView(_ viewModel: ProductUIModel) {
    self.viewModel = viewModel
    titleLabel.text = viewModel.title
    countLabel.text = viewModel.count
    productImageView.image = viewModel.image
  }

  @objc func removeProduct() {
    delegate?.onRemoveTap(viewModel!.id)
  }

  @objc func addProduct() {
    delegate?.onAddTap(viewModel!.id)
  }
}
