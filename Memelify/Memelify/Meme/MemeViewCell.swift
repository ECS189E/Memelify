//
//  MemeViewCell
//  Memelify
//
//  Created by William, Dat, and Kauana.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Kingfisher

protocol MemeViewCellDelegate: class {
    func share(meme: UIImage, message: String)
}


class MemeViewCell: UITableViewCell {
    
    @IBOutlet weak var meme: UIImageView!
    @IBOutlet weak var karma: UILabel!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var buttons: UIView!

    var row = 0
    var obj: Meme?
    weak var delegate: MemeViewCellDelegate?


    func configure(at row: Int, with data: Meme) {
        self.row = row
        self.obj = data
        self.meme.kf.setImage(with: data.url)
        self.karma.text = String(data.likes)
        self.favorite.setImage(UIImage(named: self.isFavorited() ? "selected-heart" : "unselected-heart"),
                               for: .normal)
    }

    
    // MARK: - Sharing a Meme Implementation
    @IBAction func shareMeme(_ sender: Any) {
        print("Click sharing..")
        self.delegate?.share(meme: self.meme.image!, message: "From Memelify with ❤️")
    }
    

    // MARK: - Dark Mode implementation
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

    override func awakeFromNib() {
        if DarkMode.isEnabled() {
            self.buttons.backgroundColor = UIColor.black
        } else {
            self.buttons.backgroundColor = UIColor.white
        }
        super.awakeFromNib()
    }

    @objc private func darkModeEnabled(_ notification: Notification) {
        self.buttons.backgroundColor = UIColor.black
    }

    @objc private func darkModeDisabled(_ notification: Notification) {
        self.buttons.backgroundColor = UIColor.white
    }


    // MARK: - Favorite a meme Implementation
    /// Adds current MemeCell object to local storage as a favorite Meme.
    @IBAction func addToFavorites(_ sender: Any) {
        guard var favs = UserDefaults.standard.stringArray(forKey: "favs") else { return }
        if !isFavorited() {
            let image = UIImage(named: "selected-heart")
            self.favorite.setImage(image, for: .normal)
            favs.append((self.obj?.id)!)
        } else {
            let image = UIImage(named: "unselected-heart")
            self.favorite.setImage(image, for: .normal)
            favs.removeAll(where: { $0 == self.obj?.id })
        }
        UserDefaults.standard.set(favs, forKey: "favs")
    }

    /// Validate if this Meme is existed in Favorite String Array
    func isFavorited() -> Bool {
        guard let favs = UserDefaults.standard.stringArray(forKey: "favs") else { return false }
        guard let id = self.obj?.id else { return false }
        return favs.contains(id)
    }
}

