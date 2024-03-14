//
//  ProfileVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit
import StoreKit

final class ProfileVC: BaseViewController {
    
    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    weak var delegate: SceneDelegateDelegate?
    
    override func loadView() {
        view = ProfileView()
        contentView.shareView.actionButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        contentView.rateView.actionButton.addTarget(self, action: #selector(ratePressed), for: .touchUpInside)
        contentView.usageProfileView.actionButton.addTarget(self, action: #selector(usageProfilePressed), for: .touchUpInside)
        contentView.resetView.actionButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        contentView.editButton.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func sharePressed() {
        let shareText = "CityDrive"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func ratePressed() {
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    @objc func usageProfilePressed() {
        
    }

    @objc func resetPressed() {
        let alertController = UIAlertController(title: "Reset Progress", message: "Are you sure you want to reset your progress? This action cannot be undone.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: "Reset", style: .destructive) { _ in
            CoreDataManager.shared.deleteAllData()
        }
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @objc func editPressed() {
        guard let topViewController = UIApplication.shared.keyWindow?.rootViewController?.topmostViewController() else {
            return
        }
        
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to edit?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            self.proceedWithEditing()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(editAction)
        
        // Present the alert from the topmost view controller
        topViewController.present(alert, animated: true)
    }
    
    func proceedWithEditing() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        let onboardingVC = OnboardingVC()
        
        sceneDelegate.window?.rootViewController = onboardingVC
        sceneDelegate.window?.makeKeyAndVisible()
    }


}

extension UIViewController {
    func topmostViewController() -> UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topmostViewController()
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topmostViewController() ?? self
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topmostViewController() ?? self
        }
        return self
    }
}
