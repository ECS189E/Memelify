//
//  FavoritesViewController.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Alamofire

class FavoritesViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, MemeListDelegate {


    @IBOutlet weak var memeTable: UITableView!

    var memes = [Meme]()
    var favorites: [String] = []
    var darkMode: DarkMode?
    var dataManager = MemeDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self

        // Init Datasource
        memeTable.dataSource = self.dataManager
        memeTable.delegate = self.dataManager
        

        // For DZNEmptyDataSet
        memeTable.emptyDataSetSource = self
        memeTable.emptyDataSetDelegate = self
        memeTable.tableFooterView = UIView()
        self.darkMode = DarkMode(navigationController: navigationController!, tabBarController: tabBarController!, views: [memeTable])
        initData()
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "grumpyCat")
    }

    // Shows Memelify logo in the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        self.dataManager.favorites = UserDefaults.standard.stringArray(forKey: "favs")!
        self.memeTable.reloadData()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit

        imageView.image = UIImage(named: "Memelify-transparent.png")
        imageView.tintColor = UIColor.white
        navigationItem.titleView = imageView

    }

    // MARK: - MemeList Delegate
    func initData() {
        self.getFavorites()
    }
    
    func loadMoreData() {
        self.getFavorites()
    }

    func getFavorites() {
        favorites = UserDefaults.standard.stringArray(forKey: "favs")!
        
        // All the meme IDs being displayed in the memeTable
        let currentIDs = self.dataManager.memes.map { $0.id }
        
        // meme IDs that need to be displayed in the memeTable but aren't currently
        let idsToAdd = Set(favorites).subtracting(Set(currentIDs))
        
        //  meme IDs that are in the memeTable, but need to be removed
        let idsToRemove = Set(currentIDs).subtracting(Set(favorites))
        
        print(currentIDs, idsToAdd, idsToRemove)
        
        // Once the the state that memeTable should, we reload the memeTable
        self.dataManager.memes.removeAll(where: { idsToRemove.contains($0.id) })
        DispatchQueue.main.async {
            self.memeTable.reloadData()
        }

        if idsToAdd.count > 0 {
            HerokuClient.shared.loadFavoriteMemes(with: idsToAdd){ [weak self] newFavoriteMemes in
                if self?.dataManager.memes.isEmpty == true {
                    self?.dataManager.memes = newFavoriteMemes
                } else {
                    self?.dataManager.memes += newFavoriteMemes
                }
                self?.memeTable.reloadData()
            }
        }
    }

}
