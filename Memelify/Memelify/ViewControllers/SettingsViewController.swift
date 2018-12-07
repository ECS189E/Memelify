//
//  SettingsViewController.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Alamofire


class SettingsViewController: UITableViewController {

    @IBOutlet weak var darkTheme: UISegmentedControl!
    @IBOutlet weak var memeNotifcationToggle: UISegmentedControl!

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

    // Display Settings
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

    @IBAction func toggleMemeofTheDay(_ sender: Any) {
        if memeNotifcationToggle.selectedSegmentIndex == 0 {
            Alamofire.request("https://memelify.herokuapp.com/api/memes/notification?enable=1")
        } else {
            Alamofire.request("https://memelify.herokuapp.com/api/memes/notification?enable=0")
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

    // General Settings
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 2 {

            // Invite friends
            if indexPath.row == 0 {
                self.share(message: "Come see us at https://github.com/ECS189E/Memelify !!")
                // Rate us
            } else if indexPath.row == 1 {
                let feedbackController = SMFeedbackViewController(survey: "JL895DP")

                feedbackController?.cancelButtonTintColor = UIColor(red: 0, green: 133/255, blue: 145/255, alpha: 1.0)
                feedbackController?.title = "Memelify Survey"
                feedbackController?.present(from: self, animated: true, completion: nil)
                // About Us
            } else {
                self.performSegue(withIdentifier: "AboutUsSegue", sender: self)
            }
        }
    }

    func share(message: String) {
        print("Inviting friends")
        let friendVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        friendVC.popoverPresentationController?.sourceView = self.view
        self.present(friendVC, animated: true, completion: nil)
    }
}
