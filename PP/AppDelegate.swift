//
//  AppDelegate.swift
//  PP
//
//  Created by Максим Храбрый on 10.03.2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Realm.Configuration.defaultConfiguration.schemaVersion = 20
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RegistrationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

