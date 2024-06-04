//
//  AppDelegate.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//
import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create the main window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Set the root view controller
        let rootView = ContentView()
        let hostingController = UIHostingController(rootView: rootView)
        window?.rootViewController = hostingController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Create a new scene configuration
        let sceneConfiguration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
        // Specify the scene class to use for the session
        sceneConfiguration.sceneClass = UIWindowScene.self
        
        // Specify the delegate class to use for the scene
        sceneConfiguration.delegateClass = SceneDelegate.self
        
        return sceneConfiguration
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to configure your scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create the main window
        window = UIWindow(windowScene: windowScene)
        
        // Set the root view controller
        let rootView = ContentView()
        let hostingController = UIHostingController(rootView: rootView)
        window?.rootViewController = hostingController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        

    }
}
