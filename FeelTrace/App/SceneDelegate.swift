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
        let data = userDefaultsManager.getOnboardingData()
    
        if data.name == "" {
            window?.rootViewController = OnboardingVC()
        } else {
            window?.rootViewController = TabBarController()
        }
        window?.makeKeyAndVisible()

        
        
    }

}

