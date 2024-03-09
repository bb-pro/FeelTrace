//
//  StatsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 9/3/2024.
//

import UIKit

final class StatsVC: BaseViewController, StatsViewDelegate {
   
    
    
    private var contentView: StatsView {
        view as? StatsView ?? StatsView()
    }
    
    override func loadView() {
        view = StatsView()
        contentView.profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
        contentView.delegate = self
    }
    
    func selectedMonth(indexPath: IndexPath) {
        print(months[indexPath.item])
    }
    
    // MARK: - Actions
    
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
}
