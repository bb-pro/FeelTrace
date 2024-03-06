//
//  WorkoutsVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 5/3/2024.
//

import UIKit

final class WorkoutsVC: BaseViewController, AddArticleVCDelegate {
  
    private var contentView: WorkoutsView {
        view as? WorkoutsView ?? WorkoutsView()
    }
    
    private var workouts = CoreDataManager.shared.fetchArticles() {
        didSet {
            contentView.centerStack.isHidden = !workouts.isEmpty
            contentView.addWorkoutBtn.isHidden = workouts.isEmpty
            contentView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = WorkoutsView()
        contentView.profileButton.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
        contentView.addButton.actionButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        contentView.addWorkoutBtn.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        workouts = CoreDataManager.shared.fetchArticles()
        contentView.tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func addPressed() {
        let addArticleVC = AddArticleVC()
        addArticleVC.delegate = self
        present(addArticleVC, animated: true)
    }
    
    @objc func profilePressed() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
    
    func addArticleVCDidDismiss() {
        workouts = CoreDataManager.shared.fetchArticles()
    }
    
}

// MARK: - UITableView DataSource and Delegate methods
extension WorkoutsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutCell.id, for: indexPath) as! WorkoutCell
        let workout = workouts[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: workout)
        return cell
    }
    
    
}
