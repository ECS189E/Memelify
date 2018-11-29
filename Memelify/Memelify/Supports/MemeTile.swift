//
//  MemeTile.swift
//  Memelify
//
//  Created by Will J on 11/16/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

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

    /// Adds current MemeTile object to local storage as a favorite Meme.
    /// - Parameters: sender: Any
    /// - Returns: None
    @IBAction func addToFavorites(_ sender: Any) {
        
        var favs = [MemeObject]()
        favs = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "saved") as! Data) as! [MemeObject]
        
        // add favorite
        if(fav == false){
            fav = true
            
            let image = UIImage(named: "selected-heart")
            self.favorite.setImage(image, for: .normal)
            
//            if favs.contains(where: {$0.id == self.obj!.id} ){
//                return
//            }
            
            favs.append(self.obj!)
            
//            let updatedFavs = try? NSKeyedArchiver.archivedData(withRootObject: favs, requiringSecureCoding: false)
//            UserDefaults.standard.set(updatedFavs, forKey: "saved")
            
//            print(favs)
            
        // remove favorite
        } else {
            fav = false
            
            let image = UIImage(named: "unselected-heart")
            self.favorite.setImage(image, for: .normal)
           
            favs.removeAll(where: { $0.id==self.obj?.id})
        }
        
        let updatedFavs = try? NSKeyedArchiver.archivedData(withRootObject: favs, requiringSecureCoding: false)
        UserDefaults.standard.set(updatedFavs, forKey: "saved")
        print(favs)
    }
    
    func findOutFav () -> Bool {
        var favs = [MemeObject]()
        favs = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "saved") as! Data) as! [MemeObject]
        if favs.contains(where: {$0.id == self.obj!.id} ){
            return true
        }

        return false
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
    @IBAction func shareMeme(_ sender: Any){
        print("Sharing Meme...")
        self.memeSharingDelegate?.share(meme: self.meme.image!, message: "From Memelify with ❤️")
    }
}
