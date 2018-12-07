//
//  MemeObject.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//
// Source: http://ios-tutorial.com/how-to-save-array-of-custom-objects-to-nsuserdefaults/

import UIKit

class MemeObject: NSObject, NSCoding {

    var id: String?
    var date: String?
    var title: String?
    var likes: Int?
    var image: UIImage?
    var height: CGFloat?
    
    init(id: String, created: String, title: String, likes: Int, pic: Data) {
        self.id = id
        self.date = created
        self.title = title
        self.likes = likes
        self.image = UIImage(data: pic)
        self.height = 0
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
    
    // toString method for testing
    override var description: String {
        return self.title! + " " + self.date!
    }

}
