//
//  UIView+Ext.swift
//  DemoDiffableDataSource
//
//  Created by Andrei Ezhov on 18.08.23.
//

import UIKit

extension UIView {
  // MARK: pint(view:edgeInset:)

  func pin(to view: UIView) {
    pin(to: view, edgeInsets: UIEdgeInsets())
  }

  func pin(to view: UIView, edgeInsets spacing: CGFloat) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let uiEdgeInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: -spacing, right: -spacing)
    pin(to: view, edgeInsets: uiEdgeInsets)
  }

  enum EdgeInset {
    case spacing(vertical: CGFloat, horizontal: CGFloat)
  }

  func pin(to view: UIView, edgeInsets edgeInset: EdgeInset) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let uiEdgeInsets: UIEdgeInsets
    switch edgeInset {
    case let .spacing(vertical, horizontal):
      uiEdgeInsets = UIEdgeInsets(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
    }
    pin(to: view, edgeInsets: uiEdgeInsets)
  }

  enum ViewEdgeInset {
    case layoutMargins
    case safeArea
  }

  func pin(to view: UIView, edgeInsets viewEdgeInset: ViewEdgeInset) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let uiEdgeInsets: UIEdgeInsets
    switch viewEdgeInset {
    case .layoutMargins: uiEdgeInsets = view.layoutMargins
    case .safeArea: uiEdgeInsets = view.safeAreaInsets
    }
    pin(to: view, edgeInsets: uiEdgeInsets)
  }

  func pin(to view: UIView, edgeInsets uiEdgeInsets: UIEdgeInsets) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let constraints = [
      leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: uiEdgeInsets.left),
      trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: uiEdgeInsets.right),
      bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: uiEdgeInsets.bottom),
      topAnchor.constraint(equalTo: view.topAnchor, constant: uiEdgeInsets.top)
    ]
    NSLayoutConstraint.useAndActivate(constraints)
  }

  // MARK: pint(view:layoutGuide:)

  enum ViewLayoutGuide {
    case margins
    case readableContent
    case safeArea
  }

  func pin(to view: UIView, layoutGuide viewLayoutGuide: ViewLayoutGuide) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let uiLayoutGuide: UILayoutGuide
    switch viewLayoutGuide {
    case .margins: uiLayoutGuide = view.layoutMarginsGuide
    case .readableContent: uiLayoutGuide = view.readableContentGuide
    case .safeArea: uiLayoutGuide = view.safeAreaLayoutGuide
    }
    pin(to: view, layoutGuide: uiLayoutGuide)
  }

  func pin(to view: UIView, layoutGuide uiLayoutGuide: UILayoutGuide) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let constraints = [
      leadingAnchor.constraint(equalTo: uiLayoutGuide.leadingAnchor),
      trailingAnchor.constraint(equalTo: uiLayoutGuide.trailingAnchor),
      topAnchor.constraint(equalTo: uiLayoutGuide.topAnchor),
      bottomAnchor.constraint(equalTo: uiLayoutGuide.bottomAnchor)
    ]
    NSLayoutConstraint.useAndActivate(constraints)
  }

  // MARK: pint(view:layoutAnchor:)

  enum LayoutAnchor {
    case top(padding: CGFloat = 0)
    case center
    case bottom(padding: CGFloat = 0)
  }

  func pin(to view: UIView, layoutAnchor: LayoutAnchor) {
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    let constraints: [NSLayoutConstraint]
    switch layoutAnchor {
    case let .top(padding):
      constraints = [
        topAnchor.constraint(equalTo: view.topAnchor),
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ]
    case let .bottom(padding):
      constraints = [
        bottomAnchor.constraint(equalTo: view.bottomAnchor),
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ]
    case .center:
      constraints = [
        centerXAnchor.constraint(equalTo: view.centerXAnchor),
        centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ]
    }
    NSLayoutConstraint.useAndActivate(constraints)
  }

  func pinToSuperview(insets: UIEdgeInsets = .zero) {
    guard let superview = superview else {
      fatalError("View has no superview")
    }
    translatesAutoresizingMaskIntoConstraints = false

    let constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
    constraint.priority = .init(999)
    NSLayoutConstraint.activate(
      [
        topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
        constraint,
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
      ]
    )
  }
}
