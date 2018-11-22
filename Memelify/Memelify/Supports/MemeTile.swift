//
//  MemeTile.swift
//  Memelify
//
//  Created by Will J on 11/16/18.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit

class MemeTile: UITableViewCell {

    @IBOutlet weak var karma: UILabel!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var favorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func displayImage(address: String) {
        if let url = URL(string: address) {
            imageView?.contentMode = .scaleAspectFit
            downloadImage(from: url)
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView?.image = UIImage(data: data)
            }
        }
    }

}
