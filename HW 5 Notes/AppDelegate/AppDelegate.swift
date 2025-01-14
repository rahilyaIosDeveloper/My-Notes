//
//  AppDelegate.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 27/4/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let savedLanguageString = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let savedLanguage = LanguageType(rawValue: savedLanguageString) {
            AppLanguageManager.shared.setAppLanguage(languageType: savedLanguage)
        } else {
            AppLanguageManager.shared.setAppLanguage(languageType: .en)
        }
        return true
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

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as! Error
                fatalError(error.localizedDescription)
            }
        }
    }
}


