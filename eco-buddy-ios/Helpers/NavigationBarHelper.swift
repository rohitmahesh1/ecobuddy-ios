//
//  NavigationBarHelper.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 11/10/23.
//

import UIKit
import SwiftUI

import SwiftUI

struct NavigationBarColor: UIViewControllerRepresentable {
    let color: UIColor

    init(_ color: UIColor) {
        self.color = color
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
