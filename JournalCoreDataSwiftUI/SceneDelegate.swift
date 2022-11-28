//
//  SceneDelegate.swift
//  JournalCoreDataSwiftUI
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Création du ContentView dans le viewContext
         let context = CoreDataStack.shared.container.viewContext
        let contentView = ContentView().environment(\.managedObjectContext, context)
        
  

        // Utilisation d'un UIHostingController en tant que contrôleur de fenêtres
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // À l'instanciation de la scène
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // À l'activation de la scène
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // À la désactivation de la scène
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // À la mise en avant de la scène
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // À la mise en arrière plan de la scène
    }

}

