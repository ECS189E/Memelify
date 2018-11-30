//
//  DarkMode.swift
//  Memelify
//
//  Created by Kauana dos Santos on 11/28/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import Foundation
import UIKit

class DarkMode {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var views: [UIView]

    init(navigationController: UINavigationController, tabBarController: UITabBarController, views: [UIView]) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.views = views

        NotificationCenter.default.addObserver(self, selector: #selector(enabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disabled(_:)), name: .darkModeDisabled, object: nil)


        if DarkMode.isEnabled() {
            NotificationCenter.default.post(name: .darkModeEnabled, object: nil)
        } else {
            NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }

    static func isEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "darkModeEnabled")
    }

    @objc private func enabled(_ notification: Notification) {
        for view in views {
            view.backgroundColor = UIColor.black
            view.tintColor = UIColor.white
        }

        navigationController.navigationBar.barTintColor = UIColor.black
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        tabBarController.tabBar.barStyle = .black
        tabBarController.tabBar.tintColor = UIColor.white
        tabBarController.tabBar.unselectedItemTintColor = UIColor.lightGray
    }

    @objc private func disabled(_ notification: Notification) {
        for view in views {
            view.backgroundColor = UIColor.white
            view.tintColor = UIColor.black
        }

        navigationController.navigationBar.barTintColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.tintColor = UIColor.black
        tabBarController.tabBar.unselectedItemTintColor = UIColor.darkGray

    } }
