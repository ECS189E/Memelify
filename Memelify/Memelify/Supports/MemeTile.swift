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
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var favorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
