//
//  AppDelegate.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        let user = Auth.auth().currentUser
        var navigationContoller: UIViewController? = nil
        if (user == nil) {
            navigationContoller = UINavigationController(rootViewController: LoginController())
        } else {
            navigationContoller = TabBarViewController()
        }
        
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

