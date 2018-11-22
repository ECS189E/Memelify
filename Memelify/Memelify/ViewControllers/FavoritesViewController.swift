//
//  FavoritesViewController.swift
//  Memelify
//
//  Created by Kauana dos Santos on 11/21/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Shows Memelify logo on the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit

        imageView.image = UIImage(named: "Memelify-transparent.png")
        navigationItem.titleView = imageView
    }
}
