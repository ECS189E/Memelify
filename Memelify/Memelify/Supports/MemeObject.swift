//
//  MemeObject.swift
//  Memelify
//
//  Created by David Garwood on 11/22/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class MemeObject {
    //var picture: UIImage?
    var id: String?
    var date: String?
    var title: String?
    var likes: Int
    var url: String?
    var image: UIImage?
    
    init(id: String, created: String, title: String, likes: Int, pic: Data){
        self.id = id
        self.date = created
        self.title = title
        self.likes = likes
        self.image = UIImage(data: pic)
    }
    
}
