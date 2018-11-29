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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
    }
}
