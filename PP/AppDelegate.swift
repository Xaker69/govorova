//
//  AppDelegate.swift
//  PP
//
//  Created by Максим Храбрый on 10.03.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Database")
        //Имя контейнера должно совпадать с моделью данных, которые мы создадим

        //К модели подгружается само хранилище
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        //Контекст это среда, которая отвечает за координацию объектов и их сохранения

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RegistrationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

