//
//  AppDelegate.swift
//  Yalp
//
//  Created by Bill on 10/12/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JsonDownloaderDelegate {

     
    var window: UIWindow?
    let downloader = JsonDownloader()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dlog("")
        
        downloader.delegate = self
        downloader.doAuthToken()
        
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    func jsonDownloaderDidFinish(downloader: JsonDownloader, json: [String:AnyObject]?, response: HTTPURLResponse, error: NSError?)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if error != nil {
            dlog("err: \(error)")
            
        }
        else {
            
            if let jsonObj: [String:AnyObject] = json {
                let token = jsonObj["access_token"] as! String
                let expires = jsonObj["expires_in"] as! Int
                dlog("token: \(token)")
                dlog("expires in: \(expires) seconds")
                yelpCurrentAuthToken = token
                yelpCurrentAuthTokenExpires = expires
                
            }
            else {
                dlog("no json")
                
            }
        }
        if let urlString = response.url?.absoluteString {
            dlog("url from response: \(urlString)")
            
        }
    }

}

