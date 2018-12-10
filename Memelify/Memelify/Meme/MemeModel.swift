//
//  Meme.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
import UIKit


struct Meme : Codable {
    let id: String
    let title: String
    let likes: Int
    let url: URL
    let created: String
}


struct MemeList: Codable {
    enum CodingKeys: String, CodingKey {case list = "memes"}
    let list: [Meme]
}
