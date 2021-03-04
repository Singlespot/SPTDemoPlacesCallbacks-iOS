//
//  AppDelegate.swift
//  SPTDemoPlacesCallbacks
//
//  Created by Quentin Beaudouin on 25/02/2021.
//

import UIKit
import SPTProximityKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    static let testWorkCoord = CLLocationCoordinate2DMake(48.8743028, 2.3380769)
    static let testHomeCoord = CLLocationCoordinate2DMake(48.87147484693, 2.3367978315949)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        requestNotif()
        //First and last coord of GPX file (for test purpose ONLY)
        SPTTestPlacesCallbacks.setHomePlaceAtLat(AppDelegate.testHomeCoord.latitude, lng: AppDelegate.testHomeCoord.longitude)
        SPTTestPlacesCallbacks.setWorkPlaceAtLat(AppDelegate.testWorkCoord.latitude, lng: AppDelegate.testWorkCoord.longitude)
        
        let enterHomeConf = SPTPlaceVisitCallbackConfiguration()
        enterHomeConf.afterHourOftheDay = 0
        enterHomeConf.beforeHourOfTheDay = 24
        enterHomeConf.minHoursBetweenEvents = 0
        SPTProximityManager.setEnterHomeCallbackWith(enterHomeConf) { (placeCoord) in
            print("[SPT Demo] Enter Home ➡️ 🏠")
            AppDelegate.presentNotif(title: "[SPT Demo] Enter Home", message: "➡️ 🏠")
        }

        let exitWorkConf = SPTPlaceVisitCallbackConfiguration()
        exitWorkConf.afterHourOftheDay = 0
        exitWorkConf.beforeHourOfTheDay = 24
        exitWorkConf.minHoursBetweenEvents = 0
        SPTProximityManager.setExitWorkCallbackWith(exitWorkConf) { (placeCoord) in
            print("[SPT Demo] Exit  Work 🏢 ➡️")
            AppDelegate.presentNotif(title: "[SPT Demo] Exit Work", message: "🏢 ➡️")
        }

        SPTProximityManager.setApiKey(YOUR_API_KEY, secret: YOUR_API_SECRET)
        
        return true
    }
    
    func requestNotif() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]){ granted, error in }
    }
    
    static func presentNotif(title: String, message: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        let request = UNNotificationRequest(identifier: "SPTNotif", content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request)
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

