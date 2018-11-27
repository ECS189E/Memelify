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
    
    var fav = false
    var obj: MemeObject?
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        var favs = [MemeObject]()
        favs = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.object(forKey: "saved") as! Data) as! [MemeObject]
        
        // add favorite
        if(fav == false){
            fav = true
            
            let image = UIImage(named: "selected-heart")
            self.favorite.setImage(image, for: .normal)
            
            if favs.contains(where: {$0.id == self.obj!.id} ){
                return
            }
            
            favs.append(self.obj!)
            
            let updatedFavs = try? NSKeyedArchiver.archivedData(withRootObject: favs, requiringSecureCoding: false)
            UserDefaults.standard.set(updatedFavs, forKey: "saved")
            
            print(favs)
            
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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
