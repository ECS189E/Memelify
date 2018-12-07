//
//  AppDelegate.swift
//  Memelify
//
//  Created by William, Kauana and Dat.
//  Copyright © 2018 Memelify. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    // a hack for demo purpose.
    // Run notification service periodically.
    var TimerFunc: Timer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
            print("granted: \(granted)")
        }
        UNUserNotificationCenter.current().delegate = self
        self.TimerFunc = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(AppDelegate.scheduleNotifications), userInfo: nil, repeats: true)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
                // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if DarkMode.isEnabled() {
            NotificationCenter.default.post(name: .darkModeEnabled, object: nil)
        } else {
            NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // ====================
    // Notification Handler
    // ====================

    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // For handling tap and user actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
            case "memeOfTheDay":
                print("Notify Meme of The Day")
            default:
                break
        }
        completionHandler()
    }


    @objc func scheduleNotifications() {
        let api = "https://memelify.herokuapp.com/api/memes/top"
        Alamofire.request(api).responseJSON { response in
            if let meme = response.result.value as? [String: Any] {
                guard let meme_url = meme["url"] else {
                    print("Notifcation service is not enabled. Skipping")
                    return
                }
                let url = URL(string: meme_url as! String)
                let identifier = "memelifyIdentifier"
                let description = meme["title"] as? String
                DispatchQueue.main.async() {
                    let content = UNMutableNotificationContent()
                    content.badge = 1
                    content.title = "Meme of The Day"
                    content.body = description!
                    content.sound = UNNotificationSound.default

                    // If you want to attach any image to show in local notification
                    let task = URLSession.shared.dataTask(with: url!) { (data, resp, error) in
                        guard let data = data, error == nil else { return }
                        let myImage = UIImage(data: data)
                        if let attachment = UNNotificationAttachment.create(identifier: identifier, image: myImage!, options: nil) {
                            content.attachments = [attachment]
                        }
                        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.1, repeats: false)
                        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    }
                    task.resume()
                    print("Notification was sent")
                }
            }
        }
    }
}

