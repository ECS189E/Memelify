//
//  MemeTile.swift
//  Memelify
//
//  Created by William, Dat, and Kauana.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

protocol refreshProtocol: class {
    func refreshFavs(id: String)
}

protocol MemeSharingProtocol {
    func share(meme: UIImage, message: String)
}

class MemeTile: UITableViewCell {

    @IBOutlet weak var meme: UIImageView!
    @IBOutlet weak var karma: UILabel!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var buttons: UIView!

    var fav = false
    var obj: MemeObject?
    var memeSharingDelegate: MemeSharingProtocol?
    weak var homerefreshDelegate: refreshProtocol?
    weak var trendingrefreshDelegate: refreshProtocol?
    weak var favrefreshDelegate: refreshProtocol?

    /// Adds current MemeTile object to local storage as a favorite Meme.
    /// - Parameters: sender: Any
    /// - Returns: None
    @IBAction func addToFavorites(_ sender: Any) {
        var favs = UserDefaults.standard.stringArray(forKey: "test")

        // add favorite
        if fav == false {
            fav = true

            let image = UIImage(named: "selected-heart")
            self.favorite.setImage(image, for: .normal)

            if (favs?.contains((self.obj?.id)!))! {
                print("found match")
                return
            } else {
                favs?.append((self.obj?.id)!)
            }

        // remove favorite
        } else {
            fav = false

            let image = UIImage(named: "unselected-heart")
            self.favorite.setImage(image, for: .normal)
            favs?.removeAll(where: { $0 == self.obj?.id })
        }

        UserDefaults.standard.set(favs, forKey: "test")
        if favrefreshDelegate == nil {
            print("delegate: not in favorites view")
        } else {
            self.favrefreshDelegate!.refreshFavs(id: (self.obj?.id)!)
            print("finished using fav delegate")
        }

        if homerefreshDelegate == nil {
            print("delegate: not in home view")
        } else {
            self.homerefreshDelegate!.refreshFavs(id: (self.obj?.id)!)
            print("finished using home delegate")
        }

        if trendingrefreshDelegate == nil {
            print("delegate: not in trending view")
        } else {
            self.trendingrefreshDelegate!.refreshFavs(id: (self.obj?.id)!)
            print("finished using trending delegate")
        }
        print(favs!)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        // Add Observers for dark theme
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }

    @objc private func darkModeEnabled(_ notification: Notification) {
        self.buttons.backgroundColor = UIColor.black
    }

    @objc private func darkModeDisabled(_ notification: Notification) {
        self.buttons.backgroundColor = UIColor.white
    }

    override func awakeFromNib() {
        if DarkMode.isEnabled() {
            self.buttons.backgroundColor = UIColor.black
        } else {
            self.buttons.backgroundColor = UIColor.white
        }

        super.awakeFromNib()
    }

    /// Pop-up a UIActivityViewController to share Meme object to other app
    /// - Parameters: sender: Any
    /// - Returns: None
    @IBAction func shareMeme(_ sender: Any) {
        print("Sharing Meme...")
        self.memeSharingDelegate?.share(meme: self.meme.image!, message: "From Memelify with ❤️")
    }
}
