//
//  MemeDataSource.swift
//  Memelify
//
//  Created by Dat on 12/9/18.
//  Copyright © 2018 Memelify. All rights reserved.
//
import Foundation
import UIKit

protocol MemeListDelegate {
    func initData()
    func loadMoreData()
}


/// In order to make a reusable TableView, one solution is to separate UITableViewSource from UIViewController
class MemeDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {

    var memes: [Meme] = []
    var favorites: [String?] = []
    var delegate: MemeListDelegate?
    

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MemeTilePrototype",
            for: indexPath
        ) as! MemeViewCell
        cell.configure(at: indexPath.row, with: meme)
        self.favorites = UserDefaults.standard.stringArray(forKey: "favs")!
        return cell
    }


    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.cellForRow(at: indexPath)?.imageView?.frame else {return 400}
        let ratio = CGFloat(cell.width / cell.height)
        return (cell.width / ratio)
    }


    // Adds more memes once the user scrolls to the bottom of the table
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = 100
        let scrollPosition = scrollView.contentOffset.y

        if scrollPosition > bottom - buffer {
            print("Loading more data")
            self.delegate?.loadMoreData()
        }
    }
}
