//
//  MemeTile.swift
//  Memelify
//
//  Created by William, Dat, and Kauana.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

//allows other views to be updated when favorites button is clicked
protocol refreshProtocol: class {
    func refreshFavs(row: Int)
}

//allows memes to be shared 
protocol MemeSharingProtocol {
    func share(meme: UIImage, message: String)
}

class MemeTile: UITableViewCell {

    @IBOutlet weak var meme: UIImageView!
    @IBOutlet weak var karma: UILabel!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var buttons: UIView!

    var row = 0
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
        var favs = UserDefaults.standard.stringArray(forKey: "favs")

        // add favorite
        if fav == false {
            fav = true

            let image = UIImage(named: "selected-heart")
            self.favorite.setImage(image, for: .normal)
            let check = favs?.contains(where: { $0 == self.obj?.id })
            if check! {
                print("found match")
                return
            } else {
                favs?.append((self.obj?.id)!)
            }

        //remove favorite
        } else {
            fav = false

            let image = UIImage(named: "unselected-heart")
            self.favorite.setImage(image, for: .normal)
            favs?.removeAll(where: { $0 == self.obj?.id })
        }

        UserDefaults.standard.set(favs, forKey: "favs")

        //update all views so that favorites are synced automatically
        if favrefreshDelegate != nil {
            self.favrefreshDelegate!.refreshFavs(row: self.row)
            print("finished using fav delegate")
        }
        if homerefreshDelegate != nil {
            self.homerefreshDelegate!.refreshFavs(row: self.row)
            print("finished using home delegate")
        }
        if trendingrefreshDelegate != nil {
            self.trendingrefreshDelegate!.refreshFavs(row: self.row)
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

