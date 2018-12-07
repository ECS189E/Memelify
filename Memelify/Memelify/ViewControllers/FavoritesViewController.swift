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
    var favorites: [String] = []
    var darkMode: DarkMode?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return memes[indexPath.row].height!
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = memes[indexPath.row].image
        memes[indexPath.row].height = (memes[indexPath.row].image?.size.height)! + CGFloat(40)
        let ratio = currentImage!.cropRatio()
        return (tableView.frame.width / ratio) + 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTilePrototype", for: indexPath) as! MemeTile
        cell.memeSharingDelegate = self
        cell.favrefreshDelegate = self
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

        imageView.image = UIImage(named: "Memelify-transparent.png")
        imageView.tintColor = UIColor.white
        navigationItem.titleView = imageView

        getFavorites()

        print(favorites)
    }

    // makes a series of api calls to fetch the favorited memes and saves them to the device
    func getFavorites() {
        favorites = UserDefaults.standard.stringArray(forKey: "favs")!

        // currentIDs are all the meme IDs being displayed in the memeTable
        let currentIDs = memes.map { $0.id! }
        // idsToAdd are the meme IDs that need to be displayed in the memeTable but aren't currently
        let idsToAdd = Set(favorites).subtracting(Set(currentIDs))
        // idsToRemove are the meme IDs that are in the memeTable, but need to be removed
        let idsToRemove = Set(currentIDs).subtracting(Set(favorites))

        // Once the the state that memeTable should, we reload the memeTable
        memes.removeAll(where: { idsToRemove.contains($0.id!) })
        DispatchQueue.main.async {
            self.memeTable.reloadData()
        }

        for ids in idsToAdd {
            Alamofire.request("https://memelify.herokuapp.com/api/memes/" + ids).responseJSON { response in
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

                            if self.memes.contains(where: { $0.id == id }) {
                                return
                            } else {
                                self.memes.append(newMeme)
                            }
                            self.memeTable.reloadData()
                        }
                    }
                }
            }
        }
    }

    func refreshFavs(row: Int) {
        getFavorites()
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "grumpyCat")
    }
}
