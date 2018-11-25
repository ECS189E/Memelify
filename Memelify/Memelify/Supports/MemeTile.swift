//
//  MemeTile.swift
//  Memelify
//
//  Created by Will J on 11/16/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class MemeTile: UITableViewCell {

    @IBOutlet weak var meme: UIImageView!
    @IBOutlet weak var karma: UILabel!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var buttons: UIView!
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        var favs = [MemeObject]()
        let image = UIImage(named: "selected-heart")
        
        self.favorite.setImage(image, for: .normal)
        
        var favorites = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "saved") as! Data) as! [MemeObject]
        
        if favorites.count>0 {
            for meme in favorites {
                if self.obj?.id == meme.id {
                    return
                }
                favs.append(meme)
            }
        }
        
        favs.append(self.obj!)
    
        let updatedFavs = NSKeyedArchiver.archivedData(withRootObject: favs)
        UserDefaults.standard.set(updatedFavs, forKey: "saved")
        
        print(favs)
    }
    
    var obj: MemeObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
