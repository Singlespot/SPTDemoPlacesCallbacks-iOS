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
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CLLocationManager().requestLocation()
        
        //First and last coord of GPX file (for test purpose ONLY)
        SPTTestPlacesCallbacks.setHomePlaceAtLat(48.8743028, lng: 2.3380769)
        SPTTestPlacesCallbacks.setWorkPlaceAtLat(48.8663156, lng: 2.3218156)
        
        let enterHomeConf = SPTPlaceVisitCallbackConfiguration()
        enterHomeConf.afterHourOftheDay = 0
        enterHomeConf.beforeHourOfTheDay = 0
        enterHomeConf.minHoursBetweenEvents = 0
        SPTProximityManager.setEnterHomeCallbackWith(enterHomeConf) { (placeCoord) in
            presentNotif(title: "Welcome Home", message: "Home Enter notif triggered at \(placeCoord)")
        }
        
        let exitWorkConf = SPTPlaceVisitCallbackConfiguration()
        exitWorkConf.afterHourOftheDay = 0
        exitWorkConf.beforeHourOfTheDay = 0
        exitWorkConf.minHoursBetweenEvents = 0
        
        SPTProximityManager.setExitWorkCallbackWith(exitWorkConf) { (placeCoord) in
            presentNotif(title: "Adios Work", message: "Work Exit notif triggered at \(placeCoord)")
        }
        

        SPTProximityManager.setApiKey(<YOUR_API_KEY>, secret: <YOUR_API_SECRET>)
        
        return true
    }
    
    func presentNotif(title: String, message: String) {
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
         
        // Create the request object.
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

