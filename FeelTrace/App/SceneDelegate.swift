//
//  SceneDelegate.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 4/3/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SceneDelegateDelegate {
    
    private let userDefaultsManager = UserDefaultsManager.shared
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let loadingViewController = SplashVC()
        loadingViewController.delegate = self
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = loadingViewController
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController() {
         // Check if the value exists in UserDefaults
         if let isFirstLaunch = UserDefaults.standard.value(forKey: "isFirstLaunch") as? Bool {
             // If it's the first launch, set the value to false and show onboarding
             if isFirstLaunch {
                 UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                 window?.rootViewController = OnboardingVC()
             } else {
                 // If it's not the first launch, directly navigate to the main part of the app
                 window?.rootViewController = TabBarController()
             }
         } else {
             // If the value doesn't exist, it's assumed to be the first launch
             UserDefaults.standard.set(false, forKey: "isFirstLaunch")
             window?.rootViewController = OnboardingVC()
         }
         window?.makeKeyAndVisible()
     }

}

