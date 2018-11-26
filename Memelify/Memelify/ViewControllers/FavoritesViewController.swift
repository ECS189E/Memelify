//
//  FavoritesViewController.swift
//  Memelify
//
//  Created by Kauana dos Santos on 11/21/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let apiServer = "https://memelify.herokuapp.com/api/memes/latest"
   
    @IBOutlet weak var memeTable: UITableView!
    
    var memes = [MemeObject]()
    var favorites = [MemeObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = favorites[indexPath.row].image
        let ratio = currentImage!.cropRatio()
        return (tableView.frame.width / ratio) + 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTilePrototype", for: indexPath) as! MemeTile
        
        cell.obj = favorites[indexPath.row]
        cell.meme.image = favorites[indexPath.row].image
        cell.karma.text = "Karma: " + String(favorites[indexPath.row].likes ?? 0)
        cell.favorite.setImage(UIImage(named: "selected-heart"), for: .normal)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTable.dataSource = self
        memeTable.delegate = self
        
        favorites = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "saved") as! Data) as! [MemeObject]
    }
    
    // Shows Memelify logo on the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "Memelify-transparent.png")
        navigationItem.titleView = imageView
        
        favorites = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "saved") as! Data) as! [MemeObject]
        
        print(favorites)
        self.memeTable.reloadData()
    }
}
