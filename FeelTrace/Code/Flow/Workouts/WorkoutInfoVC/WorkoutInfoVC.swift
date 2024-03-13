//
//  WorkoutInfoVC.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 8/3/2024.
//

import UIKit

final class WorkoutInfoVC: BaseViewController {
    var workout: Workout!
    private let dataManager = CoreDataManager.shared
    
    private var contentView: WorkoutInfoView {
        return view as? WorkoutInfoView ?? WorkoutInfoView()
    }
    
    override func loadView() {
        view = WorkoutInfoView()
        contentView.configure(with: workout)
        contentView.deleteBtn.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        contentView.editBtn.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func deletePressed() {
        let alert = UIAlertController(title: "Delete Workout", message: "Are you sure you want to delete this workout?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.confirmDelete()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func editPressed() {
        let alert = UIAlertController(title: "Edit Workout", message: "Are you sure you want to edit this workout?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Edit", style: .destructive) { [weak self] _ in
            self?.confirmEdit()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func confirmDelete() {
        dataManager.deleteWorkout(workout)
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ModalDismissedNotification"), object: nil)
        }
    }
    
    private func confirmEdit() {
        let editVC = AddWorkoutVC()
        editVC.workout = workout
        present(editVC, animated: true)
    }

}
