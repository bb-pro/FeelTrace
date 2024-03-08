//
//  StatsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class StatsVC: BaseViewController {
    
    private var contentView: StatsView {
        view as? StatsView ?? StatsView()
    }
    
    override func loadView() {
        view = StatsView()
        contentView.profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
}
