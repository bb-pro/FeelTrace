//
//  WorkoutsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import UIKit

final class WorkoutsVC: BaseViewController {

    private var contentView: WorkoutsView {
        view as? WorkoutsView ?? WorkoutsView()
    }
    
    override func loadView() {
        view = WorkoutsView()
        contentView.profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
}
