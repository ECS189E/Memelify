//
//  ViewController.swift
//  Memelify
//
//  Created by Will J on 11/15/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var memeTable: UITableView!

    var memes = [UIImage]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = memes[indexPath.row]
        let ratio = currentImage.cropRatio()
        return (tableView.frame.width / ratio) + 40
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTilePrototype", for: indexPath) as! MemeTile
        cell.meme.image = memes[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        memeTable.dataSource = self
        memeTable.delegate = self

        // https://memelify.herokuapp.com/api/memes/latest
        if let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg") {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.memes.append(UIImage(data: data)!)
                    self.memeTable.reloadData()
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

extension UIImage {
    func cropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}
