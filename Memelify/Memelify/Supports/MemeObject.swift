//
//  MemeObject.swift
//  Memelify
//
//  Created by David Garwood on 11/22/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

//http://ios-tutorial.com/how-to-save-array-of-custom-objects-to-nsuserdefaults/

import UIKit

class MemeObject: NSObject, NSCoding {
    
    var id: String?
    var date: String?
    var title: String?
    var likes: Int?
    var image: UIImage?
    
    init(id: String, created: String, title: String, likes: Int, pic: Data){
        self.id = id
        self.date = created
        self.title = title
        self.likes = likes
        self.image = UIImage(data: pic)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.likes, forKey: "likes")
        aCoder.encode(self.image, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.date = aDecoder.decodeObject(forKey: "date") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.likes = (aDecoder.decodeObject(forKey: "likes") as? Int)!
        self.image = aDecoder.decodeObject(forKey: "image") as? UIImage
    }
    
    override var description: String {
        return self.title! + " " + self.date!
    }
    
}
