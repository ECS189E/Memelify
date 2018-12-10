//
//  TrendingViewController.swift
//  Memelify
//
//  Created by Kauana, William and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit


class TrendingViewController: UIViewController, MemeListDelegate, MemeViewCellDelegate {

    @IBOutlet weak var memeTable: UITableView!
    var offset = 0
    var darkMode: DarkMode?
    var dataManager = MemeDataManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.delegate = self
        memeTable.dataSource = self.dataManager
        memeTable.delegate = self.dataManager
        
        self.darkMode = DarkMode(navigationController: navigationController!, tabBarController: tabBarController!, views: [memeTable])
        initData()
    }

    
    // Shows Memelify logo on the navigation bar
    override func viewDidAppear(_ animated: Bool) {
        self.dataManager.favorites = UserDefaults.standard.stringArray(forKey: "favs")!
        self.memeTable.reloadData()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Memelify-transparent.png")
        navigationItem.titleView = imageView
    }


    // MARK: - Meme Downloader Delegate
    func initData() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        HerokuClient.shared.loadTrendingMemes(with: offset){ [weak self] MemeList in
            self?.dataManager.memes = MemeList
            self?.memeTable.reloadData()
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    func loadMoreData() {
        offset = offset + 10
        HerokuClient.shared.loadTrendingMemes(with: offset){ [weak self] MemeList in
            self?.dataManager.memes += MemeList
            self?.memeTable.reloadData()
        }
    }
}
