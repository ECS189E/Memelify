//
//  TrendingViewController.swift
//  Memelify
//
//  Created by Kauana dos Santos on 11/21/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Alamofire

class TrendingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let apiServer = "https://memelify.herokuapp.com/api/memes/top"
    
    @IBOutlet weak var memeTable: UITableView!
    
    
    var memes = [MemeObject]()
    var favorites = [MemeObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = memes[indexPath.row].image
        let ratio = currentImage!.cropRatio()
        return (tableView.frame.width / ratio) + 40
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTilePrototype", for: indexPath) as! MemeTile
        cell.obj = memes[indexPath.row]
        cell.meme.image = cell.obj?.image
        cell.karma.text = "Karma: " + String(cell.obj?.likes ?? 0)
        if cell.findOutFav() {
            cell.favorite.setImage(UIImage(named: "selected-heart"), for: .normal)
        }else {
            cell.favorite.setImage(UIImage(named: "unselected-heart"), for: .normal)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTable.dataSource = self
        memeTable.delegate = self
        
        Alamofire.request(apiServer).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                guard let memes = json["memes"] as? [[String: Any]] else {
                    return
                }
                
                for meme in memes {
                    guard let url = URL(string: meme["url"] as! String) else {
                        continue
                    }
                    let id = meme["id"] as? String
                    let date = meme["created"] as? String
                    let title = meme["title"] as? String
                    let likes = meme["likes"] as? Int
                    
                    self.getData(from: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            let newMeme = MemeObject(id: id!,created: date!,title: title!,likes: likes!,pic: data)
                            self.memes.append(newMeme)
                            self.memeTable.reloadData()
                        }
                    }
                }
                
            }
        }
        
    }
    
    // Shows Memelify logo on the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "Memelify-transparent.png")
        navigationItem.titleView = imageView
    }
}