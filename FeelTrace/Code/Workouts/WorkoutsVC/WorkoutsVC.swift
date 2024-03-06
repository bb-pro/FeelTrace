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
        contentView.addButton.actionButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    
    // MARK: - Actions
    
    @objc func addPressed() {
        let addArticleVC = AddArticleVC()
        present(addArticleVC, animated: true)
    }
    
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
}

// MARK: - UITableView DataSource and Delegate methods
extension WorkoutsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutCell.id, for: indexPath) as! WorkoutCell
        return cell
    }
    
    
}
