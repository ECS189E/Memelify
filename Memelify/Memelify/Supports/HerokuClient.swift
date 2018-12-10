//
//  APIClient.swift
//  
//
//  Created by Dat on 12/9/18.
//
import Foundation
import Alamofire


class HerokuClient {
    static var shared = HerokuClient()

    // Returns an array of Latest memes
    func loadLatestMemes(with offset: Int, completion: @escaping ([Meme]) -> Void) {
        request("https://memelify.herokuapp.com/api/memes/latest?offset=\(offset)&limit=10")
            .responseData(completionHandler: { (response) in
                if let data = response.result.value {
                    do {
                        let holder = try JSONDecoder().decode(MemeList.self, from: data)
                        DispatchQueue.main.async {
                            completion(holder.list)
                        }
                    } catch {
                        print(error)
                    }
                }
            })
    }
    
    // Returns an array of Trending memes
    func loadTrendingMemes(with offset: Int, completion: @escaping ([Meme]) -> Void) {
        request("https://memelify.herokuapp.com/api/memes/hot?offset=\(offset)&limit=10")
            .responseData(completionHandler: { (response) in
                if let data = response.result.value {
                    do {
                        let holder = try JSONDecoder().decode(MemeList.self, from: data)
                        DispatchQueue.main.async {
                            completion(holder.list)
                        }
                    } catch {
                        print(error)
                    }
                }
            })
    }
    

    // Returns an array of favorite memes
    func loadFavoriteMemes(with favoriteMemeIds: Set<String?>, completion: @escaping ([Meme])->Void) {
        var memes = [Meme]()
        var group = DispatchGroup()
        for favoriteID in favoriteMemeIds {
            group.enter()
            Alamofire.request("https://memelify.herokuapp.com/api/memes/\(favoriteID!)")
                .responseData(completionHandler: { (response) in
                    defer { group.leave() }
                    if let data = response.result.value {
                        do {
                            let meme = try JSONDecoder().decode(Meme.self, from: data)
                            memes.append(meme)
                        } catch {
                            print(error)
                        }
                    }
                })
        }
        group.notify(queue: .main) {
            completion(memes)
        }
    }
}
