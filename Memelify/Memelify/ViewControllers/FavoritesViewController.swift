//
//  FavoritesViewController.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Alamofire

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MemeSharingProtocol, refreshProtocol, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var memeTable: UITableView!

    var memes = [MemeObject]()
    var favorites: [String?] = []
    var darkMode: DarkMode?
    var count = 0

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = memes[indexPath.row].image
        let ratio = currentImage!.cropRatio()
        return (tableView.frame.width / ratio) + 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTilePrototype", for: indexPath) as! MemeTile

        self.favorites = UserDefaults.standard.stringArray(forKey: "test")!
        cell.memeSharingDelegate = self
        cell.favrefreshDelegate = self
        cell.fav = true
        cell.obj = memes[indexPath.row]
        cell.meme.image = memes[indexPath.row].image
        cell.karma.text = String(memes[indexPath.row].likes ?? 0)
        cell.favorite.setImage(UIImage(named: "selected-heart"), for: .normal)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // For DZNEmptyDataSet
        memeTable.emptyDataSetSource = self
        memeTable.emptyDataSetDelegate = self
        memeTable.tableFooterView = UIView()

        self.darkMode = DarkMode(navigationController: navigationController!, tabBarController: tabBarController!, views: [memeTable])

        memeTable.dataSource = self
        memeTable.delegate = self
        getFavorites()
    }

    // Shows Memelify logo in the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        //memeTable.reloadData()
        imageView.image = UIImage(named: "Memelify-transparent.png")
        imageView.tintColor = UIColor.white
        navigationItem.titleView = imageView

        getFavorites()
        self.memeTable.reloadData()
        print(favorites)
    }

    func getFavorites() {
        self.memes.removeAll()
        favorites = UserDefaults.standard.stringArray(forKey: "test")!
        print(favorites.count)
        for ids in favorites {

            Alamofire.request("https://memelify.herokuapp.com/api/memes/" + ids!).responseJSON { response in

                if let json = response.result.value as? [String: Any] {
                    guard let url = URL(string: json["url"] as! String) else {
                        print("no url")
                        return
                    }

                    let id = json["id"] as? String
                    let date = json["created"] as? String
                    let title = json["title"] as? String
                    let likes = json["likes"] as? Int

                    self.getData(from: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            let newMeme = MemeObject(id: id!, created: date!, title: title!, likes: likes!, pic: data)
                            print(self.memes)

                            if !self.memes.contains(newMeme) {
                                self.memes.append(newMeme)
                            }

                            self.memeTable.reloadData()
                        }
                    }
                }
            } //end of alamofire request
        }
    }

    func refreshFavs(id: String) {
        getFavorites()
        self.memeTable.reloadData()
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "grumpyCat")
    }

    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        let ac = UIAlertController(title: "Button tapped!", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hurray", style: .default))
        present(ac, animated: true)
    }
}
