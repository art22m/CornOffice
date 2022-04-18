//
//  AppDelegate.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationContoller = UINavigationController(rootViewController: ViewController())
        
        window = UIWindow()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navigationContoller
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

