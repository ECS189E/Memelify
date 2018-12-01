//
//  SettingsViewController.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var darkTheme: UISegmentedControl!
    var darkMode: DarkMode?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.darkMode = DarkMode(navigationController: navigationController!, tabBarController: tabBarController!, views: [tableView])

        self.navigationItem.title = "Settings"

        // Add Observers for dark theme
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)

        if DarkMode.isEnabled() {
            darkTheme.selectedSegmentIndex = 0
        } else {
            darkTheme.selectedSegmentIndex = 1
        }
    }

    @objc private func darkModeEnabled(_ notification: Notification) {
        self.tableView.reloadData()
    }

    @objc private func darkModeDisabled(_ notification: Notification) {
        self.tableView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }


    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if DarkMode.isEnabled() {
            cell.backgroundColor = UIColor.black
        } else {
            cell.backgroundColor = UIColor.white
        }
    }

    @IBAction func toggleDarkMode(_ sender: Any) {
        if darkTheme.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(true, forKey: "darkModeEnabled")

            // Post the notification to let all current view controllers that the app has changed to dark mode, and they should theme themselves to reflect this change.
            NotificationCenter.default.post(name: .darkModeEnabled, object: nil)
        } else {
            UserDefaults.standard.set(false, forKey: "darkModeEnabled")

            // Post the notification to let all current view controllers that the app has changed to non-dark mode, and they should theme themselves to reflect this change.
            NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
        }
    }
}
