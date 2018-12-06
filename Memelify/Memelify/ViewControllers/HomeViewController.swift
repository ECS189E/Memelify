//
//  HomeViewController.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MemeSharingProtocol, refreshProtocol {
    
    func refreshFavs(id: String) {
        self.memeTable.reloadData()
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HomeViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @IBOutlet weak var memeTable: UITableView!

    var newfavs : [String?] = []
    var memes = [MemeObject]()
    var darkMode : DarkMode?
    var offset = 0
    
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
        
        self.newfavs = UserDefaults.standard.stringArray(forKey: "test")!
        cell.obj = memes[indexPath.row]
        cell.meme.image = cell.obj?.image
        cell.homerefreshDelegate = self
        cell.karma.text = String(cell.obj?.likes ?? 0)
        if newfavs.contains(where: { $0 == cell.obj?.id}){
            cell.favorite.setImage(UIImage(named: "selected-heart"), for: .normal)
            cell.fav = true
        } else {
            cell.favorite.setImage(UIImage(named: "unselected-heart"), for: .normal)
        }

        cell.memeSharingDelegate = self
        return cell
    }

    //handles adding more memes once the user scrolls to the bottom of the table
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = 100
        let scrollPosition = scrollView.contentOffset.y
        
        // Reached the bottom of the list
        if scrollPosition > bottom - buffer {
            print("natural making additional request...")
            makeAdditionalRequest()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.darkMode = DarkMode(navigationController: navigationController!, tabBarController: tabBarController!, views: [memeTable])
        self.memeTable.addSubview(self.refreshControl)
        
        memeTable.dataSource = self
        memeTable.delegate = self
    
        if UserDefaults.standard.stringArray(forKey: "test") == nil {
            UserDefaults.standard.set(newfavs, forKey: "test")
        }else {
            self.newfavs = UserDefaults.standard.stringArray(forKey: "test")!
        }
        
        makeRequest(api: "https://memelify.herokuapp.com/api/memes/latest?offset=0&limit=10")
        
    }
    
    //makes a new api request to heroku but appends results instead of replacing them
    func makeAdditionalRequest() {
        //let bottomSpinner = self.memeTable.tableFooterView
        offset = offset+10
        
        let request = "https://memelify.herokuapp.com/api/memes/latest?offset="+String(offset)+"&limit=10"
        
        Alamofire.request(request).responseJSON { response in
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
                            let newMeme = MemeObject(id: id!, created: date!, title: title!, likes: likes!, pic: data)
                            self.memes.append(newMeme)
                            
                            self.memeTable.reloadData()
                            
                        }
                    }
                }
            }
        }
    }
    
    //makes a new api request to heroku but replaces results instead of appending them
    func makeRequest(api: String) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        Alamofire.request(api).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                guard let memes = json["memes"] as? [[String: Any]] else {
                    return
                }
                self.memes.removeAll()
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
                            let newMeme = MemeObject(id: id!, created: date!, title: title!, likes: likes!, pic: data)
                            self.memes.append(newMeme)
                            //self.newfavs.adding(newMeme)
                            self.memeTable.reloadData()
                            UIViewController.removeSpinner(spinner: sv)
                        }
                    }
                }
            }
        } //end of alamofire request
    }
    
    // Shows Memelify logo on the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        self.newfavs = UserDefaults.standard.stringArray(forKey: "test")!
        self.memeTable.reloadData()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Memelify-transparent.png")
        navigationItem.titleView = imageView
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        makeRequest(api: "https://memelify.herokuapp.com/api/memes/latest?offset=0&limit="+String(offset+10))
        self.memeTable.reloadData()
        refreshControl.endRefreshing()
    }
}

extension UIImage {
    func cropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}

extension MemeSharingProtocol where Self: UIViewController {
    func share(meme: UIImage, message: String) {
        let shareMemeVC = UIActivityViewController(activityItems: [meme, message], applicationActivities: nil)
        shareMemeVC.popoverPresentationController?.sourceView = self.view
        self.present(shareMemeVC, animated: true, completion: nil)
    }
}
