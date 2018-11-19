//
//  AppDelegate.swift
//  FreestarBannerApp
//
//  Created by Dean Chang on 4/21/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

import UIKit
import FSAdSDK
import FSCommon
import PrebidMobileFS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager = CLLocationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Override point for customization after application launch.
        /// set SDK log level
        PBLogManager.setPBLogLevel(PBLogLevel.off)
        FSLogManager.setFSLogLevel(FSLogLevel.off)
        
        /// location aware advertisement, optional
        setupLocationManager()
        /// additional targeting, optional
//        applyTargeting()
        
        // Freestar app registration
        FSRegistration.register()
        
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
    
    func applyTargeting() {
        PBTargetingParams.sharedInstance().age = 35;
        PBTargetingParams.sharedInstance().gender = PBTargetingParamsGender.male;
        PBTargetingParams.sharedInstance().setUserKeywords("country", withValues: ["united states"])
        PBTargetingParams.sharedInstance().setUserKeywords("race", withValues: ["asian", "hispanic"])
        PBTargetingParams.sharedInstance().setUserKeywords("block", withValue:"fsdirect")
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        PBTargetingParams.sharedInstance().location = locations.last
    }
}

