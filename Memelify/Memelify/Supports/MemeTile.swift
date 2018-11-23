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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
