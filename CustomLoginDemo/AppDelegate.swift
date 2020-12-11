//
//  AppDelegate.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let ApplicationWillBecomeInactive = Notification.Name(rawValue: "ApplicationWillBecomeInactive")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyAwREGnG3kJ4gWEcWhZs28tNY-_Ypi1pW8")
        GMSPlacesClient.provideAPIKey("AIzaSyAwREGnG3kJ4gWEcWhZs28tNY-_Ypi1pW8")
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = self.window {
//            window.backgroundColor = UIColor.white
//            
//            let nav = UINavigationController()
//            let mainView = MapViewController()
//            nav.viewControllers = [mainView]
//            window.rootViewController = nav
//            window.makeKeyAndVisible()
//        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

