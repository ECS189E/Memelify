//
//  ViewController.swift
//  Memelify
//
//  Created by Will J on 11/15/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memetile", for: indexPath) as! MemeTile
        
        let bordercolor = UIColor.white.cgColor
        
        //custom cell settings
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 20
        
        //uiimage meme settings
        cell.meme?.image = UIImage(named: "loading.jpg")
        cell.meme?.layer.borderWidth = 2
        cell.meme?.layer.borderColor = bordercolor
        
        //uilabel like settings
        cell.likes?.text = "Likes: " + String(Int.random(in: 10..<100))
        
        return cell
    }
    
    
    @IBOutlet weak var memeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

}

