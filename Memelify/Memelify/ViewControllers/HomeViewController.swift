//
//  ViewController.swift
//  Memelify
//
//  Created by Will J on 11/15/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var memeTable: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tile = MemeTile()
        tile.displayImage(address: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg")
        return tile
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        memeTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Shows Memelify logo on the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit

        imageView.image = UIImage(named: "Memelify-transparent.png")
        navigationItem.titleView = imageView
    }

}

