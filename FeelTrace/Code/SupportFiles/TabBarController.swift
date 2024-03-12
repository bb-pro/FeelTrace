//
//  TabBarController.swift
//  
//
//  Created by . on 01/12/23.
//

import UIKit

final class TabBarController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbar()
        pushVC()
      
        if #available(iOS 15.0, *) {
            // Create a custom appearance instance
            let tabBarAppearance = UITabBarAppearance()

            // Apply the appearance to the tab bar
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
        }
    }

    
    private func setTabbar() {
      
        // Configure the appearance
        let appearance = tabBar.standardAppearance
        // Apply the appearance to the tab bar
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
        tabBar.tintColor = MyColors.tint.color
    }

    func pushVC() {
    
        let workoutVC = WorkoutsVC()
        workoutVC.tabBarItem.title = "Workout"
        workoutVC.tabBarItem.image = .tabIcon1
        let workoutsVCC = UINavigationController(rootViewController: workoutVC)
        
        let statisticsVC = StatsVC()
        statisticsVC.tabBarItem.title = "Statistics"
        statisticsVC.tabBarItem.image = .tabIcon2
        
        let notesVC = NotesVC()
        notesVC.tabBarItem.title = "Notes"
        notesVC.tabBarItem.image = .tabIcon3
        
        let postsVC = PostsVC()
        postsVC.tabBarItem.title = "Posts"
        postsVC.tabBarItem.image = .tabIcon4
        
        self.viewControllers = [workoutsVCC, statisticsVC, notesVC, postsVC]
    }
}
